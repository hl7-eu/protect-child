// transplant-recipient.fsh
//
// age_years / age_months → PatientDemographicsObservation (patient-observations.fsh)
// max_pra / last_pra / date_histological_diag → PatientImmunologyObservation (patient-observations.fsh)
// blood group, Rh, HLA → ImmunologicalData (immunological-data.fsh)
// primary disease diagnosis → PatientLiverDiseaseDiagnosis / PatientRenalDiseaseDiagnosis (Condition)

// -------------------------------------------------------
// NamingSystem — study centre identifier namespace
// -------------------------------------------------------

Instance: NsStudyCentreId
InstanceOf: NamingSystem
Usage: #definition
Title: "Study centre identifier namespace"
Description: "Namespace for PROTECT-CHILD study centre identifiers (center_no = 1–4)."
* name = "ProtectChildStudyCentreId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* description = "Identifier namespace for StudyCentre (Organization) resources in the PROTECT-CHILD IG. Values 1–4 map to La Paz, Padova, Palma, and Hamburg respectively."
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/center"
* uniqueId[0].preferred = true

// -------------------------------------------------------
// Profile: StudyCentre — Organization
// -------------------------------------------------------

Profile: StudyCentre
Parent: Organization
Id: study-centre
Title: "Study Centre"
Description: "A PROTECT-CHILD participating transplant centre. center_no (1–4) is carried as identifier.value in the study-centre namespace. All PatientTransplant resources reference their centre via Patient.managingOrganization."

* identifier 1..* MS
* identifier ^short = "center_no — study centre numeric identifier (1 = La Paz, 2 = Padova, 3 = Palma, 4 = Hamburg)"
* identifier.system 1..1 MS
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/center" (exactly)
* identifier.value 1..1 MS
* identifier.value ^short = "Centre number (1–4)"

* name 1..1 MS
* name ^short = "Full name of the transplant centre"

* address 0..1 MS
* address.country 0..1 MS
* address.country ^short = "ISO 3166-1 alpha-2 country code"

// center_no is carried via Patient.managingOrganization (native Reference(Organization)).
// One Organisation instance per PROTECT-CHILD study centre; identifier.value = centre number (1–4).

Instance: PCCenter1LaPaz
InstanceOf: StudyCentre
Usage: #example
Title: "PROTECT-CHILD Centre 1 — La Paz"
Description: "La Paz University Hospital, Madrid, Spain (center_no = 1)."
* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/center"
* identifier[0].value = "1"
* name = "La Paz University Hospital"
* address[0].country = "ES"

Instance: PCCenter2Padova
InstanceOf: StudyCentre
Usage: #example
Title: "PROTECT-CHILD Centre 2 — Padova"
Description: "University of Padova, Italy (center_no = 2)."
* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/center"
* identifier[0].value = "2"
* name = "University of Padova"
* address[0].country = "IT"

Instance: PCCenter3Palma
InstanceOf: StudyCentre
Usage: #example
Title: "PROTECT-CHILD Centre 3 — Palma"
Description: "Son Espases University Hospital, Palma, Spain (center_no = 3)."
* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/center"
* identifier[0].value = "3"
* name = "Son Espases University Hospital"
* address[0].country = "ES"

Instance: PCCenter4Hamburg
InstanceOf: StudyCentre
Usage: #example
Title: "PROTECT-CHILD Centre 4 — Hamburg"
Description: "University Medical Centre Hamburg-Eppendorf, Germany (center_no = 4)."
* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/center"
* identifier[0].value = "4"
* name = "University Medical Centre Hamburg-Eppendorf"
* address[0].country = "DE"


// -------------------------------------------------------
// Profile: PatientTransplant
// -------------------------------------------------------

Profile: PatientTransplant
Parent: Patient
Id: patient-transplant
Title: "Transplant Recipient"
Description: "Transplant recipient profile based on the FHIR Patient resource, aligned with the DMv1.2 patient table. Blood group, Rh, and HLA data are in ImmunologicalData. Age at transplant is in PatientDemographicsObservation; PRA and histological date are in PatientImmunologyObservation. Patient.birthDate SHOULD also be populated when known. Primary disease diagnoses are PatientLiverDiseaseDiagnosis / PatientRenalDiseaseDiagnosis (Condition)."

// patient_id → Patient.identifier (Mandatory)
* identifier 1..* MS
* identifier ^short = "Patient identifiers (hospital, transplant registry ID)"
* identifier.system 1..1 MS
* identifier.system ^short = "Namespace for the patient identifier"
* identifier.value 1..1 MS
* identifier.value ^short = "Patient ID (patient_id)"

// gender — Mandatory
* gender 1..1 MS
* gender ^short = "Recipient administrative gender"

// birthDate — optional; populate when known.
// Age at transplant is also captured in PatientDemographicsObservation.component[age_years/age_months]
// for DM v1.2 fidelity, but birthDate SHOULD be included for standard FHIR interoperability.
* birthDate 0..1 MS
* birthDate ^short = "Date of birth — populate when known. Age at transplant is also in PatientDemographicsObservation."

// center_no → Patient.managingOrganization: Reference to one of the 4 PROTECT-CHILD centre Organisations
* managingOrganization 1..1 MS
* managingOrganization only Reference(StudyCentre)
* managingOrganization ^short = "center_no — study centre (StudyCentre profile; identifier.value = 1–4)"


// -------------------------------------------------------
// Example Patient
// -------------------------------------------------------

Instance: ExamplePatientTransplant1
InstanceOf: PatientTransplant
Usage: #example
Title: "Example transplant recipient"
Description: "Example Patient instance conforming to DMv1.2 PatientTransplant."

* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ids/recipient"
* identifier[0].value = "REC-001"
* gender = #female
* managingOrganization = Reference(PCCenter1LaPaz)
