// ================================================
// Lab Test – terminology
// ================================================

CodeSystem: LabTestNameCS
Id: lab-test-name-cs
Title: "Lab Test Name"
Description: "Types of laboratory tests conducted."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/lab-test-name"
* ^content = #complete

* #46273815 "Albumin"
* #4108431 "Albumin/creatinine ratio"
* #ALT "ALT"
* #4017613 "Ammonium levels"
* #AST "AST"
* #35816690 "Calcium"
* #19059097 "Cholesterol"
* #19071968 "Creatinine"
* #creatinine-egfr "Creatinine Estimated Glomerular Filtration rate"
* #44789161 "Cystatin C"
* #cystatinc-egfr "Cystatin C Estimated Glomerular Filtration rate"
* #4216632 "Direct Bilirubin"
* #35960055 "GGT"
* #1560524 "Glucose"
* #35198163 "Haptoglobin"
* #36304734 "HbA1c"
* #4151358 "Hematocrit"
* #36862556 "Hemoglobin"
* #indirect-bilirubin "Indirect Bilirubin"
* #INR "INR"
* #19011035 "Lactate"
* #35955655 "LDH"
* #36309122 "Lymphocytes"
* #36308680 "Neutrophils"
* #21498711 "pH"
* #36310193 "Platelets"
* #19049024 "Potassium"
* #proteinuria-creatininuria-ratio "Proteinuria/creatininuria ratio"
* #3002681 "Prothrombin Activity"
* #4245261 "Prothrombin Time"
* #4054726 "Red Blood Cells"
* #4150494 "Serum bicarbonate"
* #19136048 "Sodium"
* #4230543 "Total Bilirubin"
* #4119650 "Total protein"
* #906914 "Urea"
* #43532213 "Uric acid"
* #4150621 "Urine Creatinine"
* #321414 "Urine Haemoglobin"
* #4198678 "White Blood Cells"
* #phosphorus "Phosphorus"
* #pth "PTH (parathormone)"
* #vitamin-d "Vitamin D"
* #aPTT "aPTT"
* #urine-microscopic-hematuria "Urine microscopic hematuria"
* #quantitative-proteinuria "Quantitative proteinuria"
* #bile-acids "Bile acids"
* #HCO3 "HCO3"

ValueSet: LabTestNameVS
Id: lab-test-name-vs
Title: "Lab Test Name"
Description: "ValueSet of laboratory tests conducted."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ValueSet/lab-test-name"
* codes from system LabTestNameCS



// ================================================
// Lab Test – extensions
// ================================================

// unit_id – ElementReference(Unit)
Extension: LabTestUnitRef
Id: lab-test-unit-ref
Title: "Unit ID relationship"
Description: "Reference to the unit definition associated with this lab test."
* value[x] only Reference
* valueReference 1..1

// name – CodeableConcept from LabTestNameVS
Extension: LabTestName
Id: lab-test-name-ext
Title: "Lab test name"
Description: "Name of the laboratory test conducted."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from LabTestNameVS (required)



// ================================================
// Lab Test profile (using Basic)
// ================================================

Profile: LabTest
Parent: Basic
Id: lab-test
Title: "Lab Test"
Description: "Definition of a laboratory test, including its name and unit."

// lab_test_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Lab Test ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/lab-test-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Lab test record category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/lab-test-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach lab-test-specific extensions
* extension contains
    LabTestUnitRef named unitId 0..1 MS and
    LabTestName named name 0..1 MS

* extension[unitId] ^short = "Unit ID relationship"
* extension[name] ^short = "Name of the lab test (coded)"



// ================================================
// Example Lab Test instance
// ================================================

Instance: LabTestExample1
InstanceOf: LabTest
Usage: #example
Title: "Example Lab Test"
Description: "Example definition of a lab test (Albumin)."

* id = "lab-test-example-1"

// lab_test_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/lab-test-id"
* identifier.value = "LT0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/lab-test-type#chemistry "Chemistry lab test"


// name (Albumin)
* extension[name].valueCodeableConcept =
    https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/lab-test-name#46273815 "Albumin"
