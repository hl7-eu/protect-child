// transplant-donor.fsh
//
// NOTE:
// - Donor-level lab / typing facts are modeled as Observation resources (see patient-observations.fsh).
// - Those Observations are linked to the donor using Observation.subject = Reference(Donor).
// - Donor type (living vs deceased) is represented as an extension on the donor Patient.


// ------------------------------------------------------
// Terminology – donor-type (Living / Deceased)
// ------------------------------------------------------

CodeSystem: DonorTypeCS
Id: donor-type
Title: "Donor type"
Description: "Living vs deceased donor classification."
* ^caseSensitive = true
* ^content = #complete
* #living  "Living donor"
* #deceased "Deceased donor"

ValueSet: DonorTypeVS
Id: donor-type
Title: "Donor type value set"
Description: "Allowed values for donor type (Living, Deceased)."
* include codes from system DonorTypeCS


// ------------------------------------------------------
// Extension – donorType
// ------------------------------------------------------

Extension: DonorType
Id: donor-type-ext
Title: "Donor type"
Description: "Whether the donor is living or deceased."
* value[x] 1..1
* value[x] only CodeableConcept
* valueCodeableConcept from DonorTypeVS (required)


// ------------------------------------------------------
// Profile: Donor (Patient)
// ------------------------------------------------------

Profile: Donor
Parent: Patient
Id: donor
Title: "Transplant Donor"
Description: "Transplant donor profile based on the FHIR Patient resource, aligned with the donor table."

// donor_id → Patient.identifier (Mandatory)
* identifier 1..* MS
* identifier ^short = "Donor identifiers (hospital, procurement ID)"
* identifier.system 1..1 MS
* identifier.system ^short = "Namespace for the donor identifier"
* identifier.value 1..1 MS
* identifier.value ^short = "Donor ID (donor_id from the data model)"

// Donor type (living vs deceased) → donor.type (DM) as extension
* extension contains DonorType named donorType 0..1 MS
* extension[donorType] ^short = "Donor type (living vs deceased)"

// Basic donor demographics (if available)
* gender 0..1 MS
* gender ^short = "Donor administrative gender"
* birthDate 0..1 MS
* birthDate ^short = "Donor date of birth"


// ------------------------------------------------------
// Example Donor
// ------------------------------------------------------

Instance: ExampleDonor1
InstanceOf: Donor
Usage: #example
Title: "Example transplant donor"
Description: "Example Patient instance conforming to Donor."

* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ids/donor"
* identifier[0].value = "DON-001"
* extension[donorType].valueCodeableConcept = DonorTypeCS#deceased "Deceased donor"
* gender = #male
* birthDate = "2000-01-20"
