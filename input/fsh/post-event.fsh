// =====================================================
// Post-Transplant Event
// =====================================================


// -----------------------------------------------------
// Extensions
// -----------------------------------------------------

// post_event_type_id – ElementReference(PostEventType)
Extension: PostEventTypeRef
Id: post-event-type-ref
Title: "Post event type ID relationship"
Description: "Reference to the type/category of the post-transplant event."
* value[x] only Reference(PostEventType)
* valueReference 1..1

// patient_id – ElementReference(PatientTransplant)
Extension: PostEventPatientRef
Id: post-event-patient-ref
Title: "Patient ID relationship"
Description: "Reference to the patient who experienced the post-transplant event."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// onset_date – Date
Extension: PostEventOnsetDate
Id: post-event-onset-date
Title: "Event onset date"
Description: "Date when the post-transplant event started."
* value[x] only date
* valueDate 1..1

// end_date – Date
Extension: PostEventEndDate
Id: post-event-end-date
Title: "Event end date"
Description: "Date when the post-transplant event resolved or ended."
* value[x] only date
* valueDate 1..1

// description – String
Extension: PostEventDescription
Id: post-event-description
Title: "Event description"
Description: "Free-text description of the post-transplant event."
* value[x] only string
* valueString 1..1



// -----------------------------------------------------
// Profile: PostEvent (Basic)
// -----------------------------------------------------

Profile: PostEvent
Parent: Basic
Id: post-event
Title: "Post Event"
Description: "Clinical events occurring after transplant, associated with a patient and event type."

// post_event_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Post event ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/post-event-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Post-transplant event record category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/post-event-type-code" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach post-event-specific extensions
* extension contains
    PostEventTypeRef named postEventTypeId 0..1 MS and
    PostEventPatientRef named patientId 0..1 MS and
    PostEventOnsetDate named onsetDate 0..1 and
    PostEventEndDate named endDate 0..1 and
    PostEventDescription named description 0..1

// Short labels
* extension[postEventTypeId] ^short = "Post event type ID relationship"
* extension[patientId] ^short = "Patient ID relationship"
* extension[onsetDate] ^short = "Event onset date"
* extension[endDate] ^short = "Event end date"
* extension[description] ^short = "Description of the post-transplant event"



/* ----------------------------------------------------
   Example instance
   ---------------------------------------------------- */

Instance: PostEventExample1
InstanceOf: PostEvent
Usage: #example
Title: "Example Post-Transplant Event"
Description: "Example of a post-transplant event (e.g., infection episode)."

* id = "post-event-example-1"

// post_event_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/post-event-id"
* identifier.value = "PE0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/post-event-type-code#event "Post-transplant event"

// post_event_type_id (assumes a PostEventTypeExample1 exists)
* extension[postEventTypeId].valueReference = Reference(PostEventTypeExample1)

// patient_id
* extension[patientId].valueReference = Reference(ExamplePatientTransplant1)

// onset_date / end_date
* extension[onsetDate].valueDate = "2024-05-10"
* extension[endDate].valueDate = "2024-05-16"

// description
* extension[description].valueString = "Hospitalization due to bacterial cholangitis treated with IV antibiotics."
