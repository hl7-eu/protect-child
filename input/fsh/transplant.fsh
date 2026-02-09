// transplant.fsh

// ------------------------------------------------------
// Terminology
// ------------------------------------------------------

// tx_type (Liver / Kidney / Combined)
CodeSystem: TransplantTypeCS
Id: transplant-type-cs
Title: "Transplant Type CodeSystem"
Description: "Type of solid-organ transplant (liver, kidney, combined liver-kidney)."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/transplant-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #liver    "Liver transplant"
* #kidney   "Kidney transplant"
* #combined "Combined liver-kidney transplant"

ValueSet: TransplantTypeVS
Id: transplant-type-vs
Title: "Transplant Type ValueSet"
Description: "Allowed transplant types."
* TransplantTypeCS#liver
* TransplantTypeCS#kidney
* TransplantTypeCS#combined

// type_surgical_biliary_anastomosis (Liver only)
CodeSystem: BiliaryAnastomosisTypeCS
Id: biliary-anastomosis-type-cs
Title: "Type of surgical biliary anastomosis CodeSystem"
Description: "Types of biliary anastomosis used in liver transplantation."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/biliary-anastomosis-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #duct-to-duct          "Duct-to-duct anastomosis"
* #choledochoenterostomy "Choledochoenterostomy"
* #bilioenteric          "Bilioenteric anastomosis"
* #roux-en-y             "Roux-en-Y hepaticojejunostomy"

ValueSet: BiliaryAnastomosisTypeVS
Id: biliary-anastomosis-type-vs
Title: "Type of surgical biliary anastomosis ValueSet"
Description: "Allowed types of biliary anastomosis in liver transplant."
* BiliaryAnastomosisTypeCS#duct-to-duct
* BiliaryAnastomosisTypeCS#choledochoenterostomy
* BiliaryAnastomosisTypeCS#bilioenteric
* BiliaryAnastomosisTypeCS#roux-en-y

// intraoperative_complications (Liver only)
CodeSystem: IntraoperativeComplicationCS
Id: intraoperative-complication-cs
Title: "Intraoperative Complications CodeSystem"
Description: "Intraoperative complications during liver transplantation."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/intraoperative-complication"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #major-bleeding   "Major bleeding"
* #bile-duct-injury "Bile duct injury"
* #vessel-injury    "Vessel injury"
* #liver-ischemia   "Liver ischemia"
* #other            "Other complication"

ValueSet: IntraoperativeComplicationVS
Id: intraoperative-complication-vs
Title: "Intraoperative Complications ValueSet"
Description: "Allowed intraoperative complications during liver transplantation."
* IntraoperativeComplicationCS#major-bleeding
* IntraoperativeComplicationCS#bile-duct-injury
* IntraoperativeComplicationCS#vessel-injury
* IntraoperativeComplicationCS#liver-ischemia
* IntraoperativeComplicationCS#other

// kidney_side (Kidney only)
CodeSystem: KidneySideCS
Id: kidney-side-cs
Title: "Kidney Side CodeSystem"
Description: "Side of the kidney for nephrectomy / transplant context."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/kidney-side"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #left  "Left"
* #right "Right"
* #both  "Both"

ValueSet: KidneySideVS
Id: kidney-side-vs
Title: "Kidney Side ValueSet"
Description: "Allowed values for kidney side."
* KidneySideCS#left
* KidneySideCS#right
* KidneySideCS#both

// ------------------------------------------------------
// Extensions corresponding to transplant table columns
// ------------------------------------------------------

// donor_id – Reference to Donor (One-to-One)
Extension: TransplantDonorRef
Id: transplant-donor-ref
Title: "Transplant donor reference"
Description: "Reference to the donor associated with this transplant."
* value[x] only Reference(Donor)
* valueReference 1..1

// d_r_weight_ration (Required, Both)
Extension: TransplantDonorRecipientWeightRatio
Id: transplant-donor-recipient-weight-ratio
Title: "Donor/recipient weight ratio"
Description: "Ratio of donor graft weight to recipient body weight (d_r_weight_ration)."
* value[x] only decimal

// vessel_mismatch_d_r (Required, Both)
Extension: TransplantVesselMismatch
Id: transplant-vessel-mismatch
Title: "Vessel mismatch (donor-recipient)"
Description: "Whether there is a vessel size/configuration mismatch requiring tailoring (vessel_mismatch_d_r)."
* value[x] only boolean

// cold_ischemia_time (Required, Both; minutes)
Extension: TransplantColdIschaemiaTime
Id: transplant-cold-ischaemia-time
Title: "Cold ischaemia time (minutes)"
Description: "Cold ischaemia time for the graft in minutes (cold_ischemia_time)."
* value[x] only integer

// time_diag_to_tx (Mandatory, Both; months)
Extension: TransplantTimeDiagnosisToTransplant
Id: transplant-time-diagnosis-to-transplant
Title: "Time from diagnosis to transplant (months)"
Description: "Months between disease diagnosis and transplant date (time_diag_to_tx)."
* value[x] only integer

// 1_warm_ischemia_time (Required, Both; minutes)
Extension: TransplantFirstWarmIschaemiaTime
Id: transplant-first-warm-ischemia-time
Title: "First warm ischaemia time (minutes)"
Description: "First warm ischaemia time for the graft in minutes (1_warm_ischemia_time)."
* value[x] only integer

// 2_warm_ischemia_time (Required, Kidney; minutes)
Extension: TransplantSecondWarmIschaemiaTime
Id: transplant-second-warm-ischemia-time
Title: "Second warm ischaemia time (minutes)"
Description: "Second warm ischaemia time for the graft in minutes (2_warm_ischemia_time, kidney only)."
* value[x] only integer

// vascular_anomalies (Required, Both)
Extension: TransplantVascularAnomalies
Id: transplant-vascular-anomalies
Title: "Vascular anomalies"
Description: "Presence of relevant arterial/venous anatomical variants (vascular_anomalies)."
* value[x] only string

// type_surgical_biliary_anastomosis (Required, Liver only)
Extension: TransplantBiliaryAnastomosisType
Id: transplant-biliary-anastomosis-type
Title: "Type of surgical biliary anastomosis"
Description: "Type of biliary reconstruction used (type_surgical_biliary_anastomosis)."
* value[x] only CodeableConcept
* valueCodeableConcept from BiliaryAnastomosisTypeVS (preferred)

// intraoperative_complications (Required, Liver only; potentially multiple)
Extension: TransplantIntraoperativeComplications
Id: transplant-intraoperative-complications
Title: "Intraoperative complications"
Description: "Whether and which complications occurred during surgery (intraoperative_complications)."
* value[x] only CodeableConcept
* valueCodeableConcept from IntraoperativeComplicationVS (preferred)

// intraoperative_complications_other (Required when 'Other' selected, Liver only)
Extension: TransplantIntraoperativeComplicationsOther
Id: transplant-intraoperative-complications-other
Title: "Other intraoperative complications (free text)"
Description: "Specification of other types of complications during surgery (intraoperative_complications_other)."
* value[x] only string

// nephrectomy_original_kidney (Required, Kidney only)
Extension: TransplantNephrectomyOriginalKidney
Id: transplant-nephrectomy-original-kidney
Title: "Nephrectomy of original kidney"
Description: "Whether the patient’s native kidney was surgically removed before the transplant (nephrectomy_original_kidney)."
* value[x] only boolean

// kidney_side (Required, Kidney only)
Extension: TransplantKidneySide
Id: transplant-kidney-side
Title: "Kidney side"
Description: "Transplanted kidney side (kidney_side)."
* value[x] only CodeableConcept
* valueCodeableConcept from KidneySideVS (preferred)

// ------------------------------------------------------
// Transplant profile on Encounter
// ------------------------------------------------------

Profile: Transplant
Parent: Encounter
Id: transplant
Title: "Transplant"
Description: "Encounter profile representing a transplant, linking the transplant recipient and donor and aligned with the transplant table."

// transplant_id → Encounter.identifier (Mandatory)
* identifier 1..* MS
* identifier ^short = "transplant_id – transplant identifier from the data model"
* identifier.system 1..1 MS
* identifier.system ^short = "Namespace for the transplant identifier"
* identifier.value 1..1 MS
* identifier.value ^short = "Transplant ID (transplant_id)"

// patient_id → Encounter.subject (Mandatory)
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id – the transplant recipient (PatientTransplant)"

// tx_type → Encounter.type (Mandatory)
* type 1..1 MS
* type ^short = "tx_type – transplant type (liver, kidney, combined)"
* type ^binding.strength = #required
* type ^binding.valueSet = Canonical(TransplantTypeVS)

// date_tx → Encounter.period.start (Mandatory)
* period 1..1 MS
* period.start 1..1 MS
* period.start ^short = "date_tx – date (and optionally time) of the transplant"

// Basic Encounter metadata
* status 1..1 MS
* status ^short = "Status of the transplant encounter"
* class 1..1 MS
* class ^short = "Classification of encounter (e.g. inpatient)"

// Transplant-specific extension slices 
* extension contains TransplantDonorRef named donor_id 1..1 MS
* extension contains TransplantDonorRecipientWeightRatio named d_r_weight_ration 1..1 MS
* extension contains TransplantVesselMismatch named vessel_mismatch_d_r 1..1 MS
* extension contains TransplantColdIschaemiaTime named cold_ischemia_time 1..1 MS
* extension contains TransplantTimeDiagnosisToTransplant named time_diag_to_tx 1..1 MS
* extension contains TransplantFirstWarmIschaemiaTime named warm_ischemia_time_1 0..1
* extension contains TransplantSecondWarmIschaemiaTime named warm_ischemia_time_2 0..1
* extension contains TransplantVascularAnomalies named vascular_anomalies 1..1
* extension contains TransplantBiliaryAnastomosisType named type_surgical_biliary_anastomosis 0..1
* extension contains TransplantIntraoperativeComplications named intraoperative_complications 0..*
* extension contains TransplantIntraoperativeComplicationsOther named intraoperative_complications_other 0..1
* extension contains TransplantNephrectomyOriginalKidney named nephrectomy_original_kidney 0..1
* extension contains TransplantKidneySide named kidney_side 0..1

* extension[donor_id] ^short = "donor_id – reference to the donor"
* extension[d_r_weight_ration] ^short = "d_r_weight_ration – donor/recipient graft weight ratio"
* extension[vessel_mismatch_d_r] ^short = "vessel_mismatch_d_r – vessel mismatch (Yes/No)"
* extension[cold_ischemia_time] ^short = "cold_ischemia_time – cold ischaemia time (minutes)"
* extension[time_diag_to_tx] ^short = "time_diag_to_tx – months between diagnosis and transplant"
* extension[warm_ischemia_time_1] ^short = "1_warm_ischemia_time – first warm ischaemia time (minutes)"
* extension[warm_ischemia_time_2] ^short = "2_warm_ischemia_time – second warm ischaemia time (kidney only, minutes)"
* extension[vascular_anomalies] ^short = "vascular_anomalies – vascular anatomical variants (specify)"
* extension[type_surgical_biliary_anastomosis] ^short = "type_surgical_biliary_anastomosis – biliary reconstruction type (liver only)"
* extension[intraoperative_complications] ^short = "intraoperative_complications – complications during surgery (liver only)"
* extension[intraoperative_complications_other] ^short = "intraoperative_complications_other – free text for other complications"
* extension[nephrectomy_original_kidney] ^short = "nephrectomy_original_kidney – nephrectomy of native kidney (kidney only)"
* extension[kidney_side] ^short = "kidney_side – transplanted kidney side (left/right/both)"

// ------------------------------------------------------
// Example instance
// ------------------------------------------------------

Instance: TransplantExample1
InstanceOf: Transplant
Usage: #example
Title: "Example transplant"
Description: "Example transplant instance mapped from the transplant table."

// transplant_id
* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/identifiers/transplant"
* identifier[0].value = "T000001"

// patient_id
* subject = Reference(ExamplePatientTransplant1)

// donor_id
* extension[donor_id].valueReference = Reference(ExampleDonor1)

// Encounter metadata
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#IMP "inpatient encounter"

// tx_type
* type[0].coding[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/transplant-type"
* type[0].coding[0].code = #liver
* type[0].coding[0].display = "Liver transplant"

// date_tx
* period.start = "2023-08-15T08:00:00+01:00"

// Core transplant extensions (examples)
* extension[d_r_weight_ration].valueDecimal = 0.95
* extension[vessel_mismatch_d_r].valueBoolean = false
* extension[cold_ischemia_time].valueInteger = 480
* extension[time_diag_to_tx].valueInteger = 18
* extension[warm_ischemia_time_1].valueInteger = 45
* extension[vascular_anomalies].valueString = "Accessory hepatic artery reconstructed"

// Optional organ-specific fields are left empty in this example
