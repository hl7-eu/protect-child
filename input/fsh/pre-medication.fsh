// ================================================
// Pre-medication – terminology, extensions & profile
// ================================================

// --------------------------------
// Type of pre-medication record (for Basic.code)
// --------------------------------
CodeSystem: PreMedicationTypeCS
Id: pre-medication-type-cs
Title: "Pre-medication Type CodeSystem"
Description: "Type of pre-transplant medication record."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/pre-medication-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #pre-medication "Pre-transplant medication record"

ValueSet: PreMedicationTypeVS
Id: pre-medication-type-vs
Title: "Pre-medication Type ValueSet"
Description: "Allowed type(s) for pre-medication records."
* PreMedicationTypeCS#pre-medication

// --------------------------------
// Antihypertensive treatment drugs
// --------------------------------
CodeSystem: PreMedicationAntihypertensiveDrugCS
Id: pre-medication-antihypertensive-drug-cs
Title: "Pre-medication Antihypertensive Drug CodeSystem"
Description: "Antihypertensive drugs used as pre-transplant medication."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/pre-medication-antihypertensive-drug"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #1332418 "Amlodipine"
* #1318853 "Nifedipine"
* #1340128 "Captopril"
* #1314002 "Atenolol"
* #1346823 "Carvedilol"
* #1353766 "Propranolol"
* #1309068 "Minoxidil"
* #1398937 "Clonidine"
* #1363053 "Doxazosin"

ValueSet: PreMedicationAntihypertensiveDrugVS
Id: pre-medication-antihypertensive-drug-vs
Title: "Pre-medication Antihypertensive Drug ValueSet"
Description: "Allowed antihypertensive drugs for antihypertensive_treatment."
* PreMedicationAntihypertensiveDrugCS#1332418
* PreMedicationAntihypertensiveDrugCS#1318853
* PreMedicationAntihypertensiveDrugCS#1340128
* PreMedicationAntihypertensiveDrugCS#1314002
* PreMedicationAntihypertensiveDrugCS#1346823
* PreMedicationAntihypertensiveDrugCS#1353766
* PreMedicationAntihypertensiveDrugCS#1309068
* PreMedicationAntihypertensiveDrugCS#1398937
* PreMedicationAntihypertensiveDrugCS#1363053

// ================================================
// Extensions
// ================================================

// patient_id – Reference(PatientTransplant)
Extension: PreMedicationPatientRef
Id: pre-medication-patient-ref
Title: "Pre-medication patient reference"
Description: "patient_id – reference to the transplant recipient for whom the pre-medication is recorded."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// antihypertensive_treatment – Code (drug from VS)
Extension: PreMedicationAntihypertensiveTreatment
Id: pre-medication-antihypertensive-treatment
Title: "Antihypertensive treatment"
Description: "antihypertensive_treatment – blood-pressure–lowering drug(s) used pre-transplant."
* value[x] only CodeableConcept
* valueCodeableConcept from PreMedicationAntihypertensiveDrugVS (required)

// rituximab – Boolean
Extension: PreMedicationRituximab
Id: pre-medication-rituximab
Title: "Rituximab pre-medication"
Description: "rituximab – any rituximab given pre-transplant."
* value[x] only boolean

// antiviral_phrophylaxis – Boolean (Kidney only)
Extension: PreMedicationAntiviralPhrophylaxis
Id: pre-medication-antiviral-phrophylaxis
Title: "Antiviral prophylaxis pre-medication"
Description: "antiviral_phrophylaxis – preventive antiviral medication(s) given to reduce risk of viral infection or reactivation (Kidney only)."
* value[x] only boolean

// other_medications – String
Extension: PreMedicationOtherMedications
Id: pre-medication-other-medications
Title: "Other pre-transplant medications"
Description: "other_medications – any other relevant pre-transplant medications."
* value[x] only string

// ================================================
// PreMedication profile (Basic)
// ================================================

Profile: PreMedication
Parent: Basic
Id: pre-medication
Title: "Pre-transplant Medication"
Description: "Pre-transplant medication record aligned with the pre_medication table."

// pre_medication_id → Basic.identifier (Mandatory)
* identifier 1..1 MS
* identifier ^short = "pre_medication_id – identifier for this pre-medication record"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/pre-medication-id" (exactly)
* identifier.value 1..1

// Basic.code – type of Basic
* code 1..1 MS
* code ^short = "Type of pre-medication record"
* code ^binding.strength = #required
* code ^binding.valueSet = Canonical(PreMedicationTypeVS)

// Attach extensions using DM variable names as slice names
* extension contains PreMedicationPatientRef named patient_id 1..1 MS and
    PreMedicationAntihypertensiveTreatment named antihypertensive_treatment 1..1 MS and
    PreMedicationRituximab named rituximab 1..1 MS and
    PreMedicationAntiviralPhrophylaxis named antiviral_phrophylaxis 0..1 MS and
    PreMedicationOtherMedications named other_medications 1..1 MS

* extension[patient_id] ^short = "patient_id – reference to PatientTransplant (recipient)"
* extension[antihypertensive_treatment] ^short = "antihypertensive_treatment – antihypertensive drug used pre-transplant"
* extension[rituximab] ^short = "rituximab – any rituximab given pre-transplant (Yes/No)"
* extension[antiviral_phrophylaxis] ^short = "antiviral_phrophylaxis – antiviral prophylaxis given (Kidney only)"
* extension[other_medications] ^short = "other_medications – other relevant pre-transplant medications (free text)"

// ================================================
// Example Pre-medication instance
// ================================================

Instance: PreMedicationExample1
InstanceOf: PreMedication
Usage: #example
Title: "Example Pre-medication"
Description: "Example record of pre-transplant medications."

* id = "pre-medication-example-1"

// pre_medication_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/pre-medication-id"
* identifier.value = "PM0001"

// Basic.code – type
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/pre-medication-type#pre-medication "Pre-transplant medication record"

// patient_id
* extension[patient_id].valueReference = Reference(ExamplePatientTransplant1)

// antihypertensive_treatment (example: Amlodipine)
* extension[antihypertensive_treatment].valueCodeableConcept = 
    PreMedicationAntihypertensiveDrugCS#1332418 "Amlodipine"

// rituximab
* extension[rituximab].valueBoolean = true

// antiviral_phrophylaxis (example: none given)
* extension[antiviral_phrophylaxis].valueBoolean = false

// other_medications
* extension[other_medications].valueString = "Low-dose aspirin"
