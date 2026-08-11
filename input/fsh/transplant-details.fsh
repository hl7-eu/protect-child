// transplant-details.fsh
// Transplant intra-operative details as a single panel Observation with components,
// linked to the Transplant Procedure via Observation.partOf.
// One TransplantDetails resource per transplant.

Alias: $obs-cat = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $ucum    = http://unitsofmeasure.org

// ------------------------------------------------------
// Terminology – transplant detail codes + panel code
// ------------------------------------------------------

CodeSystem: TransplantDetailCS
Id: transplant-detail-cs
Title: "Transplant Detail CodeSystem"
Description: "Codes for transplant-level details captured as Observation components."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #transplant-details-panel              "Transplant details panel" "Panel grouping intraoperative transplant detail observations."
* #tx-type                               "Transplant type (liver / kidney / combined)" "Type of transplant (liver, kidney, or combined)."
* #d_r_weight_ratio                      "Donor/recipient weight ratio" "Ratio of donor to recipient body weight."
* #vessel_mismatch_d_r                   "Vessel mismatch (donor-recipient)" "Whether a donor-recipient vessel-size mismatch was present."
* #cold_ischemia_time                    "Cold ischemia time (minutes)" "Cold ischaemia time, in minutes."
* #time_diag_to_tx                       "Time from diagnosis to transplant (months)" "Time from primary diagnosis to transplant, in months."
* #warm_ischemia_time                    "Warm ischemia time (minutes)" "Warm ischaemia time, in minutes."
* #vascular_anomalies                    "Vascular anomalies (free text)" "Free-text description of vascular anomalies."
* #type_surgical_biliary_anastomosis     "Type of surgical biliary anastomosis" "Type of surgical biliary anastomosis performed."
* #intraoperative_complications          "Intraoperative complication" "Intraoperative complication that occurred."
* #intraoperative_complications_other    "Other intraoperative complications (free text)" "Free-text description of other intraoperative complications."
* #type_ureteral_graft_anastomosis       "Type of ureteral graft anastomosis" "Type of ureteral graft anastomosis performed."
* #other_type_ureteral_graft_anastomosis "Other type of ureteral graft anastomosis (free text)" "Free-text description of another ureteral anastomosis type."

ValueSet: TransplantDetailVS
Id: transplant-detail-vs
Title: "Transplant Detail ValueSet"
Description: "Allowed codes for transplant detail Observation components."
* ^experimental = true
* include codes from system TransplantDetailCS

// ------------------------------------------------------
// Organ-specific invariants
//
// All invariants operate within TransplantDetails because txType is carried
// as a mandatory component — no cross-resource resolve() required.
//
// Liver-applicable fields:  type_surgical_biliary_anastomosis,
//                           intraoperative_complications (bile-duct-injury, liver-ischemia)
// Kidney-applicable fields: type_ureteral_graft_anastomosis,
//                           other_type_ureteral_graft_anastomosis,
//                           intraoperative_complications (kidney-ischemia)
// Combined transplant:      both sets may be present
// ------------------------------------------------------

Invariant: pc-td-1
Description: "Biliary anastomosis type is only applicable for liver or combined transplants."
Severity: #error
Expression: "component.where(code.coding.code = 'type_surgical_biliary_anastomosis').exists() implies component.where(code.coding.code = 'tx-type').value.ofType(CodeableConcept).coding.where(code = 'liver' or code = 'combined').exists()"

Invariant: pc-td-2
Description: "Ureteral graft anastomosis type is only applicable for kidney or combined transplants."
Severity: #error
Expression: "component.where(code.coding.code = 'type_ureteral_graft_anastomosis').exists() implies component.where(code.coding.code = 'tx-type').value.ofType(CodeableConcept).coding.where(code = 'kidney' or code = 'combined').exists()"

Invariant: pc-td-3
Description: "Other ureteral graft anastomosis is only applicable for kidney or combined transplants."
Severity: #error
Expression: "component.where(code.coding.code = 'other_type_ureteral_graft_anastomosis').exists() implies component.where(code.coding.code = 'tx-type').value.ofType(CodeableConcept).coding.where(code = 'kidney' or code = 'combined').exists()"

Invariant: pc-td-4
Description: "Liver-specific intraoperative complications (bile-duct-injury, liver-ischemia) are only applicable for liver or combined transplants."
Severity: #error
Expression: "component.where(code.coding.code = 'intraoperative_complications').value.ofType(CodeableConcept).coding.where(code = 'bile-duct-injury' or code = 'liver-ischemia').exists() implies component.where(code.coding.code = 'tx-type').value.ofType(CodeableConcept).coding.where(code = 'liver' or code = 'combined').exists()"

Invariant: pc-td-5
Description: "Kidney-specific intraoperative complication (kidney-ischemia) is only applicable for kidney or combined transplants."
Severity: #error
Expression: "component.where(code.coding.code = 'intraoperative_complications').value.ofType(CodeableConcept).coding.where(code = 'kidney-ischemia').exists() implies component.where(code.coding.code = 'tx-type').value.ofType(CodeableConcept).coding.where(code = 'kidney' or code = 'combined').exists()"

// ------------------------------------------------------
// TransplantDetails panel profile
// ------------------------------------------------------

Profile: TransplantDetails
Parent: Observation
Id: transplant-details
Title: "Transplant Details"
Description: "Intraoperative and peri-operative details panel for a transplant, aligned with the DMv1.2 transplant table. All detail fields are components of a single Observation linked to the Transplant Procedure via Observation.partOf. One instance per transplant. The mandatory txType component carries the transplant type (liver / kidney / combined) so organ-specific invariants (pc-td-1 through pc-td-5) can be evaluated without cross-resource resolution."

// Apply organ-specific invariants
* obeys pc-td-1
* obeys pc-td-2
* obeys pc-td-3
* obeys pc-td-4
* obeys pc-td-5

// Link to parent Transplant Procedure
* partOf 1..1 MS
* partOf only Reference(Transplant)
* partOf ^short = "The Transplant Procedure these details belong to"

* status 1..1 MS
* status = #final (exactly)

* category 0..1 MS
* category = $obs-cat#procedure

* code 1..1 MS
* code = TransplantDetailCS#transplant-details-panel "Transplant details panel"

* subject 1..1 MS
* subject only Reference(PatientTransplant)

// ── Component slicing ──────────────────────────────────────────────────────

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component MS

// tx_type (M) — transplant type carried here to enable organ-specific invariants
// within the resource without requiring cross-resource resolve().
* component contains txType 1..1 MS
* component[txType].code = TransplantDetailCS#tx-type "Transplant type (liver / kidney / combined)"
* component[txType].value[x] only CodeableConcept
* component[txType].valueCodeableConcept from TransplantTypeVS (required)
* component[txType] ^short = "tx_type — transplant organ type; drives organ-specific field applicability"

// time_diag_to_tx (M) — months from diagnosis to transplant
* component contains time_diag_to_tx 0..1 MS
* component[time_diag_to_tx].code = TransplantDetailCS#time_diag_to_tx
* component[time_diag_to_tx].value[x] only Quantity
* component[time_diag_to_tx].valueQuantity.system = $ucum
* component[time_diag_to_tx].valueQuantity.code = #mo
* component[time_diag_to_tx] ^short = "time_diag_to_tx — months from primary diagnosis to transplant"

// d_r_weight_ratio (R) — dimensionless ratio
* component contains d_r_weight_ratio 0..1 MS
* component[d_r_weight_ratio].code = TransplantDetailCS#d_r_weight_ratio
* component[d_r_weight_ratio].value[x] only Quantity
* component[d_r_weight_ratio].valueQuantity.system = $ucum
* component[d_r_weight_ratio].valueQuantity.code = #1
* component[d_r_weight_ratio] ^short = "d_r_weight_ratio — donor/recipient weight ratio"

// vessel_mismatch_d_r (R) — boolean
* component contains vessel_mismatch_d_r 0..1 MS
* component[vessel_mismatch_d_r].code = TransplantDetailCS#vessel_mismatch_d_r
* component[vessel_mismatch_d_r].value[x] only boolean
* component[vessel_mismatch_d_r] ^short = "vessel_mismatch_d_r — vessel mismatch between donor and recipient"

// cold_ischemia_time (R) — minutes
* component contains cold_ischemia_time 0..1 MS
* component[cold_ischemia_time].code = TransplantDetailCS#cold_ischemia_time
* component[cold_ischemia_time].value[x] only Quantity
* component[cold_ischemia_time].valueQuantity.system = $ucum
* component[cold_ischemia_time].valueQuantity.code = #min
* component[cold_ischemia_time] ^short = "cold_ischemia_time — cold ischemia time (minutes)"

// warm_ischemia_time (R) — minutes
* component contains warm_ischemia_time 0..1 MS
* component[warm_ischemia_time].code = TransplantDetailCS#warm_ischemia_time
* component[warm_ischemia_time].value[x] only Quantity
* component[warm_ischemia_time].valueQuantity.system = $ucum
* component[warm_ischemia_time].valueQuantity.code = #min
* component[warm_ischemia_time] ^short = "warm_ischemia_time — warm ischemia time (minutes)"

// vascular_anomalies (R) — free text
* component contains vascular_anomalies 0..1 MS
* component[vascular_anomalies].code = TransplantDetailCS#vascular_anomalies
* component[vascular_anomalies].value[x] only string
* component[vascular_anomalies] ^short = "vascular_anomalies — vascular anomalies (free text)"

// type_surgical_biliary_anastomosis (R) — CodeableConcept; Liver only
* component contains type_surgical_biliary_anastomosis 0..1 MS
* component[type_surgical_biliary_anastomosis].code = TransplantDetailCS#type_surgical_biliary_anastomosis
* component[type_surgical_biliary_anastomosis].value[x] only CodeableConcept
* component[type_surgical_biliary_anastomosis].valueCodeableConcept from BiliaryAnastomosisTypeVS (required)
* component[type_surgical_biliary_anastomosis] ^short = "type_surgical_biliary_anastomosis — biliary anastomosis type (Liver only)"

// intraoperative_complications (R) — 0..* to support multiple complications per transplant
* component contains intraoperative_complications 0..* MS
* component[intraoperative_complications].code = TransplantDetailCS#intraoperative_complications
* component[intraoperative_complications].value[x] only CodeableConcept
* component[intraoperative_complications].valueCodeableConcept from IntraoperativeComplicationVS (required)
* component[intraoperative_complications] ^short = "intraoperative_complications — repeat per complication"

// intraoperative_complications_other (R) — free text
* component contains intraoperative_complications_other 0..1 MS
* component[intraoperative_complications_other].code = TransplantDetailCS#intraoperative_complications_other
* component[intraoperative_complications_other].value[x] only string
* component[intraoperative_complications_other] ^short = "intraoperative_complications_other — other complications (free text)"

// type_ureteral_graft_anastomosis (O) — CodeableConcept; Kidney only
* component contains type_ureteral_graft_anastomosis 0..1 MS
* component[type_ureteral_graft_anastomosis].code = TransplantDetailCS#type_ureteral_graft_anastomosis
* component[type_ureteral_graft_anastomosis].value[x] only CodeableConcept
* component[type_ureteral_graft_anastomosis].valueCodeableConcept from UreteralAnastomosisTypeVS (required)
* component[type_ureteral_graft_anastomosis] ^short = "type_ureteral_graft_anastomosis (Kidney only)"

// other_type_ureteral_graft_anastomosis (O) — free text
* component contains other_type_ureteral_graft_anastomosis 0..1 MS
* component[other_type_ureteral_graft_anastomosis].code = TransplantDetailCS#other_type_ureteral_graft_anastomosis
* component[other_type_ureteral_graft_anastomosis].value[x] only string
* component[other_type_ureteral_graft_anastomosis] ^short = "other_type_ureteral_graft_anastomosis — free text"

// ------------------------------------------------------
// Example — one instance covers the full transplant
// ------------------------------------------------------

Instance: TransplantDetailsExample1
InstanceOf: TransplantDetails
Usage: #example
Title: "Example Transplant Details"
Description: "Example transplant details panel for a liver transplant (DMv1.2)."

* partOf = Reference(TransplantExample1)
* status = #final
* category = $obs-cat#procedure
* code = TransplantDetailCS#transplant-details-panel "Transplant details panel"
* subject = Reference(ExamplePatientTransplant1)

// tx_type — mandatory; drives organ-specific invariants pc-td-1 through pc-td-5
* component[txType].code = TransplantDetailCS#tx-type "Transplant type (liver / kidney / combined)"
* component[txType].valueCodeableConcept = TransplantTypeCS#liver "Liver transplant"

// time_diag_to_tx
* component[time_diag_to_tx].valueQuantity.value = 24
* component[time_diag_to_tx].valueQuantity.system = $ucum
* component[time_diag_to_tx].valueQuantity.code = #mo
* component[time_diag_to_tx].valueQuantity.unit = "months"

// d_r_weight_ratio
* component[d_r_weight_ratio].valueQuantity.value = 0.95
* component[d_r_weight_ratio].valueQuantity.system = $ucum
* component[d_r_weight_ratio].valueQuantity.code = #1
* component[d_r_weight_ratio].valueQuantity.unit = "1"

// cold_ischemia_time
* component[cold_ischemia_time].valueQuantity.value = 480
* component[cold_ischemia_time].valueQuantity.system = $ucum
* component[cold_ischemia_time].valueQuantity.code = #min
* component[cold_ischemia_time].valueQuantity.unit = "min"

// warm_ischemia_time
* component[warm_ischemia_time].valueQuantity.value = 45
* component[warm_ischemia_time].valueQuantity.system = $ucum
* component[warm_ischemia_time].valueQuantity.code = #min
* component[warm_ischemia_time].valueQuantity.unit = "min"

// type_surgical_biliary_anastomosis (Liver only)
* component[type_surgical_biliary_anastomosis].valueCodeableConcept = BiliaryAnastomosisTypeCS#duct-to-duct "Duct-to-duct anastomosis"

// intraoperative_complications (one entry; repeat for multiple)
* component[intraoperative_complications][0].valueCodeableConcept = IntraoperativeComplicationCS#major-bleeding "Major bleeding"
