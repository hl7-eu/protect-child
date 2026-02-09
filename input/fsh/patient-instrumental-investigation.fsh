// ================================================
// Patient Instrumental Investigation
// ================================================

// ------------------------------------------------------
// Result ValueSet (Normal / Abnormal)
// ------------------------------------------------------

CodeSystem: PatientInstrumentalInvestigationResultCS
Id: patient-instrumental-investigation-result-cs
Title: "Patient Instrumental Investigation Result CodeSystem"
Description: "Result of the instrumental investigation test conducted (Normal / Abnormal)."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/patient-instrumental-investigation-result"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #normal   "Normal"
* #abnormal "Abnormal"

ValueSet: PatientInstrumentalInvestigationResultVS
Id: patient-instrumental-investigation-result-vs
Title: "Patient Instrumental Investigation Result ValueSet"
Description: "Allowed results for the instrumental investigation test (Normal, Abnormal)."
* PatientInstrumentalInvestigationResultCS#normal
* PatientInstrumentalInvestigationResultCS#abnormal

// ------------------------------------------------------
// Extensions (ElementReferences & data items)
// ------------------------------------------------------

// patient_id – ElementReference → PatientTransplant
Extension: PatientInstrumentalInvestigationPatientRef
Id: patient-instrumental-investigation-patient-ref
Title: "Patient ID relationship"
Description: "patient_id – reference to the transplant recipient for whom the instrumental investigation was performed."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// instrumental_investigation_id – ElementReference → InstrumentalInvestigation
Extension: PatientInstrumentalInvestigationInstrumentRef
Id: patient-instrumental-investigation-instrument-ref
Title: "Instrumental investigation ID relationship"
Description: "instrumental_investigation_id – reference to the catalogue entry describing the test performed."
* value[x] only Reference(InstrumentalInvestigation)
* valueReference 1..1

// result – Normal / Abnormal
Extension: PatientInstrumentalInvestigationResult
Id: patient-instrumental-investigation-result
Title: "Result of the instrumental investigation"
Description: "result – result of the instrumental investigation test conducted (Normal / Abnormal)."
* value[x] only CodeableConcept
* valueCodeableConcept from PatientInstrumentalInvestigationResultVS (required)

// Optionally: date of investigation (if present in DM as 'date')
// (leave optional and simple)
Extension: PatientInstrumentalInvestigationDate
Id: patient-instrumental-investigation-date
Title: "Date of instrumental investigation"
Description: "Date on which the instrumental investigation was performed."
* value[x] only date
* valueDate 1..1

// ------------------------------------------------------
// Profile on Observation
// ------------------------------------------------------

Profile: PatientInstrumentalInvestigation
Parent: Observation
Id: patient-instrumental-investigation
Title: "Patient Instrumental Investigation"
Description: "Instrumental investigation performed on a transplant patient, aligned with the patient_instrumental_investigation table."

// pat_inst_inv_id → Observation.identifier (Mandatory)
* identifier 1..1 MS
* identifier ^short = "pat_inst_inv_id – identifier for the patient instrumental investigation record"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/patient-instrumental-investigation-id" (exactly)
* identifier.value 1..1

// Observation core
* status 1..1 MS
* status = #final
* code 1..1 MS
* code.text = "Patient instrumental investigation"

// Subject is optional; DM linkage is via patient_id extension
* subject 0..1 MS
* subject ^short = "Optional subject; use patient_id extension for exact DM linkage."

// We keep Observation.value[x] unused; result is in extension[result]
* value[x] 0..0

// Attach extensions with DM variable names as slice names
* extension contains PatientInstrumentalInvestigationPatientRef named patient_id 1..1 MS
* extension contains PatientInstrumentalInvestigationInstrumentRef named instrumental_investigation_id 1..1 MS
* extension contains PatientInstrumentalInvestigationResult named result 1..1 MS
* extension contains PatientInstrumentalInvestigationDate named date 0..1 MS

* extension[patient_id] ^short = "patient_id – reference to PatientTransplant"
* extension[instrumental_investigation_id] ^short = "instrumental_investigation_id – reference to InstrumentalInvestigation"
* extension[result] ^short = "result – Normal / Abnormal"
* extension[date] ^short = "Date of the instrumental investigation"

// ------------------------------------------------------
// Example instance
// ------------------------------------------------------

Instance: PatientInstrumentalInvestigationExample1
InstanceOf: PatientInstrumentalInvestigation
Usage: #example
Title: "Example Patient Instrumental Investigation"
Description: "Example of a patient instrumental investigation linked to InstrumentalInvestigation catalogue."

* id = "patient-instrumental-investigation-example-1"

* code.text = "Patient instrumental investigation"


// pat_inst_inv_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/patient-instrumental-investigation-id"
* identifier.value = "PII0001"

// optional Observation.subject
* subject = Reference(ExamplePatientTransplant1)

// DM patient_id
* extension[patient_id].valueReference = Reference(ExamplePatientTransplant1)

// DM instrumental_investigation_id
* extension[instrumental_investigation_id].valueReference = Reference(InstrumentalInvestigationExample1)

// result (Normal)
* extension[result].valueCodeableConcept = PatientInstrumentalInvestigationResultCS#normal "Normal"

// date
* extension[date].valueDate = "2024-03-10"
