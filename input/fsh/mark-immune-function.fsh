// =====================================================
// Marker of Immune Function
// Table: mark_imm_func
// =====================================================


// -----------------------------------------------------
// Extensions
// -----------------------------------------------------

// patient_id – ElementReference(PatientTransplant)
Extension: MarkerImmuneFunctionPatientRef
Id: marker-immune-function-patient-ref
Title: "Patient ID relationship"
Description: "Reference to the patient for whom the immune function markers are recorded."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// hla_antibody_class – String
Extension: MarkerImmuneFunctionHlaAntibodyClass
Id: marker-immune-function-hla-antibody-class
Title: "HLA antibody class or locus"
Description: "Class or locus of the HLA antibody being recorded."
* value[x] only string
* valueString 1..1

// mfi_value – String (median fluorescence intensity)
Extension: MarkerImmuneFunctionMfiValue
Id: marker-immune-function-mfi-value
Title: "MFI value"
Description: "Median Fluorescence Intensity (MFI) for the HLA antibody listed in hla_antibody_class."
* value[x] only string
* valueString 1..1

// dsa – Boolean (yes/no donor-specific antibody)
Extension: MarkerImmuneFunctionDsa
Id: marker-immune-function-dsa
Title: "Donor-specific antibody (DSA)"
Description: "Donor-specific antibody flag for the HLA antibody above (yes/no)."
* value[x] only boolean
* valueBoolean 1..1

// atr1 – Float
Extension: MarkerImmuneFunctionAtr1
Id: marker-immune-function-atr1
Title: "AT1R antibody result"
Description: "Angiotensin II type-1 receptor (AT1R) antibody result."
* value[x] only decimal
* valueDecimal 1..1

// etar – Float
Extension: MarkerImmuneFunctionEtar
Id: marker-immune-function-etar
Title: "ETAR antibody result"
Description: "Endothelin receptor type-A (ETAR) antibody result."
* value[x] only decimal
* valueDecimal 1..1

// mica – Float
Extension: MarkerImmuneFunctionMica
Id: marker-immune-function-mica
Title: "Anti-MICA antibody result"
Description: "Anti-MICA (MHC class I–related chain A) antibody result."
* value[x] only decimal
* valueDecimal 1..1

// micb – Float
Extension: MarkerImmuneFunctionMicb
Id: marker-immune-function-micb
Title: "Anti-MICB antibody result"
Description: "Anti-MICB (MHC class I–related chain B) antibody result."
* value[x] only decimal
* valueDecimal 1..1

// aeca_other – String
Extension: MarkerImmuneFunctionAecaOther
Id: marker-immune-function-aeca-other
Title: "AECA / other non-HLA antibodies"
Description: "Anti-endothelial cell antibodies or other non-HLA antibodies not captured above."
* value[x] only string
* valueString 1..1



// -----------------------------------------------------
// Profile: MarkerImmuneFunction (Basic)
// -----------------------------------------------------

Profile: MarkerImmuneFunction
Parent: Basic
Id: marker-immune-function
Title: "Marker of Immune Function"
Description: "Markers of immune function including HLA and non-HLA antibodies for a transplant patient."

// mark_imm_func_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Marker of immune function ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/marker-immune-function-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Immune function marker record category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/marker-immune-function-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach marker-immune-function-specific extensions
* extension contains
    MarkerImmuneFunctionPatientRef named patientId 0..1 MS and
    MarkerImmuneFunctionHlaAntibodyClass named hlaAntibodyClass 0..1 and
    MarkerImmuneFunctionMfiValue named mfiValue 0..1 and
    MarkerImmuneFunctionDsa named dsa 0..1 and
    MarkerImmuneFunctionAtr1 named atr1 0..1 and
    MarkerImmuneFunctionEtar named etar 0..1 and
    MarkerImmuneFunctionMica named mica 0..1 and
    MarkerImmuneFunctionMicb named micb 0..1 and
    MarkerImmuneFunctionAecaOther named aecaOther 0..1

// Short labels
* extension[patientId] ^short = "Patient ID relationship"
* extension[hlaAntibodyClass] ^short = "Class or locus of the HLA antibody"
* extension[mfiValue] ^short = "MFI for that HLA antibody"
* extension[dsa] ^short = "Donor-specific antibody flag (yes/no)"
* extension[atr1] ^short = "AT1R antibody result"
* extension[etar] ^short = "ETAR antibody result"
* extension[mica] ^short = "Anti-MICA antibody result"
* extension[micb] ^short = "Anti-MICB antibody result"
* extension[aecaOther] ^short = "AECA / other non-HLA antibodies"


// -----------------------------------------------------
// Example instance
// -----------------------------------------------------

Instance: MarkerImmuneFunctionExample1
InstanceOf: MarkerImmuneFunction
Usage: #example
Title: "Example Marker of Immune Function"
Description: "Example immune function marker record for a transplant patient."

* id = "mark-imm-func-example-1"

// mark_imm_func_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/marker-immune-function-id"
* identifier.value = "MIF0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/marker-immune-function-type#antibody "Antibody marker"

// patient_id
* extension[patientId].valueReference = Reference(ExamplePatientTransplant1)

// hla_antibody_class
* extension[hlaAntibodyClass].valueString = "HLA-DQ7"

// mfi_value
* extension[mfiValue].valueString = "3500"

// dsa (yes → true)
* extension[dsa].valueBoolean = true

// atr1, etar, mica, micb – example numeric values
* extension[atr1].valueDecimal = 12.3
* extension[etar].valueDecimal = 8.7
* extension[mica].valueDecimal = 5.2
* extension[micb].valueDecimal = 4.9

// aeca_other
* extension[aecaOther].valueString = "Low-titer anti-endothelial cell antibodies"
