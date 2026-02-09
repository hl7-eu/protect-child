// ================================================
// Instrumental Investigation – terminology
// ================================================

CodeSystem: InstrumentalInvestigationNameCS
Id: instrumental-investigation-name-cs
Title: "Instrumental Investigation Name"
Description: "Types of instrumental investigation tests conducted."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/instrumental-investigation-name"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true

* #718078008 "Liver doppler ultrasound"
* #4061009 "Abdominal CT scan"
* #4083230 "Abdominal MRI"
* #4194588 "MRCP"
* #37311324 "Brain MRI"
* #4169785 "AngioTC"
* #4299523 "Angiography"
* #4181917 "EEG"
* #36308175 "ECG"
* #4167052 "Kidney doppler ultrasound"
* #36713614 "Total body CT scan"
* #scintigraphy "Scintigraphy"
* #mcug "Micturating Cystourethrogram (MCUG)"
* #pet "PET"

ValueSet: InstrumentalInvestigationNameVS
Id: instrumental-investigation-name-vs
Title: "Instrumental Investigation Name"
Description: "ValueSet of instrumental investigation tests conducted."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ValueSet/instrumental-investigation-name"
* codes from system InstrumentalInvestigationNameCS


// ================================================
// Instrumental Investigation – extensions
// ================================================

// name – Code (CodeableConcept)
Extension: InstrumentalInvestigationName
Id: instrumental-investigation-name-ext
Title: "Instrumental investigation name"
Description: "Name of the instrumental investigation test conducted."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from InstrumentalInvestigationNameVS (required)


// ================================================
// Instrumental Investigation profile (using Basic)
// ================================================

Profile: InstrumentalInvestigation
Parent: Basic
Id: instrumental-investigation
Title: "Instrumental Investigation"
Description: "Catalogue of instrumental investigation tests, aligned with the instrumental_investigation table."

// instrumental_investigation_id → Basic.identifier (Mandatory)
* identifier 1..1 MS
* identifier ^short = "instrumental_investigation_id – identifier of the instrumental investigation test"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/instrumental-investigation-id" 
* identifier.value 1..1

// Basic.code is required but not part of DM: use a fixed text label
* code 1..1 MS
* code ^short = "Kind of Basic resource (instrumental investigation definition)"
* code.text 1..1
* code.text = "Instrumental investigation test definition"

// Attach the 'name' extension with DM variable name as slice name
* extension contains InstrumentalInvestigationName named name 1..1 MS
* extension[name] ^short = "name – Name of the instrumental investigation test conducted"


// ================================================
// Example Instrumental Investigation instance
// ================================================

Instance: InstrumentalInvestigationExample1
InstanceOf: InstrumentalInvestigation
Usage: #example
Title: "Example Instrumental Investigation"
Description: "Example imaging/instrumental investigation for a transplant patient."

* id = "instrumental-investigation-example-1"

// instrumental_investigation_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/instrumental-investigation-id"
* identifier.value = "INST0001"

// code (kind of Basic resource)
* code.text = "Instrumental investigation test definition"

// name (example: Liver doppler ultrasound)
* extension[name].valueCodeableConcept = InstrumentalInvestigationNameCS#718078008 "Liver doppler ultrasound"
