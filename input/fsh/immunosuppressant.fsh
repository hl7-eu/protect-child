// ================================================
// Immunosuppressant – terminology
// ================================================

CodeSystem: ImmunosuppressantDrugTypeCS
Id: immunosuppressant-drug-type-cs
Title: "Immunosuppressant Drug Type"
Description: "Types of immunosuppressive drugs used in the transplant setting."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true

* #1506270  "Steroid (methylprednisolone)"
* #1551099  "Steroid (prednisone)"
* #cni-fk506 "CNI (FK506)"
* #cni-csa  "CNI (CsA)"
* #19003999 "MMF"
* #19012565 "MPA (mycophenolic acid)"
* #19038440 "Basiliximab"
* #19136207 "ATG"
* #19011440 "Everolimus"
* #19034726 "Sirolimus"

ValueSet: ImmunosuppressantDrugTypeVS
Id: immunosuppressant-drug-type-vs
Title: "Immunosuppressant Drug Type"
Description: "ValueSet of immunosuppressive drug types."
* ^experimental = true
* codes from system ImmunosuppressantDrugTypeCS


// ================================================
// Immunosuppressant profile — immunosuppressant table
// Medication

Profile: Immunosuppressant
Parent: http://hl7.eu/fhir/base/StructureDefinition/medication-eu-core
Id: immunosuppressant
Title: "Immunosuppressant"
Description: "Immunosuppressive drug catalogue entry. imm_id is carried as an identifier; the drug name maps to Medication.code."

// imm_id → Medication.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id" (exactly)
* identifier.value 1..1

// name → Medication.code
* code 1..1 MS
* code from ImmunosuppressantDrugTypeVS (required)
* code ^short = "Immunosuppressant drug name (imm_id.name from the data model)"

* status 1..1 MS


// ================================================
// Example
// ================================================

Instance: ImmunosuppressantExample1
InstanceOf: Immunosuppressant
Usage: #example
Title: "Example Immunosuppressant"
Description: "Methylprednisolone as an immunosuppressant catalogue entry."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id"
* identifier.value = "IMM-0001"
* status = #active
* code = ImmunosuppressantDrugTypeCS#1506270 "Steroid (methylprednisolone)"

Instance: ImmunosuppressantTacrolimus1
InstanceOf: Immunosuppressant
Usage: #example
Title: "Example Immunosuppressant — Tacrolimus"
Description: "Tacrolimus (FK506) catalogue entry, referenced by the maintenance ImmPat records in both worked examples."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id"
* identifier.value = "IMM-0002"
* status = #active
* code = ImmunosuppressantDrugTypeCS#cni-fk506 "CNI (FK506)"

Instance: ImmunosuppressantBasiliximab1
InstanceOf: Immunosuppressant
Usage: #example
Title: "Example Immunosuppressant — Basiliximab"
Description: "Basiliximab catalogue entry, used for induction in the kidney worked example."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id"
* identifier.value = "IMM-0003"
* status = #active
* code = ImmunosuppressantDrugTypeCS#19038440 "Basiliximab"
