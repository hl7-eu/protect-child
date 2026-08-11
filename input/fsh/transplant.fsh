// transplant.fsh

// ------------------------------------------------------
// Terminology
// ------------------------------------------------------

// tx_type
CodeSystem: TransplantTypeCS
Id: transplant-type-cs
Title: "Transplant Type CodeSystem"
Description: "Type of solid-organ transplant (liver, kidney, combined liver-kidney)."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #liver    "Liver transplant" "Liver transplantation."
* #kidney   "Kidney transplant" "Kidney transplantation."
* #combined "Combined liver-kidney transplant" "Combined liver-kidney transplantation."

ValueSet: TransplantTypeVS
Id: transplant-type-vs
Title: "Transplant Type ValueSet"
Description: "Allowed transplant types."
* ^experimental = true
* TransplantTypeCS#liver
* TransplantTypeCS#kidney
* TransplantTypeCS#combined

// type_surgical_biliary_anastomosis (Liver only)
CodeSystem: BiliaryAnastomosisTypeCS
Id: biliary-anastomosis-type-cs
Title: "Type of surgical biliary anastomosis CodeSystem"
Description: "Types of biliary anastomosis used in liver transplantation."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #duct-to-duct          "Duct-to-duct anastomosis" "Direct end-to-end anastomosis between donor and recipient bile ducts (choledocho-choledochostomy)."
* #choledochoenterostomy "Choledochoenterostomy" "Anastomosis of the common bile duct to the intestine."
* #bilioenteric          "Bilioenteric anastomosis" "Anastomosis between the biliary tree and the bowel."
* #roux-en-y             "Roux-en-Y hepaticojejunostomy" "Biliary drainage via a Roux-en-Y hepaticojejunostomy loop."

ValueSet: BiliaryAnastomosisTypeVS
Id: biliary-anastomosis-type-vs
Title: "Type of surgical biliary anastomosis ValueSet"
Description: "Allowed types of biliary anastomosis in liver transplant."
* ^experimental = true
* BiliaryAnastomosisTypeCS#duct-to-duct
* BiliaryAnastomosisTypeCS#choledochoenterostomy
* BiliaryAnastomosisTypeCS#bilioenteric
* BiliaryAnastomosisTypeCS#roux-en-y

// intraoperative_complications
CodeSystem: IntraoperativeComplicationCS
Id: intraoperative-complication-cs
Title: "Intraoperative Complications CodeSystem"
Description: "Intraoperative complications during transplantation (liver or kidney)."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #major-bleeding    "Major bleeding" "Significant intraoperative haemorrhage."
* #bile-duct-injury  "Bile duct injury" "Intraoperative injury to the bile duct."
* #vessel-injury     "Vessel injury" "Intraoperative injury to a blood vessel."
* #liver-ischemia    "Liver ischemia" "Intraoperative ischaemia of the liver."
* #kidney-ischemia   "Kidney ischemia" "Intraoperative ischaemia of the kidney."

ValueSet: IntraoperativeComplicationVS
Id: intraoperative-complication-vs
Title: "Intraoperative Complications ValueSet"
Description: "Allowed intraoperative complications during transplantation."
* ^experimental = true
* IntraoperativeComplicationCS#major-bleeding
* IntraoperativeComplicationCS#bile-duct-injury
* IntraoperativeComplicationCS#vessel-injury
* IntraoperativeComplicationCS#liver-ischemia
* IntraoperativeComplicationCS#kidney-ischemia

// type_ureteral_graft_anastomosis
CodeSystem: UreteralAnastomosisTypeCS
Id: ureteral-anastomosis-type-cs
Title: "Ureteral Graft Anastomosis Type CodeSystem"
Description: "Types of ureteral graft anastomosis used in transplantation (DMv1.2)."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #standard         "Standard" "Standard ureteroneocystostomy anastomosis."
* #cutaneous        "Cutaneous" "Cutaneous ureterostomy."
* #ureterostomy     "Ureterostomy" "Ureterostomy."
* #epicistostomy    "Epicistostomy" "Epicystostomy (suprapubic bladder drainage)."

ValueSet: UreteralAnastomosisTypeVS
Id: ureteral-anastomosis-type-vs
Title: "Ureteral Graft Anastomosis Type ValueSet"
Description: "Allowed ureteral graft anastomosis types."
* ^experimental = true
* UreteralAnastomosisTypeCS#standard
* UreteralAnastomosisTypeCS#cutaneous
* UreteralAnastomosisTypeCS#ureterostomy
* UreteralAnastomosisTypeCS#epicistostomy

// ------------------------------------------------------
// Extensions on Transplant
// ------------------------------------------------------

// donor_id – Encounter.participant.individual cannot reference Patient in R4;
// extension is the correct solution.
Extension: TransplantDonorRef
Id: transplant-donor-ref
Title: "Transplant donor reference"
Description: "Reference to the donor associated with this transplant."
* value[x] only Reference(Donor)
* valueReference 1..1

// ------------------------------------------------------
// Transplant profile on Procedure
// ------------------------------------------------------

Profile: Transplant
Parent: Procedure
Id: transplant
Title: "Transplant"
Description: "Procedure profile representing a transplant, aligned with DMv1.2 transplant table. The donor is linked via extension[donor_id]. The associated Visit is linked natively via Procedure.encounter. Intraoperative details are represented as a single TransplantDetails panel Observation linked via Observation.partOf."

// transplant_id → Procedure.identifier (Mandatory)
* identifier 1..* MS
* identifier ^short = "transplant_id – transplant identifier from the data model"
* identifier.system 1..1 MS
* identifier.system ^short = "Namespace for the transplant identifier"
* identifier.value 1..1 MS
* identifier.value ^short = "Transplant ID (transplant_id)"

// patient_id → Procedure.subject
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// donor_id → extension (1..1)
* extension contains TransplantDonorRef named donor_id 1..1 MS
* extension[donor_id] ^short = "donor_id – reference to the donor"

// tx_type → Procedure.code (Mandatory)
* code 1..1 MS
* code from TransplantTypeVS (required)
* code ^short = "tx_type – transplant type (liver, kidney, combined)"

// date_tx → Procedure.performedDateTime (Mandatory)
* performed[x] 1..1 MS
* performed[x] only dateTime
* performedDateTime ^short = "date_tx – date (and optionally time) of the transplant"

// visit_id → Procedure.encounter (native link to Visit)
* encounter 0..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id – the Visit (Encounter) during which the transplant was performed"

* status 1..1 MS
* status ^short = "Status of the transplant procedure (use #completed)"

// ------------------------------------------------------
// Example instance
// ------------------------------------------------------

Instance: TransplantExample1
InstanceOf: Transplant
Usage: #example
Title: "Example transplant"
Description: "Example transplant instance mapped from the DMv1.2 transplant table."

// transplant_id
* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/identifiers/transplant"
* identifier[0].value = "T000001"

// subject (patient — same as Visit.subject)
* subject = Reference(ExamplePatientTransplant1)

// donor_id
* extension[donor_id].valueReference = Reference(ExampleDonor1)

// tx_type
* code = TransplantTypeCS#liver "Liver transplant"

// date_tx
* performedDateTime = "2023-08-15T08:00:00+01:00"

// visit_id
* encounter = Reference(VisitExample1)

// status
* status = #completed
