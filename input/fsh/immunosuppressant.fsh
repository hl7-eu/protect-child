// ================================================
// Immunosuppressant – terminology
// ================================================

CodeSystem: ImmunosuppressantDrugTypeCS
Id: immunosuppressant-drug-type-cs
Title: "Immunosuppressant Drug Type"
Description: "Types of immunosuppressive drugs used in the transplant setting."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunosuppressant-drug-type"
* ^content = #complete

* #1506270 "Steroid (methylprednisolone)"
* #1551099 "Steroid (prednisone)"
* #cni-fk506 "CNI (FK506)"
* #cni-csa "CNI (CsA)"
* #19003999 "MMF"
* #19038440 "Basiliximab"
* #35806359 "ATG"
* #19011440 "Everolimus"
* #19034726 "Sirolimus"

ValueSet: ImmunosuppressantDrugTypeVS
Id: immunosuppressant-drug-type-vs
Title: "Immunosuppressant Drug Type"
Description: "ValueSet of immunosuppressive drug types."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ValueSet/immunosuppressant-drug-type"
* codes from system ImmunosuppressantDrugTypeCS


// ================================================
// Immunosuppressant – extensions
// ================================================

// name – Code (CodeableConcept) from the above ValueSet
Extension: ImmunosuppressantName
Id: immunosuppressant-name
Title: "Immunosuppressant name"
Description: "Name/type of the immunosuppressant drug."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from ImmunosuppressantDrugTypeVS (required)


// ================================================
// Immunosuppressant profile (using Basic)
// ================================================

Profile: Immunosuppressant
Parent: Basic
Id: immunosuppressant
Title: "Immunosuppressant"
Description: "Immunosuppressive drug definition used in initial or maintenance therapy."

// imm_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Immunosuppressant ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunosuppressant-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Immunosuppressant record category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunosuppressant-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach Immunosuppressant-specific extensions
* extension contains
    ImmunosuppressantName named name 0..1 MS

* extension[name] ^short = "Name of the immunosuppressant drug (coded)"


// ================================================
// Example Immunosuppressant instance
// ================================================

Instance: ImmunosuppressantExample1
InstanceOf: Immunosuppressant
Usage: #example
Title: "Example Immunosuppressant"
Description: "Example immunosuppressant drug definition."

* id = "immunosuppressant-example-1"

// imm_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunosuppressant-id"
* identifier.value = "IMM0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunosuppressant-type#drug "Immunosuppressive drug"

// name (example: Steroid – methylprednisolone)
* extension[name].valueCodeableConcept =
    https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunosuppressant-drug-type#1506270 "Steroid (methylprednisolone)"
