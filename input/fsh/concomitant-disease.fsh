
// ================================================
// Concomitant Disease – CodeSystem, ValueSet, extension & profile
// ================================================

// --------------------------------
// CodeSystem for concomitant disease name
// --------------------------------
CodeSystem: ConcomitantDiseaseCategory
Id: concomitant-disease-category
Title: "Concomitant Disease Category"
Description: "Categories of relevant concomitant diseases."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-disease-category"
* ^content = #complete

* #45879544 "Edema"
* #4261202 "Uremia"
* #45877479 "Itching"
* #45884747 "Diarrhea"
* #36308435 "Ascites"
* #45881353 "Jaundice"
* #134718 "Hirsutism"
* #45879799 "Diabetes"
* #21499042 "Oligoanuria"
* #200527 "Splenomegaly"
* #45881444 "Fatigue"
* #315085 "Lymphadenopathy"
* #4010094 "Spider veins"
* #195856 "Cholangitis"
* #4120314 "Hypertriglyceridemia"
* #4029488 "Hepatic encephalopathy"
* #4229881 "Weight loss"
* #4272240 "Malaise"
* #40480518 "Gingival hyperplasia"
* #3013667 "Pale stools"
* #197676 "Hepatomegaly"
* #4318546 "Urethral stenosis"
* #42869825 "Left ventricular hypertrophy"
* #376965 "Hypertensive retinopathy"
* #45877062 "Abdominal pain"
* #44806743 "Glucose intolerance"
* #4159144 "Hepatopulmonary syndrome"
* #196455 "Hepatorenal syndrome"
* #434621 "Concomitant autoimmune disorder"
* #thyroid-disease-specify "Thyroid disease (specify)"
* #anaemia "Anaemia"
* #uremic-symptoms "Uremic symptoms"
* #metabolic-acidosis "Metabolic acidosis"
* #hypertension "Hypertension"
* #concomitant-pancreatic-disease "Concomitant pancreatic disease"
* #other-concomitant-diseases "Other concomitant diseases"
* #other-organ-damage "Other organ damage"
* #4117779 "Neurological symptom – Peripheral neuropathy"
* #376099 "Neurological symptom – Tremors"
* #373873005 "Neurological symptom – PRES"


// --------------------------------
// ValueSet for concomitant disease name
// --------------------------------
ValueSet: ConcomitantDiseaseCategoryVS
Id: concomitant-disease-category-vs
Title: "Concomitant Disease Category ValueSet"
Description: "ValueSet of relevant concomitant diseases."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ValueSet/concomitant-disease-category"
* include codes from system ConcomitantDiseaseCategory


// ================================================
// Extension
// ================================================

// name – CodeableConcept from ConcomitantDiseaseCategory
Extension: ConcomitantDiseaseName
Id: concomitant-disease-name
Title: "Concomitant disease name(s)"
Description: "Set of relevant concomitant diseases."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from ConcomitantDiseaseCategoryVS (preferred)


// ================================================
// Concomitant Disease profile (using Basic)
// ================================================

Profile: ConcomitantDisease
Parent: Basic
Id: concomitant-disease
Title: "Concomitant Disease"
Description: "Relevant concomitant diseases associated to a subject or record."

// concomitant_disease_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Concomitant disease ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-disease-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Concomitant disease category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-disease-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach Concomitant Disease–specific extensions
* extension contains
    ConcomitantDiseaseName named concomitantDiseaseName 0..1 MS

* extension[concomitantDiseaseName] ^short = "Concomitant disease (coded from ConcomitantDiseaseCategory)"


// ================================================
// Example Concomitant Disease instance
// ================================================

Instance: ConcomitantDiseaseExample1
InstanceOf: ConcomitantDisease
Usage: #example
Title: "Example Concomitant Disease"
Description: "Example record of a concomitant disease."

* id = "concomitant-disease-example-1"

// concomitant_disease_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-disease-id"
* identifier.value = "CD0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-disease-type#relevant "Relevant concomitant disease(s)"

// name (example: Hypertension)
* extension[concomitantDiseaseName].valueCodeableConcept =
    https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-disease-category#hypertension "Hypertension"
