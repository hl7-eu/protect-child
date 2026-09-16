// ================================================
// Clinical Variable — clinical_variable table
// Observation
// ================================================

Alias: $loinc    = http://loinc.org
Alias: $obs-cat  = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $ucum     = http://unitsofmeasure.org
Alias: $cond-cat = http://terminology.hl7.org/CodeSystem/condition-category

// ================================================
// Terminology — concomitant_disease code list
// ================================================

CodeSystem: ConcomitantDiseaseCategory
Id: concomitant-disease-category
Title: "Concomitant Disease Category CodeSystem"
Description: "Concomitant disease codes used in the DMv1.2 clinical_variable table. Coded values are carried as ConcomitantDisease (Condition) resources via Condition.code."
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
* ^experimental = true
* include codes from system ConcomitantDiseaseCategory

// ================================================
// ClinicalVariable profile — Observation
// ================================================

Profile: ClinicalVariable
Parent: Observation
Id: clinical-variable
Title: "Clinical Variable"
Description: "Clinical variables recorded for a transplant patient at a visit, aligned with the DMv1.2 clinical_variable table. Captures weight, height, and diuresis. Concomitant disease(s) are ConcomitantDisease (Condition) resources. Vital signs (BP, HR, O2, temperature) are in the VitalSign profile."

// clinical_variable_id → Observation.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id" (exactly)
* identifier.value 1..1

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#exam

// Panel code
* code 1..1 MS
* code = $loinc#55752-0 "Clinical information"

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
    diuresis_value      0..1 MS

// weight (kg)
* component[weight].code = $loinc#29463-7 "Body weight"
* component[weight].value[x] only Quantity
* component[weight].valueQuantity.system = $ucum
* component[weight].valueQuantity.code = #kg
* component[weight] ^short = "weight (kg)"

// height (cm)
* component[height].code = $loinc#8302-2 "Body height"
* component[height].value[x] only Quantity
* component[height].valueQuantity.system = $ucum
* component[height].valueQuantity.code = #cm
* component[height] ^short = "height (cm)"

// diuresis_value (ml/day)
* component[diuresis_value].code = $loinc#9192-6 "Urine output 24 hour"
* component[diuresis_value].value[x] only Quantity
* component[diuresis_value].valueQuantity.system = $ucum
* component[diuresis_value].valueQuantity.code = #mL/d
* component[diuresis_value] ^short = "diuresis_value — 24 h diuresis (ml/day)"


// ================================================
// ConcomitantDisease profile — Condition
// clinical_variable.concomitant_disease — one instance per concomitant disease
// ================================================

Profile: ConcomitantDisease
Parent: Condition
Id: concomitant-disease
Title: "Concomitant Disease"
Description: "A comorbid or concomitant disease recorded for a transplant patient at a visit (DMv1.2 clinical_variable.concomitant_disease). Represented as a Condition on the patient's problem list. One instance per concomitant disease."

* category 1..* MS
* category = $cond-cat#problem-list-item

// concomitant_disease → Condition.code
* code 1..1 MS
* code from ConcomitantDiseaseCategoryVS (required)
* code ^short = "concomitant_disease — coded concomitant disease"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id — transplant recipient"

// visit_id → Condition.encounter
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — visit at which the concomitant disease was recorded"


// ================================================
// Example
// ================================================

Instance: ClinicalVariableExample1
InstanceOf: ClinicalVariable
Usage: #example
Title: "Example Clinical Variable"
Description: "Example clinical variables for a transplant patient at a 1-month follow-up visit (DMv1.2)."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id"
* identifier.value = "CLV-1-0001"
* status = #final
* category = $obs-cat#exam
* code = $loinc#55752-0 "Clinical information"
* subject = Reference(ExamplePatientTransplant1)
* performer = Reference(PCCenter1LaPaz)
* encounter = Reference(VisitExample1)
* effectiveDateTime = "2023-09-15"

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

* note[0].text = "Patient reports intermittent fatigue."

Instance: ConcomitantDiseaseExample1
InstanceOf: ConcomitantDisease
Usage: #example
Title: "Example Concomitant Disease"
Description: "Example concomitant disease (hypertension) recorded for a transplant patient at a follow-up visit (DMv1.2)."

* category = $cond-cat#problem-list-item
* code = ConcomitantDiseaseCategory#hypertension "Hypertension"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitExample1)
* onsetDateTime = "2023-09-01"
