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
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true

* #718078008   "Liver doppler ultrasound" "Doppler ultrasound assessment of hepatic vasculature."
* #4061009     "Abdominal CT scan" "Computed tomography of the abdomen."
* #4083230     "Abdominal MRI" "Magnetic resonance imaging of the abdomen."
* #4194588     "MRCP" "Magnetic resonance cholangiopancreatography (MRCP)."
* #37311324    "Brain MRI" "Magnetic resonance imaging of the brain."
* #4169785     "AngioTC" "CT angiography."
* #4299523     "Angiography" "Catheter/contrast angiography of blood vessels."
* #4181917     "EEG" "Electroencephalography (EEG)."
* #36308175    "ECG" "Electrocardiography (ECG)."
* #4167052     "Kidney doppler ultrasound" "Doppler ultrasound assessment of renal vasculature."
* #36713614    "Total body CT scan" "Whole-body computed tomography."
* #scintigraphy "Scintigraphy" "Radionuclide scintigraphy imaging."
* #mcug        "Micturating Cystourethrogram (MCUG)" "Micturating cystourethrogram (voiding cystourethrography)."
* #pet         "PET" "Positron emission tomography (PET)."
* #dmsa-renal-scan       "DMSA Renal Scan" "DMSA renal cortical scintigraphy (scarring / differential function)."
* #dynamic-renal-scan    "Dynamic renal scan" "Dynamic renal scintigraphy (drainage / function)."
* #ecocardiogram         "Ecocardiogram" "Echocardiography."
* #kidney-biopsy         "Kidney Biopsy" "Percutaneous biopsy of the kidney allograft."
* #kidney-histology      "Kidney Histology" "Histopathological examination of kidney tissue."
* #kidney-ultrasound     "Kidney Ultrasound" "Ultrasound imaging of the kidney."
* #liver-biopsy          "Liver Biopsy" "Percutaneous biopsy of the liver allograft."
* #liver-histology       "Liver Histology" "Histopathological examination of liver tissue."
* #mag3-renal-scan       "MAG3 Renal Scan" "MAG3 dynamic renal scintigraphy."
* #ultrasonography       "Ultrasonography" "General ultrasound imaging."
* #liver-elastography    "Ultrasound (liver elastography [kPa])" "Ultrasound liver elastography (stiffness in kPa)."

ValueSet: InstrumentalInvestigationNameVS
Id: instrumental-investigation-name-vs
Title: "Instrumental Investigation Name"
Description: "ValueSet of instrumental investigation tests conducted."
* ^experimental = true
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
