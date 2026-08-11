// ================================================
// Instrumental Investigation — instrumental_investigation table
// Observation
// ================================================


// ------------------------------------------------------
// Result terminology (Normal / Abnormal)
// ------------------------------------------------------

CodeSystem: PatientInstrumentalInvestigationResultCS
Id: patient-instrumental-investigation-result-cs
Title: "Patient Instrumental Investigation Result CodeSystem"
Description: "Result of the instrumental investigation test conducted (Normal / Abnormal)."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #normal   "Normal" "Investigation result within normal limits."
* #abnormal "Abnormal" "Investigation result outside normal limits."

ValueSet: PatientInstrumentalInvestigationResultVS
Id: patient-instrumental-investigation-result-vs
Title: "Patient Instrumental Investigation Result ValueSet"
Description: "Allowed results for the instrumental investigation test (Normal, Abnormal)."
* ^experimental = true
* PatientInstrumentalInvestigationResultCS#normal
* PatientInstrumentalInvestigationResultCS#abnormal

CodeSystem: PatientInstrumentalInvestigationComponentCS
Id: patient-instrumental-investigation-component-cs
Title: "Patient Instrumental Investigation Component Codes"
Description: "Local codes for the free-text components of a patient instrumental investigation (abnormality, other investigation)."
* ^content = #complete
* ^caseSensitive = true
* ^experimental = true
* #abnormality         "Abnormality description" "Free-text description of the abnormal finding."
* #other-investigation "Other investigation description" "Free-text description of an investigation not in the catalogue."


// ------------------------------------------------------
// Profile on Observation
// ------------------------------------------------------

Profile: PatientInstrumentalInvestigation
Parent: Observation
Id: patient-instrumental-investigation
Title: "Patient Instrumental Investigation"
Description: "Instrumental investigation performed on a transplant patient, aligned with the pat_inst_inv table. All DM fields map to native Observation elements — no extensions."

// inst_inv_id → Observation.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/instrumental-investigation-id" (exactly)
* identifier.value 1..1
* identifier ^short = "inst_inv_id — instrumental investigation record identifier (DMv1.2)"

* status 1..1 MS
* status = #final (exactly)

// instrumental_investigation → Observation.code
* code 1..1 MS
* code from InstrumentalInvestigationNameVS (required)
* code ^short = "instrumental_investigation_id — investigation type from InstrumentalInvestigationNameVS"

// patient_id → Observation.subject
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id — transplant recipient"

// visit_id → Observation.encounter
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — visit during which this investigation was performed"

// date → Observation.effectiveDateTime
* effective[x] 0..1 MS
* effectiveDateTime 0..1 MS
* effectiveDateTime ^short = "date — date the instrumental investigation was performed"

// result → Observation.value[x] CodeableConcept
* value[x] 0..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from PatientInstrumentalInvestigationResultVS (required)
* valueCodeableConcept ^short = "result — Normal or Abnormal"

// abnormality + other_investigation → Observation.component (coded free-text)
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component MS

* component contains
    abnormality       0..1 MS and
    other_investigation 0..1 MS

* component[abnormality].code = PatientInstrumentalInvestigationComponentCS#abnormality "Abnormality description"
* component[abnormality].value[x] only string
* component[abnormality] ^short = "abnormality — free-text description of the abnormal finding"

* component[other_investigation].code = PatientInstrumentalInvestigationComponentCS#other-investigation "Other investigation description"
* component[other_investigation].value[x] only string
* component[other_investigation] ^short = "other_investigation — free-text description of investigations not in the catalogue"


// ------------------------------------------------------
// Example
// ------------------------------------------------------

Instance: PatientInstrumentalInvestigationExample1
InstanceOf: PatientInstrumentalInvestigation
Usage: #example
Title: "Example Patient Instrumental Investigation"
Description: "Example liver doppler ultrasound result for a transplant recipient."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/instrumental-investigation-id"
* identifier.value = "PII0001"
* status = #final
* code = InstrumentalInvestigationNameCS#718078008 "Liver doppler ultrasound"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitExample1)
* effectiveDateTime = "2024-03-10"
* valueCodeableConcept = PatientInstrumentalInvestigationResultCS#normal "Normal"
