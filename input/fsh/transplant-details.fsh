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
* #d_r_weight_ratio                      "Donor/recipient weight ratio" "Ratio of donor to recipient body weight."
* #vessel_mismatch_d_r                   "Vessel mismatch (donor-recipient)" "Whether a donor-recipient vessel-size mismatch was present."
* #cold_ischemia_time                    "Cold ischemia time (minutes)" "Cold ischaemia time, in minutes."
* #time_diag_to_tx                       "Time from diagnosis to transplant (months)" "Time from primary diagnosis to transplant, in months."
* #warm_ischemia_time                    "Warm ischemia time (minutes)" "Warm ischaemia time, in minutes."
* #vascular_anomalies                    "Vascular anomalies (free text)" "Free-text description of vascular anomalies."
Profile: TransplantDetails
Parent: Observation
Id: transplant-details
Title: "Transplant Details"
Description: "Intraoperative and peri-operative details panel for a transplant, aligned with the DMv1.2 transplant table. Non-organ-specific detail fields are components of a single Observation linked to the Transplant Procedure via Observation.partOf. One instance per transplant. Organ-specific surgical fields are modelled separately: anastomoses as TransplantAnastomosis (Procedure) via Procedure.partOf, and intraoperative complications as IntraoperativeComplication (Condition) via Procedure.complicationDetail."

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
* performer = Reference(PCCenter1LaPaz)
* effectiveDateTime = "2023-08-15"

// time_diag_to_tx
* component[time_diag_to_tx].valueQuantity.value = 41
* component[time_diag_to_tx].valueQuantity.system = $ucum
* component[time_diag_to_tx].valueQuantity.code = #mo
* component[time_diag_to_tx].valueQuantity.unit = "months"

// d_r_weight_ratio
* component[d_r_weight_ratio].valueQuantity.value = 2.3
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
