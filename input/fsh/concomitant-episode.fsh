// ================================================
// Concomitant Episode – extensions & profile
// ================================================

// ================================================
// Extensions
// ================================================

// concomitant_disease_id – ElementReference(ConcomitantDisease)
Extension: ConcomitantEpisodeDiseaseRef
Id: concomitant-episode-disease-ref
Title: "Concomitant disease ID relationship"
Description: "Reference to the concomitant disease record associated with this episode."
* value[x] only Reference(ConcomitantDisease)
* valueReference 1..1

// patient_id – ElementReference(PatientTransplant)
Extension: ConcomitantEpisodePatientRef
Id: concomitant-episode-patient-ref
Title: "Patient ID relationship"
Description: "Reference to the patient for whom the concomitant episode is recorded."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// date – Date
Extension: ConcomitantEpisodeDate
Id: concomitant-episode-date
Title: "Episode date"
Description: "Date of the concomitant episode."
* value[x] only date
* valueDate 1..1

// description – String
Extension: ConcomitantEpisodeDescription
Id: concomitant-episode-description
Title: "Episode description"
Description: "Description of the concomitant episode."
* value[x] only string
* valueString 1..1


// ================================================
// Concomitant Episode profile (using Basic)
// ================================================

Profile: ConcomitantEpisode
Parent: Basic
Id: concomitant-episode
Title: "Concomitant Episode"
Description: "Clinical episode related to a concomitant disease for a transplant patient."

// ------------------------------------------------
// concomitant_episode_id → Basic.identifier
//   Column: concomitant_episode_id
//   Type: ID
// ------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Concomitant episode ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-episode-id" (exactly)
* identifier.value 1..1

// ------------------------------------------------
// Basic.code is required.
// Use as a simple category for concomitant episodes.
// ------------------------------------------------
* code 1..1 MS
* code ^short = "Concomitant episode category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-episode-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// ------------------------------------------------
// Attach Concomitant Episode–specific extensions
// ------------------------------------------------
* extension contains
    ConcomitantEpisodeDiseaseRef named concomitantDiseaseId 0..1 MS and
    ConcomitantEpisodePatientRef named patientId 0..1 MS and
    ConcomitantEpisodeDate named date 0..1 MS and
    ConcomitantEpisodeDescription named description 0..1 MS

// Short labels
* extension[concomitantDiseaseId] ^short = "Concomitant disease ID relationship"
* extension[patientId] ^short = "Patient ID relationship"
* extension[date] ^short = "Date of the concomitant episode"
* extension[description] ^short = "Description of the concomitant episode"


// ================================================
// Example Concomitant Episode instance
// ================================================

Instance: ConcomitantEpisodeExample1
InstanceOf: ConcomitantEpisode
Usage: #example
Title: "Example Concomitant Episode"
Description: "Example concomitant episode for a transplant patient."

* id = "concomitant-episode-example-1"

// concomitant_episode_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-episode-id"
* identifier.value = "CE0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-episode-type#episode "Concomitant disease episode"

// concomitant_disease_id
* extension[concomitantDiseaseId].valueReference = Reference(ConcomitantDiseaseExample1)

// patient_id
* extension[patientId].valueReference = Reference(ExamplePatientTransplant1)

// date
* extension[date].valueDate = "2025-01-10"

// description
* extension[description].valueString = "Episode of decompensated heart failure requiring hospitalization."
