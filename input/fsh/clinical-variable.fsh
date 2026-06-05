// ================================================
// Clinical Variable — clinical_variable table
// Observation
// ================================================

Alias: $loinc   = http://loinc.org
Alias: $obs-cat = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $ucum    = http://unitsofmeasure.org

// ================================================
// Terminology — concomitant_disease code list
// ================================================

CodeSystem: ConcomitantDiseaseCategory
Id: concomitant-disease-category
Title: "Concomitant Disease Category CodeSystem"
Description: "Concomitant disease codes used in the DMv1.2 clinical_variable table. Coded values are carried as ClinicalVariable Observation components (component[concomitant_disease])."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/concomitant-disease-category"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #abdominal-pain                    "Abdominal pain"
* #abpm                              "ABPM"
* #altered-consciousness             "Altered consciousness"
* #ascites                           "Ascites"
* #cholangitis                       "Cholangitis"
* #concomitant-autoimmune-disorder   "Concomitant autoimmune disorder"
* #concomitant-pancreatic-disease    "Concomitant pancreatic disease"
* #diabetes                          "Diabetes"
* #diarrhea                          "Diarrhea"
* #edema                             "Edema"
* #epistaxis                         "Epistaxis"
* #ercp                              "ERCP"
* #fatigue                           "Fatigue"
* #fever                             "Fever"
* #gingival-hyperplasia              "Gingival hyperplasia"
* #glucose-intolerance               "Glucose intolerance"
* #headache                          "Headache"
* #hepatic-artery-thrombosis         "Hepatic Artery Thrombosis"
* #hepatic-encephalopathy            "Hepatic encephalopathy"
* #hepatic-insufficiency             "Hepatic insufficiency"
* #hepatomegaly                      "Hepatomegaly"
* #hepatopulmonary-syndrome          "Hepatopulmonary syndrome"
* #hepatorenal-syndrome              "Hepatorenal syndrome"
* #hirsutism                         "Hirsutism"
* #hypertensive-retinopathy          "Hypertensive retinopathy"
* #hypertension                      "Hypertension"
* #hypertriglyceridemia              "Hypertrigliceridemia"
* #hypoxic-ischemic-injury           "Hypoxic Ischemic Injury"
* #itching                           "Itching"
* #jaundice                          "Jaundice"
* #kidney-tma                        "Kidney TMA"
* #left-ventricular-hypertrophy      "Left ventricular hypetrophy"
* #lymphadenopathy                   "Lymphadenopathy"
* #macrohematuria                    "Macrohematuria"
* #malaise                           "Malaise"
* #nausea                            "Nausea"
* #neurological-symptoms             "Neurological symptoms"
* #oligoanuria                       "Oligoanuria"
* #oral-ulcers                       "Oral Ulcers"
* #pale-stools                       "Pale stools"
* #ptcd                              "PTCD"
* #rash                              "Rash"
* #seizures                          "Seizures"
* #spider-veins                      "Spider veins"
* #splenomegaly                      "Splenomegaly"
* #stomatitis                        "Stomatitis"
* #uremia                            "Uremia"
* #uretheral-stenosis                "Uretheral stenosis"
* #visual-disturbance                "Visual Disturbance"
* #vomiting                          "Vomiting"
* #weight-loss                       "Weight loss"
* #monoclonal-proliferation-biopsy   "Monoclonal proliferation on biopsy"
* #histological-evidence-biopsy      "Histological evidence on biopsy"
* #mmf-related-enteropathy           "Histological evidence of MMF-related enteropathy"

ValueSet: ConcomitantDiseaseCategoryVS
Id: concomitant-disease-category-vs
Title: "Concomitant Disease Category ValueSet"
Description: "Allowed concomitant disease codes in clinical_variable (DMv1.2)."
* include codes from system ConcomitantDiseaseCategory

// ================================================
// Local component codes for ClinicalVariable panel
// ================================================

CodeSystem: ClinicalVariableComponentCS
Id: clinical-variable-component-cs
Title: "Clinical Variable Component Codes"
Description: "Local codes for ClinicalVariable Observation component slices that are not covered by LOINC. Currently used for the concomitant_disease repeating component."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/clinical-variable-component"
* ^content = #complete
* ^caseSensitive = true
* ^experimental = true
* #concomitant-disease "Concomitant disease"

// ================================================
// ClinicalVariable profile — Observation
// ================================================

Profile: ClinicalVariable
Parent: Observation
Id: clinical-variable
Title: "Clinical Variable"
Description: "Clinical variables recorded for a transplant patient at a visit, aligned with the DMv1.2 clinical_variable table. Captures weight, height, diuresis, and concomitant disease(s). Vital signs (BP, HR, O2, temperature) moved to the VitalSign profile in DMv1.2."

// clinical_variable_id → Observation.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/clinical-variable-id" (exactly)
* identifier.value 1..1

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#exam (exactly)

// Panel code
* code 1..1 MS
* code = $loinc#55752-0 "Clinical information" (exactly)

// patient_id → Observation.subject
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id — transplant recipient"

// visit_id → Observation.encounter
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — visit at which these variables were recorded"

// No top-level value; measurements in components; free text in note
* value[x] 0..0

// description → Observation.note (first entry)
* note 0..* MS
* note ^short = "description / other_symptoms / other_concomitant / organ_dysfunction — free-text fields"


// ── Component slicing ──────────────────────────────────────

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open

* component contains
    weight              0..1 MS and
    height              0..1 MS and
    diuresis_value      0..1 MS and
    concomitant_disease 1..* MS

// weight (kg)
* component[weight].code = $loinc#29463-7 "Body weight" (exactly)
* component[weight].value[x] only Quantity
* component[weight].valueQuantity.system = $ucum
* component[weight].valueQuantity.code = #kg
* component[weight] ^short = "weight (kg)"

// height (cm)
* component[height].code = $loinc#8302-2 "Body height" (exactly)
* component[height].value[x] only Quantity
* component[height].valueQuantity.system = $ucum
* component[height].valueQuantity.code = #cm
* component[height] ^short = "height (cm)"

// diuresis_value (ml/day)
* component[diuresis_value].code = $loinc#9192-6 "Urine output 24 hour" (exactly)
* component[diuresis_value].value[x] only Quantity
* component[diuresis_value].valueQuantity.system = $ucum
* component[diuresis_value].valueQuantity.code = #mL/d
* component[diuresis_value] ^short = "diuresis_value — 24 h diuresis (ml/day)"

// concomitant_disease — repeat per concurrent disease
* component[concomitant_disease].code = ClinicalVariableComponentCS#concomitant-disease "Concomitant disease" (exactly)
* component[concomitant_disease].value[x] only CodeableConcept
* component[concomitant_disease].valueCodeableConcept from ConcomitantDiseaseCategoryVS (required)
* component[concomitant_disease] ^short = "concomitant_disease — coded concomitant disease (repeat per disease)"


// ================================================
// Example
// ================================================

Instance: ClinicalVariableExample1
InstanceOf: ClinicalVariable
Usage: #example
Title: "Example Clinical Variable"
Description: "Example clinical variables for a transplant patient at a 1-month follow-up visit (DMv1.2)."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/clinical-variable-id"
* identifier.value = "CV0001"
* status = #final
* category = $obs-cat#exam
* code = $loinc#55752-0 "Clinical information"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitExample1)

* component[weight].valueQuantity.value = 32.5
* component[weight].valueQuantity.system = $ucum
* component[weight].valueQuantity.code = #kg
* component[weight].valueQuantity.unit = "kg"

* component[height].valueQuantity.value = 128.0
* component[height].valueQuantity.system = $ucum
* component[height].valueQuantity.code = #cm
* component[height].valueQuantity.unit = "cm"

* component[diuresis_value].valueQuantity.value = 1200
* component[diuresis_value].valueQuantity.system = $ucum
* component[diuresis_value].valueQuantity.code = #mL/d
* component[diuresis_value].valueQuantity.unit = "ml/day"

* component[concomitant_disease].code = ClinicalVariableComponentCS#concomitant-disease "Concomitant disease"
* component[concomitant_disease].valueCodeableConcept = ConcomitantDiseaseCategory#hypertension "Hypertension"

* note[0].text = "Patient reports intermittent fatigue."
