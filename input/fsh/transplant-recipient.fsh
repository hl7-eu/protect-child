// transplant-recipient.fsh

// NOTE:
// - Patient-level lab / typing / diagnosis facts are modeled as Observation resources (see patient-observations.fsh).
// - Those Observations are linked to the recipient using Observation.subject = Reference(PatientTransplant).


Profile: PatientTransplant
Parent: Patient
Id: patient-transplant
Title: "Transplant Recipient"
Description: "Transplant recipient profile based on the FHIR Patient resource, aligned with the patient table."

// patient_id → Patient.identifier (Mandatory)
* identifier 1..* MS
* identifier ^short = "Patient identifiers (hospital, transplant registry ID)"
* identifier.system 1..1 MS
* identifier.system ^short = "Namespace for the patient identifier (e.g. transplant registry)"
* identifier.value 1..1 MS
* identifier.value ^short = "Patient ID (patient_id from the data model)"

// Basic recipient demographics
// gender (Mandatory), birthdate (Required)
* gender 1..1 MS
* gender ^short = "Recipient administrative gender"
* birthDate 1..1 MS
* birthDate ^short = "Recipient date of birth"

// current_age is derived from birthDate, so no separate element

// ------------------------------------------------------
// Example Patient
// ------------------------------------------------------

Instance: ExamplePatientTransplant1
InstanceOf: PatientTransplant
Usage: #example
Title: "Example transplant recipient"
Description: "Example Patient instance conforming to PatientTransplant."

* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ids/recipient"
* identifier[0].value = "REC-001"
* gender = #female
* birthDate = "2015-06-15"
