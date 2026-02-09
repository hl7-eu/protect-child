// =====================================================
// Outcome
// =====================================================


// -----------------------------------------------------
// Extensions
// -----------------------------------------------------

// outcome_type_id – ElementReference(OutcomeType)
Extension: OutcomeTypeRef
Id: outcome-type-ref
Title: "Outcome type ID relationship"
Description: "Reference to the type/category of outcome."
* value[x] only Reference(OutcomeType)
* valueReference 1..1

// patient_id – ElementReference(PatientTransplant)
Extension: OutcomePatientRef
Id: outcome-patient-ref
Title: "Patient ID relationship"
Description: "Reference to the patient for whom the outcome is recorded."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// date – Date
Extension: OutcomeDate
Id: outcome-date
Title: "Outcome date"
Description: "Date associated with the outcome (e.g. assessment date)."
* value[x] only date
* valueDate 1..1

// pre_medication – Reference(PreMedication)
Extension: OutcomePreMedicationRef
Id: outcome-pre-medication-ref
Title: "Pre-medication ID relationship"
Description: "Reference to pre-transplant medication information associated with this outcome."
* value[x] only Reference(PreMedication)
* valueReference 1..1

// clinical_variable_id – Reference(ClinicalVariable)
Extension: OutcomeClinicalVariableRef
Id: outcome-clinical-variable-ref
Title: "Clinical variable ID relationship"
Description: "Reference to clinical variable/vital signs information associated with this outcome."
* value[x] only Reference(ClinicalVariable)
* valueReference 1..1

// concomitant_episode_id – Reference(ConcomitantEpisode)
Extension: OutcomeConcomitantEpisodeRef
Id: outcome-concomitant-episode-ref
Title: "Concomitant episode ID relationship"
Description: "Reference to concomitant episode information associated with this outcome."
* value[x] only Reference(ConcomitantEpisode)
* valueReference 1..1

// microbiology_id – Reference(Microbiology)
Extension: OutcomeMicrobiologyRef
Id: outcome-microbiology-ref
Title: "Microbiology ID relationship"
Description: "Reference to microbiology results associated with this outcome."
* value[x] only Reference(Microbiology)
* valueReference 1..1

// pat_inst_inv_id – Reference(PatientInstrumentalInvestigation)
Extension: OutcomePatientInstrumentalInvestigationRef
Id: outcome-patient-instrumental-investigation-ref
Title: "Patient instrumental investigation ID relationship"
Description: "Reference to patient instrumental investigation associated with this outcome."
* value[x] only Reference(PatientInstrumentalInvestigation)
* valueReference 1..1

// lab_test_id – Reference(LabTest)
Extension: OutcomeLabTestRef
Id: outcome-lab-test-ref
Title: "Lab test ID relationship"
Description: "Reference to lab test definition associated with this outcome."
* value[x] only Reference(LabTest)
* valueReference 1..1

// post_event_id – Reference(PostEvent)
Extension: OutcomePostEventRef
Id: outcome-post-event-ref
Title: "Post event ID relationship"
Description: "Reference to post-transplant event associated with this outcome."
* value[x] only Reference(PostEvent)
* valueReference 1..1



// -----------------------------------------------------
// Profile: Outcome (Basic)
// -----------------------------------------------------

Profile: Outcome
Parent: Basic
Id: outcome
Title: "Outcome"
Description: "Outcome information for transplant patients, linked to multiple clinical domains."

// outcome_id → Basic.identifier
* identifier 1..1 MS
* identifier ^short = "Outcome ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/outcome-id" (exactly)
* identifier.value 1..1

// Basic.code is required.
* code 1..1 MS
* code ^short = "Outcome record category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/outcome-type-code" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// Attach outcome-specific extensions
* extension contains
    OutcomeTypeRef named outcomeTypeId 0..1 MS and
    OutcomePatientRef named patientId 0..1 MS and
    OutcomeDate named date 0..1 MS and
    OutcomePreMedicationRef named preMedicationId 0..1 and
    OutcomeClinicalVariableRef named clinicalVariableId 0..1 and
    OutcomeConcomitantEpisodeRef named concomitantEpisodeId 0..1 and
    OutcomeMicrobiologyRef named microbiologyId 0..1 and
    OutcomePatientInstrumentalInvestigationRef named patInstInvId 0..1 and
    OutcomeLabTestRef named labTestId 0..1 and
    OutcomePostEventRef named postEventId 0..1

// Short labels
* extension[outcomeTypeId] ^short = "Outcome type ID relationship"
* extension[patientId] ^short = "Patient ID relationship"
* extension[date] ^short = "Outcome date"
* extension[preMedicationId] ^short = "Pre-medication ID relationship"
* extension[clinicalVariableId] ^short = "Clinical variable ID relationship"
* extension[concomitantEpisodeId] ^short = "Concomitant episode ID relationship"
* extension[microbiologyId] ^short = "Microbiology ID relationship"
* extension[patInstInvId] ^short = "Patient instrumental investigation ID relationship"
* extension[labTestId] ^short = "Lab test ID relationship"
* extension[postEventId] ^short = "Post event ID relationship"



// -----------------------------------------------------
// Example instance
// -----------------------------------------------------

Instance: OutcomeExample1
InstanceOf: Outcome
Usage: #example
Title: "Example Outcome"
Description: "Example outcome record for a transplant patient."

* id = "outcome-example-1"

// outcome_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/outcome-id"
* identifier.value = "OUT0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/outcome-type-code#clinical "Clinical outcome"

// outcome_type_id (assumes an OutcomeTypeExample1 will be defined)
* extension[outcomeTypeId].valueReference = Reference(OutcomeTypeExample1)

// patient_id
* extension[patientId].valueReference = Reference(ExamplePatientTransplant1)

// date
* extension[date].valueDate = "2024-06-01"

// Optional linked domains 
* extension[preMedicationId].valueReference = Reference(PreMedicationExample1)
* extension[clinicalVariableId].valueReference = Reference(ClinicalVariableExample1)
* extension[concomitantEpisodeId].valueReference = Reference(ConcomitantEpisodeExample1)
* extension[microbiologyId].valueReference = Reference(MicrobiologyExample1)
* extension[patInstInvId].valueReference = Reference(PatientInstrumentalInvestigationExample1)
* extension[labTestId].valueReference = Reference(LabTestExample1)
* extension[postEventId].valueReference = Reference(PostEventExample1)
