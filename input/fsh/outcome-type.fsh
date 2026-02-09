// =====================================================
// Outcome Type – terminology
// Table: outcome_type
// =====================================================

CodeSystem: OutcomeTypeNameCS
Id: outcome-type-name-cs
Title: "Outcome Type Name"
Description: "Types of clinical outcomes after transplant."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/outcome-type-name"
* ^content = #complete

* #ebv-infection "Epstein Barr Infection (Need more specific one)"
* #440032 "Cytomegalovirus Infection"
* #4265526 "BK Virus Infection"
* #45765696 "Renal Calcineurin Inhibitors Toxicity"
* #mycophenolate-toxicity "Mycophenolate toxicity"
* #mtor-toxicity "mTOR inhibitors toxicity"
* #321876 "Microangiopathy"
* #kidney-rejection-episode "Kidney rejection episode"
* #4341657 "Liver rejection episode"
* #198185 "Chronic renal failure after pLTx"
* #4267417 "Liver Graft fibrosis"
* #4064161 "Cirrhosis of Liver"
* #chronic-liver-failure "Chronic liver failure (liver graft fibrosis and cirrhosis)"
* #4198610 "Chronic liver rejection"
* #435514 "Chronic Kidney Rejection"
* #ptld "Post-transplant lymphoproliferative disease (PTLD)"
* #316866 "High Blood pressure"
* #35817874 "Diabetes"
* #alloimmunization "Alloimmunization"
* #4223098 "Hepatic artery thrombosis"
* #biliary-complications "Billiary complications"
* #urological-complications "Urological Complications"
* #mortality "Mortality"
* #graft-survival "Graft survival"
* #liver-primary-nonfunction "Liver primary nonfunction"
* #liver-early-allograft-dysfunction "Liver early allograft dysfunction"
* #kidney-primary-nonfunction "Kidney primary nonfunction"
* #delayed-kidney-graft-function "Delayed kidney graft function"
* #42872891 "Posterior reversible encelopathy (PRES)"
* #relapse-primary-immunomediated "Relapse of primary immunomediated disease"

ValueSet: OutcomeTypeNameVS
Id: outcome-type-name-vs
Title: "Outcome Type Name"
Description: "ValueSet of post-transplant outcome types."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ValueSet/outcome-type-name"
* codes from system OutcomeTypeNameCS



// =====================================================
// Outcome Type – extensions
// =====================================================

// name – CodeableConcept from OutcomeTypeNameVS
Extension: OutcomeTypeName
Id: outcome-type-name-ext
Title: "Outcome type name"
Description: "Name of the outcome type."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from OutcomeTypeNameVS (required)



// =====================================================
// Outcome Type profile (using Basic)
// =====================================================

Profile: OutcomeType
Parent: Basic
Id: outcome-type
Title: "Outcome Type"
Description: "Definition of an outcome type used to categorize outcome records."

// outcome_type_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Outcome type ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/outcome-type-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Outcome type record category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/outcome-type-category" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach name extension
* extension contains
    OutcomeTypeName named name 0..1 MS

* extension[name] ^short = "Outcome type name (coded)"



// =====================================================
// Example Outcome Type instance
// =====================================================

Instance: OutcomeTypeExample1
InstanceOf: OutcomeType
Usage: #example
Title: "Example Outcome Type"
Description: "Example outcome type: Chronic renal failure after pLTx."

* id = "outcome-type-example-1"

// outcome_type_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/outcome-type-id"
* identifier.value = "OT0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/outcome-type-category#clinical "Clinical outcome type"

// name (Chronic renal failure after pLTx)
* extension[name].valueCodeableConcept =
    https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/outcome-type-name#198185 "Chronic renal failure after pLTx"
