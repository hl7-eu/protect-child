// ================================================
// Concomitant Medication – CodeSystem, ValueSet, extensions & profile
// ================================================

// --------------------------------
// CodeSystem for medication field
// --------------------------------
CodeSystem: ConcomitantMedicationCategory
Id: concomitant-medication-category
Title: "Concomitant Medication Category"
Description: "Categories of concomitant medications."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-medication-category"
* ^content = #complete

* #antihypertensive "Antihypertensive treatment"
* #antiviral-prophylaxis "Antiviral prophylaxis"
* #antibiotic-prophylaxis "Antibiotic prophylaxis"
* #heparin-therapy-prophylaxis "Heparin therapy/prophylaxis"
* #aspirin-therapy-prophylaxis "Aspirin therapy/prophylaxis"
* #ursodeoxycholic-acid "Ursodeoxycholic acid"


// --------------------------------
// ValueSet for medication field
// --------------------------------
ValueSet: ConcomitantMedicationCategoryVS
Id: concomitant-medication-category-vs
Title: "Concomitant Medication Category ValueSet"
Description: "ValueSet of concomitant medication categories."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ValueSet/concomitant-medication-category"
* include codes from system ConcomitantMedicationCategory


// ================================================
// Extensions
// ================================================

// concomitant_episode_id – ElementReference(ConcomitantEpisode)
Extension: ConcomitantMedicationEpisodeRef
Id: concomitant-medication-episode-ref
Title: "Concomitant episode ID relationship"
Description: "Reference to the concomitant episode this medication belongs to."
* value[x] only Reference(ConcomitantEpisode)
* valueReference 1..1

// medication – Code (CodeableConcept), from ConcomitantMedicationCategory
Extension: ConcomitantMedicationCode
Id: concomitant-medication-code
Title: "Medication"
Description: "Type of concomitant medication applied."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from ConcomitantMedicationCategoryVS (preferred)


// ================================================
// Concomitant Medication profile (using Basic)
// ================================================

Profile: ConcomitantMedication
Parent: Basic
Id: concomitant-medication
Title: "Concomitant Medication"
Description: "Concomitant medication records associated with a concomitant episode."

// concomitant_medication_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Concomitant medication ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-medication-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
// Use as a simple category for concomitant meds.
* code 1..1 MS
* code ^short = "Concomitant medication category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-medication-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach Concomitant Medication–specific extensions
* extension contains
    ConcomitantMedicationEpisodeRef named concomitantEpisodeId 0..1 MS and
    ConcomitantMedicationCode named medication 0..1 MS

* extension[concomitantEpisodeId] ^short = "Concomitant episode ID relationship"
* extension[medication] ^short = "Concomitant medication (coded; see ConcomitantMedicationCategory)"


// ================================================
// Example Concomitant Medication instance
// ================================================

Instance: ConcomitantMedicationExample1
InstanceOf: ConcomitantMedication
Usage: #example
Title: "Example Concomitant Medication"
Description: "Example concomitant medication for a concomitant episode."

* id = "concomitant-medication-example-1"

// concomitant_medication_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-medication-id"
* identifier.value = "CM0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-medication-type#concomitant "Concomitant medication"

// concomitant_episode_id
* extension[concomitantEpisodeId].valueReference = Reference(ConcomitantEpisodeExample1)

// medication
* extension[medication].valueCodeableConcept =
    https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-medication-category#antihypertensive "Antihypertensive treatment"
