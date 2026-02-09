// =====================================================
// Post Event Type – terminology
// Table: post_event_type
// =====================================================

CodeSystem: PostEventTypeNameCS
Id: post-event-type-name-cs
Title: "Post Event Type Name"
Description: "Types of post-transplant events."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/post-event-type-name"
* ^content = #complete

* #episodes-aki-after-ltx "Episodes of AKI after LTx"
* #hypoxic-ischemic-after-pltx "Hypoxic ischemic events after pLTx"
* #liver-rejection-banff "Histological evidence of liver rejection based on Banff classification (IC/IF/C4d)"
* #intestinal-mmf-toxicity "Histological evidence of intestinal MMF toxicity on intestinal biopsy"
* #dialysis-after-tx "Dialysis after transplant (yes/no, start and stop date, type)"
* #tma-kidney-biopsy "Histological evidence of Thrombotic Microangiopathy (TMA) on kidney biopsy"
* #cni-toxicity "Histological evidence of CNI toxicity"
* #bkv-kidney-biopsy "Histological evidence of BKV virus/ BKV-DNA on kidney biopsy/ BKV FISH on kidney biopsy"
* #mmf-related-enteropathy "Histological evidence of MMF-related enteropathy"
* #regression-after-dose-change "Regression of symptoms after suspension/dose reduction"
* #other-organ-damage "Other organ damage"
* #alloimmunization "Alloimmunization"
* #delayed-graft-function "Delayed Graft function"
* #liver-rejection-episode-histology "Liver rejection episode histology (histology (description, Banff category, immunohistochemistry/IF/C4d)"
* #previous-liver-rejections "Previous liver rejections (Banff category, treatment)"
* #chronic-liver-rejection-histology "Chronic liver rejection histology (description, Banff, category, IHC/IF/C4d)"
* #monoclonal-proliferation-biopsy "Monoclonal proliferation on biopsy"
* #liver-replacement-therapy "Liver replacement therapy (need for retransplantation)"
* #kidney-rejection-episode-histology "Kidney rejection episode histology (description, Banff category, immunochemistry/if/c4D)"
* #previous-kidney-rejection "Previous kidney rejection (Banff category, treatment)"
* #kidney-replacement-therapy "Kidney replacement therapy (Need for retransplantation)"

ValueSet: PostEventTypeNameVS
Id: post-event-type-name-vs
Title: "Post Event Type Name"
Description: "ValueSet of post-transplant event types."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ValueSet/post-event-type-name"
* codes from system PostEventTypeNameCS



// =====================================================
// Post Event Type – extensions
// =====================================================

// name – CodeableConcept from PostEventTypeNameVS
Extension: PostEventTypeName
Id: post-event-type-name-ext
Title: "Post event type name"
Description: "Name of the post-transplant event type."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from PostEventTypeNameVS (required)



// =====================================================
// Post Event Type profile (using Basic)
// =====================================================

Profile: PostEventType
Parent: Basic
Id: post-event-type
Title: "Post Event Type"
Description: "Definition of a post-transplant event type."

// post_event_type_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Post event type ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/post-event-type-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Post event type record category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/post-event-type-category" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach name extension
* extension contains
    PostEventTypeName named name 0..1 MS

* extension[name] ^short = "Post event type name (coded)"



// =====================================================
// Example Post Event Type instance
// =====================================================

Instance: PostEventTypeExample1
InstanceOf: PostEventType
Usage: #example
Title: "Example Post Event Type"
Description: "Example post-transplant event type: Episodes of AKI after LTx."

* id = "post-event-type-example-1"

// post_event_type_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/post-event-type-id"
* identifier.value = "PET0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/post-event-type-category#clinical-event "Clinical post-transplant event"

// name (Episodes of AKI after LTx)
* extension[name].valueCodeableConcept =
    https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/post-event-type-name#episodes-aki-after-ltx "Episodes of AKI after LTx"
