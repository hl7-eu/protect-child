// =====================================================
// Immunosuppressant Induction to Patient
// =====================================================


// -----------------------------------------------------
// Extensions
// -----------------------------------------------------

// imm_id – ElementReference(Immunosuppressant)
Extension: ImmunosuppressiveInductionImmRef
Id: immunosuppressive-induction-imm-ref
Title: "Immunosuppressant ID relationship"
Description: "Reference to the immunosuppressant drug used for induction."
* value[x] only Reference(Immunosuppressant)
* valueReference 1..1

// patient_id – ElementReference(PatientTransplant)
Extension: ImmunosuppressiveInductionPatientRef
Id: immunosuppressive-induction-patient-ref
Title: "Patient ID relationship"
Description: "Reference to the patient receiving immunosuppressive induction."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// dose – Float
Extension: ImmunosuppressiveInductionDose
Id: immunosuppressive-induction-dose
Title: "Immunosuppressant dose"
Description: "Dose of the selected immunosuppressant used for induction."
* value[x] only Quantity
* valueQuantity 1..1
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org" (exactly)
* valueQuantity.code 1..1
* valueQuantity.unit 0..1



// -----------------------------------------------------
// Profile: ImmunosuppressiveInductionPatient (Basic)
// -----------------------------------------------------

Profile: ImmunosuppressiveInductionPatient
Parent: Basic
Id: immunosuppressive-induction-patient
Title: "Immunosuppressant Induction to Patient"
Description: "Record of immunosuppressive induction treatment given to a transplant patient."

// imm_ind_pat_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Immunosuppressant induction to patient ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunosuppressive-induction-patient-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Immunosuppressant induction record category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunosuppressive-induction-patient-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach extensions
* extension contains
    ImmunosuppressiveInductionImmRef named immId 0..1 MS and
    ImmunosuppressiveInductionPatientRef named patientId 0..1 MS and
    ImmunosuppressiveInductionDose named dose 0..1

// Short labels
* extension[immId] ^short = "Immunosuppressant ID relationship"
* extension[patientId] ^short = "Patient ID relationship"
* extension[dose] ^short = "Immunosuppressant dose (Quantity with UCUM unit)"



// -----------------------------------------------------
// Example instance
// -----------------------------------------------------

Instance: ImmunosuppressiveInductionPatientExample1
InstanceOf: ImmunosuppressiveInductionPatient
Usage: #example
Title: "Example Immunosuppressant Induction to Patient"
Description: "Example record of immunosuppressive induction therapy given to a patient."

* id = "imm-ind-pat-example-1"

// imm_ind_pat_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunosuppressive-induction-patient-id"
* identifier.value = "IIP0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunosuppressive-induction-patient-type#induction "Immunosuppressive induction"

// imm_id – link to immunosuppressant
* extension[immId].valueReference = Reference(ImmunosuppressantExample1)

// patient_id – link to patient 
* extension[patientId].valueReference = Reference(ExamplePatientTransplant1)

// dose
* extension[dose].valueQuantity.value = 0.15
* extension[dose].valueQuantity.system = "http://unitsofmeasure.org"
* extension[dose].valueQuantity.code = #mg.kg-1
* extension[dose].valueQuantity.unit = "mg/kg"

