// ================================================
// Instrumental Investigation — instrumental_investigation table (catalogue)
// ObservationDefinition
// ================================================

// ------------------------------------------------
// Terminology
// ------------------------------------------------

CodeSystem: InstrumentalInvestigationNameCS
Id: instrumental-investigation-name-cs
Title: "Instrumental Investigation Name"
Description: "Types of instrumental investigation tests conducted (expanded for DMv1.2)."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/instrumental-investigation-name"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true

* #718078008   "Liver doppler ultrasound"
* #4061009     "Abdominal CT scan"
* #4083230     "Abdominal MRI"
* #4194588     "MRCP"
* #37311324    "Brain MRI"
* #4169785     "AngioTC"
* #4299523     "Angiography"
* #4181917     "EEG"
* #36308175    "ECG"
* #4167052     "Kidney doppler ultrasound"
* #36713614    "Total body CT scan"
* #scintigraphy "Scintigraphy"
* #mcug        "Micturating Cystourethrogram (MCUG)"
* #pet         "PET"
* #dmsa-renal-scan       "DMSA Renal Scan"
* #dynamic-renal-scan    "Dynamic renal scan"
* #ecocardiogram         "Ecocardiogram"
* #kidney-biopsy         "Kidney Biopsy"
* #kidney-histology      "Kidney Histology"
* #kidney-ultrasound     "Kidney Ultrasound"
* #liver-biopsy          "Liver Biopsy"
* #liver-histology       "Liver Histology"
* #mag3-renal-scan       "MAG3 Renal Scan"
* #ultrasonography       "Ultrasonography"
* #liver-elastography    "Ultrasound (liver elastography [kPa])"

ValueSet: InstrumentalInvestigationNameVS
Id: instrumental-investigation-name-vs
Title: "Instrumental Investigation Name"
Description: "ValueSet of instrumental investigation tests conducted."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ValueSet/instrumental-investigation-name"
* codes from system InstrumentalInvestigationNameCS


// ================================================
// InstrumentalInvestigation profile — ObservationDefinition
// ================================================

Profile: InstrumentalInvestigation
Parent: ObservationDefinition
Id: instrumental-investigation
Title: "Instrumental Investigation"
Description: "Catalogue entry for an instrumental investigation test type, aligned with the instrumental_investigation table."

// instrumental_investigation_id → ObservationDefinition.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/instrumental-investigation-id" (exactly)
* identifier.value 1..1
* identifier ^short = "instrumental_investigation_id — investigation type identifier"

// name → ObservationDefinition.code (required binding)
* code 1..1 MS
* code from InstrumentalInvestigationNameVS (required)
* code ^short = "name — type of instrumental investigation"


// ================================================
// Example
// ================================================

Instance: InstrumentalInvestigationExample1
InstanceOf: InstrumentalInvestigation
Usage: #example
Title: "Example Instrumental Investigation"
Description: "Example instrumental investigation catalogue entry — Liver doppler ultrasound."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/instrumental-investigation-id"
* identifier.value = "INST0001"
* code = InstrumentalInvestigationNameCS#718078008 "Liver doppler ultrasound"
