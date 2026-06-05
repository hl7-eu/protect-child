// transplant-donor.fsh
//
// donor facts (blood group, Rh, HLA) → ImmunologicalData (immunological-data.fsh)
// age_years / age_months → PatientDemographicsObservation with subject = Reference(Donor)


// donor type (living vs deceased) is carried via Patient.deceased[x] (native R4 field):
//   deceased donor → Patient.deceasedBoolean = true
//   living donor   → Patient.deceasedBoolean = false  (or element absent)


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

// type → Patient.deceased[x]: true = deceased donor, false/absent = living donor
* deceased[x] 0..1 MS
* deceased[x] only boolean
* deceasedBoolean ^short = "type — true if deceased donor, false if living donor"

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
* deceasedBoolean = true
* gender = #male
* birthDate = "2000-01-20"
