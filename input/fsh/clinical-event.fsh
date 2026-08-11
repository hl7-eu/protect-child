// ================================================
// ClinicalEvent + ClinicalEventType — clinical_event and clinical_event_type tables
// visit → clinical_event is One-to-One.
// ================================================

Alias: $obs-cat  = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $clin-st  = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $snomed   = http://snomed.info/sct

// ------------------------------------------------
// ClinicalEventType CodeSystem + ValueSet
// ------------------------------------------------

CodeSystem: ClinicalEventTypeCS
Id: clinical-event-type-cs
Title: "Clinical Event Type CodeSystem"
Description: "Types of clinical events in the PROTECT-CHILD study (DMv1.2), replacing outcome_type and post_event_type."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #alloimmunization                         "Alloimmunization" "Development of antibodies against alloantigens (e.g. HLA) following transplantation or transfusion."
* #biliary-complications                    "Biliary Complications" "Post-transplant complications of the biliary tract (e.g. stricture, leak, stones)."
* #bk-virus-infection                       "BK Virus Infection" "Infection or reactivation of BK polyomavirus."
* #chronic-liver-failure                    "Chronic Liver Failure" "Progressive, long-standing loss of liver function."
* #chronic-liver-rejection                  "Chronic Liver Rejection" "Chronic rejection of the liver allograft (e.g. ductopenia / vanishing bile duct syndrome)."
* #chronic-renal-failure-after-pltx         "Chronic Renal Failure After pLTx" "Chronic kidney disease developing after paediatric liver transplantation."
* #cmv-infection                            "Cytomegalovirus Infection" "Infection or reactivation of cytomegalovirus."
* #delayed-kidney-graft-function            "Delayed Kidney Graft Function" "Delayed function of the kidney allograft requiring dialysis in the first post-transplant week."
* #diabetes                                 "Diabetes" "Diabetes mellitus, including new-onset diabetes after transplantation."
* #graft-failure                            "Graft Failure" "Loss of function of the transplanted organ."
* #high-blood-pressure                      "High Blood Pressure" "Arterial hypertension."
* #kidney-primary-non-function              "Kidney Primary Non-Function" "Kidney allograft that never achieves function after transplantation."
* #kidney-rejection-episode                 "Kidney Rejection Episode" "An episode of acute or chronic rejection of the kidney allograft."
* #liver-early-allograft-dysfunction        "Liver Early Allograft Dysfunction" "Early dysfunction of the liver allograft in the initial post-transplant period."
* #liver-primary-non-function               "Liver Primary Non-Function" "Liver allograft that never achieves function, requiring urgent re-transplantation."
* #liver-rejection-episode                  "Liver Rejection Episode" "An episode of acute or chronic rejection of the liver allograft."
* #microangiopathy                          "Microangiopathy" "Thrombotic microangiopathy affecting small blood vessels."
* #mortality                                "Mortality" "Death of the patient."
* #mtor-inhibitors-toxicity                 "mTOR Inhibitors Toxicity" "Adverse effects attributable to mTOR-inhibitor immunosuppression."
* #mycophenolate-toxicity                   "Mycophenolate Toxicity" "Adverse effects attributable to mycophenolate immunosuppression."
* #pres                                     "PRES" "Posterior reversible encephalopathy syndrome (PRES)."
* #ptld                                     "PTLD" "Post-transplant lymphoproliferative disorder (PTLD)."
* #relapse-primary-immunomediated-disease   "Relapse Primary Immunomediated Disease" "Recurrence of the primary immune-mediated disease that led to transplantation."
* #renal-cni-toxicity                       "Renal CNI Toxicity" "Calcineurin-inhibitor-induced renal toxicity."
* #urological-complications                 "Urological Complications" "Post-transplant complications of the urinary tract (e.g. obstruction, leak, reflux)."
* #vascular-complications                   "Vascular Complications" "Post-transplant vascular complications (e.g. thrombosis, stenosis)."

ValueSet: ClinicalEventTypeVS
Id: clinical-event-type-vs
Title: "Clinical Event Type ValueSet"
Description: "Allowed clinical event types in the PROTECT-CHILD study (DMv1.2)."
* ^experimental = true
* include codes from system ClinicalEventTypeCS

// ------------------------------------------------
// Terminology — vascular_complication_type
// ------------------------------------------------

CodeSystem: VascularComplicationTypeCS
Id: vascular-complication-type-cs
Title: "Vascular Complication Type CodeSystem"
Description: "Types of vascular complications in transplant (DMv1.2)."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #HAT                    "HAT" "Hepatic artery thrombosis (HAT)."
* #portal-vein-stenosis   "Portal Vein Stenosis" "Stenosis of the portal vein."
* #portal-vein-thrombosis "Portal Vein Thrombosis" "Thrombosis of the portal vein."
* #unknown                "Unknown" "Vascular complication of unknown type."

ValueSet: VascularComplicationTypeVS
Id: vascular-complication-type-vs
Title: "Vascular Complication Type ValueSet"
Description: "Types of vascular complication occurring after solid-organ transplantation."
* ^experimental = true
* VascularComplicationTypeCS#HAT
* VascularComplicationTypeCS#portal-vein-stenosis
* VascularComplicationTypeCS#portal-vein-thrombosis
* VascularComplicationTypeCS#unknown

// ------------------------------------------------
// Terminology — evidence codes (Condition.evidence.code)
// Presence = true, absence = false.
// Covers all DM boolean flags that have no native Condition element.
// ------------------------------------------------

CodeSystem: ClinicalEventEvidenceCS
Id: clinical-event-evidence-cs
Title: "Clinical Event Evidence CodeSystem"
Description: "Coded findings used in Condition.evidence.code to represent boolean DM fields. Presence of a code means the flag is true; absence means false."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #dgf                          "Delayed graft function" "Delayed graft function: dialysis requirement or failure of graft function to improve in the first post-transplant week."
* #episodes-aki-after-ltx       "Episodes of AKI after liver transplant" "One or more episodes of acute kidney injury after liver transplantation."
* #histologic-evidence-cni-tox  "Histological evidence of CNI nephrotoxicity" "Histological findings consistent with calcineurin-inhibitor nephrotoxicity."
* #hypoxic-ischemic-pltx        "Hypoxic-ischemic event post liver transplant" "Hypoxic-ischaemic event occurring after paediatric liver transplantation."
* #concomitant-medications      "Concomitant medications present" "Indicates that concomitant medications were recorded for the event."
* #treatment-adherence          "Treatment adherence confirmed" "Indicates that adherence to prescribed treatment was confirmed."

ValueSet: ClinicalEventEvidenceVS
Id: clinical-event-evidence-vs
Title: "Clinical Event Flag ValueSet"
Description: "Codes for ClinicalEventFlagObservation.code — one per boolean DM flag on the clinical_event table. Presence of an Observation with this code means the flag is true."
* ^experimental = true
* include codes from system ClinicalEventEvidenceCS

// ------------------------------------------------
// Terminology — linked procedure types
// Covers all DM sub-events that require a date alongside a coded type:
// dialysis episodes, retransplantation, and transplant-list entry.
// ------------------------------------------------

CodeSystem: ClinicalEventProcedureTypeCS
Id: clinical-event-procedure-type-cs
Title: "Clinical Event Procedure Type CodeSystem"
Description: "Types of procedures linked to a ClinicalEvent via ClinicalEventProcedure.reasonReference. Used for dialysis episodes, retransplantation, and transplant-list entry (DMv1.2)."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #hemodialysis        "Hemodialysis" "Renal replacement therapy by haemodialysis."
* #peritoneal-dialysis "Peritoneal dialysis" "Renal replacement therapy by peritoneal dialysis."
* #retransplantation   "Retransplantation" "Repeat transplantation of the same organ."
* #transplant-listing  "Listed for retransplant" "Placement of the patient on the waiting list for (re)transplantation."

ValueSet: ClinicalEventProcedureTypeVS
Id: clinical-event-procedure-type-vs
Title: "Clinical Event Procedure Type ValueSet"
Description: "Allowed procedure types for ClinicalEventProcedure."
* ^experimental = true
* include codes from system ClinicalEventProcedureTypeCS

// ================================================
// Profile: ClinicalEvent — Condition
// No extensions — all DM fields map to native Condition elements or linked resources.
// ================================================

Profile: ClinicalEvent
Parent: Condition
Id: clinical-event
Title: "Clinical Event"
Description: "A clinical event for a transplant patient, aligned with the DMv1.2 clinical_event table. Event phase (START/END) is represented via native Condition lifecycle. Boolean DM fields are in Condition.evidence.code (presence = true). Free-text fields are in Condition.note. Dialysis episodes, retransplantation, and transplant-list entry are linked ClinicalEventProcedure resources via Procedure.reasonReference."

// clinical_event_id → Condition.identifier (M)
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/clinical-event-id" (exactly)
* identifier.value 1..1
* identifier ^short = "clinical_event_id"

// clinical_event_type_id → Condition.code (M)
* code 1..1 MS
* code from ClinicalEventTypeVS (required)
* code ^short = "clinical_event_type_id — type of clinical event"

// patient_id → Condition.subject
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// visit_id → Condition.encounter (M)
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — Visit at which this event phase was recorded"

// event_phase → native Condition lifecycle
//   START visit: onsetDateTime + clinicalStatus = #active
//   END visit:   abatementDateTime + clinicalStatus = #resolved
* clinicalStatus 1..1 MS
* clinicalStatus ^short = "event_phase — #active = START visit; #resolved = END visit"

* onset[x] 0..1 MS
* onsetDateTime 0..1 MS
* onsetDateTime ^short = "Date this event started (START visit date)"

* abatement[x] 0..1 MS
* abatementDateTime 0..1 MS
* abatementDateTime ^short = "Date this event ended (END visit date)"

// Five free-text DM fields → Condition.note, sliced by authorString.
// authorString is the DM field name; text carries the free-text content.
* note ^slicing.discriminator.type = #value
* note ^slicing.discriminator.path = "author.ofType(string)"
* note ^slicing.rules = #open
* note MS

* note contains
    cause_death                        0..1 MS and
    specify_kidney_rejection_episode   0..1 MS and
    previous_urological_intervention   0..1 MS and
    underlying_prothrombotic_disorders 0..1 MS and
    kidney_biopsy                      0..1 MS

* note[cause_death].authorString = "cause_death" (exactly)
* note[cause_death].text 1..1
* note[cause_death] ^short = "cause_death — free-text cause of death"

* note[specify_kidney_rejection_episode].authorString = "specify_kidney_rejection_episode" (exactly)
* note[specify_kidney_rejection_episode].text 1..1
* note[specify_kidney_rejection_episode] ^short = "specify_kidney_rejection_episode — rejection episode specification (Kidney only)"

* note[previous_urological_intervention].authorString = "previous_urological_intervention" (exactly)
* note[previous_urological_intervention].text 1..1
* note[previous_urological_intervention] ^short = "previous_urological_intervention — prior urological intervention (Urological only)"

* note[underlying_prothrombotic_disorders].authorString = "underlying_prothrombotic_disorders" (exactly)
* note[underlying_prothrombotic_disorders].text 1..1
* note[underlying_prothrombotic_disorders] ^short = "underlying_prothrombotic_disorders — underlying prothrombotic disorders (free text)"

* note[kidney_biopsy].authorString = "kidney_biopsy" (exactly)
* note[kidney_biopsy].text 1..1
* note[kidney_biopsy] ^short = "kidney_biopsy — kidney biopsy findings (free text)"

// vascular_complication_type → Condition.evidence.code (coded value, not a boolean flag)
// Boolean flags (dgf, episodes_aki_after_ltx, etc.) are now represented as
// ClinicalEventFlagObservation resources with focus = Reference(ClinicalEvent).
* evidence 0..1 MS
* evidence.code 0..1 MS
* evidence.code from VascularComplicationTypeVS (required)
* evidence ^short = "vascular_complication_type — coded vascular complication (if present)"

// ================================================
// Organ-specific invariants for ClinicalEventFlagObservation
//
// Kidney-only flags: dgf (delayed graft function)
// Liver-only flags:  episodes-aki-after-ltx (AKI after LTx),
//                    hypoxic-ischemic-pltx (hypoxic event post liver transplant)
// ================================================

Invariant: pc-flag-1
Description: "Delayed graft function (DGF) is a kidney-specific flag; only applicable for kidney or combined transplants."
Severity: #error
Expression: "code.coding.where(code = 'dgf').exists() implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'kidney' or code = 'combined').exists()"

Invariant: pc-flag-2
Description: "Episodes of AKI after LTx is a liver-specific flag; only applicable for liver or combined transplants."
Severity: #error
Expression: "code.coding.where(code = 'episodes-aki-after-ltx').exists() implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'liver' or code = 'combined').exists()"

Invariant: pc-flag-3
Description: "Hypoxic-ischaemic event post liver transplant is a liver-specific flag; only applicable for liver or combined transplants."
Severity: #error
Expression: "code.coding.where(code = 'hypoxic-ischemic-pltx').exists() implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'liver' or code = 'combined').exists()"

// ================================================
// Profile: ClinicalEventFlagObservation — Observation
// Represents boolean DM flags on the clinical_event table.
// One Observation per flag that is true; absence of an Observation means false.
// Link to the parent ClinicalEvent via Observation.focus.
// Query: Observation?focus={clinical-event-id}&code={flag-code}
// ================================================

Profile: ClinicalEventFlagObservation
Parent: Observation
Id: clinical-event-flag-observation
Title: "Clinical Event Flag Observation"
Description: "Boolean flag associated with a clinical event (DMv1.2 clinical_event table). Each instance represents one true flag. Absence of an instance for a given code means the flag is false. Linked to the parent ClinicalEvent via Observation.focus. The transplant type extension enables organ-specific invariants pc-flag-1 through pc-flag-3."

// Apply organ-specific invariants
* obeys pc-flag-1
* obeys pc-flag-2
* obeys pc-flag-3

// tx_type context — required for organ-specific flags
* extension contains TransplantTypeExt named tx_type 0..1 MS
* extension[tx_type] ^short = "Transplant type context — required when code is an organ-specific flag (dgf, episodes-aki-after-ltx, hypoxic-ischemic-pltx)"

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#exam

// Flag type — which DM boolean field this Observation represents
* code 1..1 MS
* code from ClinicalEventEvidenceVS (required)
* code ^short = "Flag type — one of: dgf (kidney/combined), episodes-aki-after-ltx (liver/combined), histologic-evidence-cni-tox, hypoxic-ischemic-pltx (liver/combined), concomitant-medications, treatment-adherence"

// Link to parent ClinicalEvent (M)
* focus 1..1 MS
* focus only Reference(ClinicalEvent)
* focus ^short = "The ClinicalEvent (Condition) this flag belongs to"

// Patient link for FHIR searchability
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// Visit link
* encounter 0..1 MS
* encounter only Reference(Visit)
* encounter ^short = "Visit at which this flag was recorded"

// Value — always true (the Observation's existence IS the flag being true)
* value[x] 1..1 MS
* value[x] only boolean
* valueBoolean = true (exactly)
* valueBoolean ^short = "Always true — the presence of this Observation means the flag is set"

// ================================================
// Profile: ClinicalEventProcedure — Procedure
// Sub-events that carry a coded type plus a date/period.
// Link back to the ClinicalEvent via Procedure.reasonReference.
// Query: Procedure?reason-reference={clinical-event-id}&code={type}
// ================================================

Profile: ClinicalEventProcedure
Parent: Procedure
Id: clinical-event-procedure
Title: "Clinical Event Procedure"
Description: "A procedure sub-event associated with a clinical event (DMv1.2 dialysis episodes, retransplantation, transplant-list entry). Linked to the parent ClinicalEvent Condition via Procedure.reasonReference."

* status 1..1 MS
* status = #completed (exactly)

// Procedure type — dialysis modality, retransplantation, or transplant-list entry
* code 1..1 MS
* code from ClinicalEventProcedureTypeVS (required)
* code ^short = "Procedure type — dialysis_type / retransplantation / transplant-listing"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// Link back to the ClinicalEvent
* reasonReference 1..1 MS
* reasonReference only Reference(ClinicalEvent)
* reasonReference ^short = "Parent ClinicalEvent (Condition) this procedure belongs to"

// performed[x]: Period for dialysis (start + end), dateTime for retransplantation / listing date
* performed[x] 0..1 MS
* performed[x] ^short = "dialysis_start_date/dialysis_end_date (Period) or retransplantation_date / date_entry_transplant_list (dateTime)"

// ================================================
// Examples
// ================================================

Instance: ClinicalEventExample1
InstanceOf: ClinicalEvent
Usage: #example
Title: "Example Clinical Event — Kidney Rejection START"
Description: "Example clinical event recording the start of a kidney rejection episode at a 3-month visit."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/clinical-event-id"
* identifier.value = "CE-001"
* clinicalStatus = $clin-st#active
* code = ClinicalEventTypeCS#kidney-rejection-episode "Kidney Rejection Episode"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitExample1)
* onsetDateTime = "2023-11-15"
* note[specify_kidney_rejection_episode].authorString = "specify_kidney_rejection_episode"
* note[specify_kidney_rejection_episode].text = "Acute T-cell mediated rejection, Banff 2"

Instance: ClinicalEventDialysisProcedureExample1
InstanceOf: ClinicalEventProcedure
Usage: #example
Title: "Example Clinical Event Procedure — Hemodialysis"
Description: "Hemodialysis episode linked to a clinical event via reasonReference."

* status = #completed
* code = ClinicalEventProcedureTypeCS#hemodialysis "Hemodialysis"
* subject = Reference(ExamplePatientTransplant1)
* reasonReference = Reference(ClinicalEventExample1)
* performedPeriod.start = "2023-12-01"
* performedPeriod.end = "2024-03-15"

Instance: ClinicalEventRetransplantationExample1
InstanceOf: ClinicalEventProcedure
Usage: #example
Title: "Example Clinical Event Procedure — Retransplantation"
Description: "Retransplantation event linked to the graft-failure clinical event. retransplantation=true is implicit from the existence of this resource."

* status = #completed
* code = ClinicalEventProcedureTypeCS#retransplantation "Retransplantation"
* subject = Reference(ExamplePatientTransplant1)
* reasonReference = Reference(ClinicalEventExample1)
* performedDateTime = "2024-06-10"

Instance: ClinicalEventTransplantListingExample1
InstanceOf: ClinicalEventProcedure
Usage: #example
Title: "Example Clinical Event Procedure — Transplant List Entry"
Description: "Date patient was listed for retransplantation, linked to the triggering clinical event."

* status = #completed
* code = ClinicalEventProcedureTypeCS#transplant-listing "Listed for retransplant"
* subject = Reference(ExamplePatientTransplant1)
* reasonReference = Reference(ClinicalEventExample1)
* performedDateTime = "2024-04-20"
