// transplant.fsh

Alias: $cond-cat = http://terminology.hl7.org/CodeSystem/condition-category

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
* #duct-to-duct          "Duct-to-duct anastomosis" "Direct end-to-end anastomosis between donor and recipient bile ducts."
* #hepaticocholedochostomy "Hepaticocholedochostomy" "Anastomosis between the recipient common hepatic/bile duct and the donor duct (hepatico-choledochostomy)."
* #choledochocholedochostomy "Choledochocholedochostomy" "Anastomosis between the donor and recipient common bile ducts."
* #bilioenteric          "Bilioenteric anastomosis" "Anastomosis between the biliary tree and the bowel."
* #roux-en-y             "Roux-en-Y hepaticojejunostomy" "Biliary drainage via a Roux-en-Y hepaticojejunostomy loop."
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
* #ureter-injury     "Ureter injury" "Intraoperative injury to the ureter."
* #bladder-injury    "Bladder injury" "Intraoperative injury to the urinary bladder."

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
* IntraoperativeComplicationCS#ureter-injury
* IntraoperativeComplicationCS#bladder-injury

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
ValueSet: TransplantAnastomosisTypeVS
Id: transplant-anastomosis-type-vs
Title: "Transplant Anastomosis Type ValueSet"
Description: "Types of surgical anastomosis performed during transplantation — biliary (liver) or ureteral (kidney). Used as Procedure.code on TransplantAnastomosis; free-text 'other' anastomosis types are carried in Procedure.code.text."
* ^experimental = true
* include codes from system BiliaryAnastomosisTypeCS
* include codes from system UreteralAnastomosisTypeCS

// Organ-specific subsets — transplant-map.html links to both by name.

ValueSet: BiliaryAnastomosisTypeVS
Id: biliary-anastomosis-type-vs
Title: "Biliary Anastomosis Type ValueSet"
Description: "Types of surgical biliary anastomosis (DMv1.2 transplant.type_surgical_biliary_anastomosis). Liver and combined transplants only."
* ^experimental = true
* include codes from system BiliaryAnastomosisTypeCS

ValueSet: UreteralAnastomosisTypeVS
Id: ureteral-anastomosis-type-vs
Title: "Ureteral Anastomosis Type ValueSet"
Description: "Types of ureteral graft anastomosis (DMv1.2 transplant.type_ureteral_graft_anastomosis). Kidney and combined only."
* ^experimental = true
* include codes from system UreteralAnastomosisTypeCS

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

// intraoperative_complications → Procedure.complicationDetail (native link to Condition)
// Each intraoperative complication is an IntraoperativeComplication (Condition) resource.
* complicationDetail 0..* MS
* complicationDetail only Reference(IntraoperativeComplication)
* complicationDetail ^short = "intraoperative_complications – each complication as an IntraoperativeComplication Condition"

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
* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id"
* identifier[0].value = "TXP-1-0001"

// subject (patient — same as Visit.subject)
* subject = Reference(ExamplePatientTransplant1)

// donor_id
* extension[donor_id].valueReference = Reference(ExampleDonor1)

// tx_type
* code = TransplantTypeCS#liver "Liver transplant"

// date_tx
* performedDateTime = "2023-08-15T08:00:00+02:00"

// visit_id
* encounter = Reference(VisitPreTxExample1)

// status
* status = #completed

// intraoperative_complications
* complicationDetail = Reference(IntraoperativeComplicationExample1)

// ------------------------------------------------------
// IntraoperativeComplication profile on Condition
// transplant.intraoperative_complications (+ ..._other free text)
// Linked from the Transplant Procedure via Procedure.complicationDetail.
// ------------------------------------------------------

Profile: IntraoperativeComplication
Parent: Condition
Id: intraoperative-complication
Title: "Intraoperative Complication"
Description: "An intraoperative complication that occurred during a transplant procedure (DMv1.2 transplant.intraoperative_complications). Represented as a Condition (encounter-diagnosis) and linked from the Transplant Procedure via Procedure.complicationDetail. One instance per complication. Free-text 'other' complications (intraoperative_complications_other) are carried in Condition.note."

* category 1..* MS
* category = $cond-cat#encounter-diagnosis

// intraoperative_complications → Condition.code
* code 1..1 MS
* code from IntraoperativeComplicationVS (required)
* code ^short = "intraoperative_complications — coded intraoperative complication"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// visit_id → Condition.encounter (the transplant visit)
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — Visit during which the transplant was performed"

// date_tx → Condition.onsetDateTime
* onset[x] 0..1 MS
* onsetDateTime 0..1 MS
* onsetDateTime ^short = "date_tx — date of the transplant"

// intraoperative_complications_other → Condition.note
* note 0..1 MS
* note ^short = "intraoperative_complications_other — free-text description of another complication"

Instance: IntraoperativeComplicationExample1
InstanceOf: IntraoperativeComplication
Usage: #example
Title: "Example Intraoperative Complication"
Description: "Example intraoperative complication (major bleeding) linked to the example transplant via Procedure.complicationDetail."

* category = $cond-cat#encounter-diagnosis
* code = IntraoperativeComplicationCS#major-bleeding "Major bleeding"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitPreTxExample1)
* onsetDateTime = "2023-08-15"

// ------------------------------------------------------
// TransplantAnastomosis profile on Procedure
// transplant.type_surgical_biliary_anastomosis, type_ureteral_graft_anastomosis,
// other_type_ureteral_graft_anastomosis
// Linked to the Transplant Procedure via Procedure.partOf.
// Matches the OMOP PROCEDURE_OCCURRENCE representation of each anastomosis.
// ------------------------------------------------------

Profile: TransplantAnastomosis
Parent: Procedure
Id: transplant-anastomosis
Title: "Transplant Anastomosis"
Description: "A surgical anastomosis performed as part of a transplant procedure (DMv1.2 transplant.type_surgical_biliary_anastomosis, type_ureteral_graft_anastomosis, other_type_ureteral_graft_anastomosis). Modelled as a Procedure linked to the transplant via Procedure.partOf, matching the OMOP PROCEDURE_OCCURRENCE representation. Biliary anastomoses apply to liver/combined transplants; ureteral anastomoses to kidney/combined. Free-text 'other' ureteral anastomosis types are carried in Procedure.code.text."

* status 1..1 MS
* status = #completed (exactly)

// Anastomosis type → Procedure.code (biliary or ureteral); free-text other via code.text
* code 1..1 MS
* code from TransplantAnastomosisTypeVS (extensible)
* code ^short = "type_surgical_biliary_anastomosis / type_ureteral_graft_anastomosis (coded); other_type_ureteral_graft_anastomosis via code.text"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// visit_id → Procedure.encounter (the transplant visit)
// 1..1: DMv1.2.01 marks transplant.visit_id Mandatory.
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — Visit during which the transplant was performed"

// date_tx → Procedure.performedDateTime
* performed[x] 0..1 MS
* performed[x] only dateTime
* performedDateTime ^short = "date_tx — date of the transplant"

// Link to the parent Transplant Procedure
* partOf 1..1 MS
* partOf only Reference(Transplant)
* partOf ^short = "The Transplant Procedure this anastomosis is part of"

Instance: TransplantAnastomosisExample1
InstanceOf: TransplantAnastomosis
Usage: #example
Title: "Example Transplant Anastomosis"
Description: "Example biliary anastomosis (duct-to-duct) performed as part of the example liver transplant, linked via Procedure.partOf."

* status = #completed
* code = BiliaryAnastomosisTypeCS#duct-to-duct "Duct-to-duct anastomosis"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitPreTxExample1)
* performedDateTime = "2023-08-15"
* partOf = Reference(TransplantExample1)
