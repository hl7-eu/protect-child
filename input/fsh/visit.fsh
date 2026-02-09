// visit.fsh

// -----------------------------------------------------
// Visit type terminology (visit_type)
// -----------------------------------------------------

CodeSystem: VisitTypeCS
Id: visit-type-cs
Title: "Visit Type CodeSystem"
Description: "Type of visit in the transplant follow-up schedule."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/visit-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #pre-transplant "Pre-transplant visit"
* #month-1       "1 month visit"
* #month-3       "3 month visit"
* #month-5       "5 month visit"
* #outcome       "Outcome visit"

ValueSet: VisitTypeVS
Id: visit-type-vs
Title: "Visit Type ValueSet"
Description: "Allowed types of visits in the transplant follow-up schedule."
* VisitTypeCS#pre-transplant
* VisitTypeCS#month-1
* VisitTypeCS#month-3
* VisitTypeCS#month-5
* VisitTypeCS#outcome

// -----------------------------------------------------
// Extensions for relationships (ElementReferences)
// -----------------------------------------------------

// transplant_id – Reference(Transplant)
Extension: VisitTransplantRef
Id: visit-transplant-ref
Title: "Transplant ID relationship"
Description: "Reference to the transplant associated with this visit (transplant_id)."
* value[x] only Reference(Transplant)

// bio_sample_id – Reference(BioSample)
Extension: VisitBioSampleRef
Id: visit-bio-sample-ref
Title: "BioSample ID relationship"
Description: "Reference to the primary biosample collected at this visit (bio_sample_id)."
* value[x] only Reference(BioSample)

// pre_medication_id – Reference(PreMedication)
Extension: VisitPreMedicationRef
Id: visit-pre-medication-ref
Title: "Pre-medication ID relationship"
Description: "Reference to pre-medication information associated with this visit (pre_medication_id)."
* value[x] only Reference(PreMedication)

// clinical_variable_id – Reference(ClinicalVariable)
Extension: VisitClinicalVariableRef
Id: visit-clinical-variable-ref
Title: "Clinical variable ID relationship"
Description: "Reference to clinical variables recorded at this visit (clinical_variable_id)."
* value[x] only Reference(ClinicalVariable)

// concomitant_episode_id – Reference(ConcomitantEpisode)
Extension: VisitConcomitantEpisodeRef
Id: visit-concomitant-episode-ref
Title: "Concomitant episode ID relationship"
Description: "Reference to a concomitant episode associated with this visit (concomitant_episode_id)."
* value[x] only Reference(ConcomitantEpisode)

// microbiology_id – Reference(Microbiology)
Extension: VisitMicrobiologyRef
Id: visit-microbiology-ref
Title: "Microbiology ID relationship"
Description: "Reference to microbiology results associated with this visit (microbiology_id)."
* value[x] only Reference(Microbiology)

// pat_inst_inv_id – Reference(PatientInstrumentalInvestigation)
Extension: VisitPatientInstrumentalInvestigationRef
Id: visit-patient-instrumental-investigation-ref
Title: "Patient instrumental investigation ID relationship"
Description: "Reference to a patient instrumental investigation associated with this visit (pat_inst_inv_id)."
* value[x] only Reference(PatientInstrumentalInvestigation)

// imm_ind_pat_id – Reference(ImmunosuppressiveInductionPatient)
Extension: VisitImmunosuppressiveInductionRef
Id: visit-immunosuppressive-induction-ref
Title: "Immunosuppressive induction ID relationship"
Description: "Reference to immunosuppressive induction treatment associated with this visit (imm_ind_pat_id)."
* value[x] only Reference(ImmunosuppressiveInductionPatient)

// imm_main_pat_id – Reference(ImmunosuppressiveMaintenancePatient)
Extension: VisitImmunosuppressiveMaintenanceRef
Id: visit-immunosuppressive-maintenance-ref
Title: "Immunosuppressive maintenance ID relationship"
Description: "Reference to immunosuppressive maintenance treatment associated with this visit (imm_main_pat_id)."
* value[x] only Reference(ImmunosuppressiveMaintenancePatient)

// lab_result_id – Reference(LabResultObservation)
Extension: VisitLabResultRef
Id: visit-lab-result-ref
Title: "Lab result ID relationship"
Description: "Reference to laboratory results associated with this visit (lab_result_id)."
* value[x] only Reference(LabResultObservation)

// post_event_id – Reference(PostEvent)
Extension: VisitPostEventRef
Id: visit-post-event-ref
Title: "Post-event ID relationship"
Description: "Reference to a post-transplant event (e.g. rejection episode) occurring at this visit (post_event_id)."
* value[x] only Reference(PostEvent)

// outcome_id – Reference(Outcome)
Extension: VisitOutcomeRef
Id: visit-outcome-ref
Title: "Outcome ID relationship"
Description: "Reference to the outcome record associated with this visit (outcome_id)."
* value[x] only Reference(Outcome)

// -----------------------------------------------------
// Visit profile on Encounter
// -----------------------------------------------------

Profile: Visit
Parent: Encounter
Id: visit
Title: "Visit"
Description: "Encounter profile representing a visit in the transplant follow-up schedule, aligned with the visit table."

// visit_id (DM) → Encounter.identifier (Mandatory)
* identifier 1..* MS
* identifier ^short = "Visit identifiers (visit_id from the data model)"
* identifier.system 1..1 MS
* identifier.system ^short = "Namespace for the visit identifier"
* identifier.value 1..1 MS
* identifier.value ^short = "Visit ID (visit_id from the data model)"

// patient_id → Encounter.subject (Mandatory)
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id – transplant recipient for this visit"

// date (DM) → Encounter.period.start (Mandatory)
* period 1..1 MS
* period.start 1..1 MS
* period.start ^short = "Date of the visit"

// visit_type (DM) → Encounter.type (Mandatory)
* type 1..1 MS
* type ^short = "Type of visit in the transplant follow-up schedule"
* type ^binding.strength = #required
* type ^binding.valueSet = Canonical(VisitTypeVS)

// Basic FHIR-required elements
* status 1..1 MS
* status ^short = "Encounter status"
* class 1..1 MS
* class ^short = "Classification of visit setting (inpatient, outpatient, etc.)"

// Optional relationships from the visit table (all O in DM)
// Slice names match DM column names exactly
* extension contains VisitTransplantRef named transplant_id 0..1
* extension contains VisitBioSampleRef named bio_sample_id 0..1
* extension contains VisitPreMedicationRef named pre_medication_id 0..1
* extension contains VisitClinicalVariableRef named clinical_variable_id 0..1
* extension contains VisitConcomitantEpisodeRef named concomitant_episode_id 0..1
* extension contains VisitMicrobiologyRef named microbiology_id 0..1
* extension contains VisitPatientInstrumentalInvestigationRef named pat_inst_inv_id 0..1
* extension contains VisitImmunosuppressiveInductionRef named imm_ind_pat_id 0..1
* extension contains VisitImmunosuppressiveMaintenanceRef named imm_main_pat_id 0..1
* extension contains VisitLabResultRef named lab_result_id 0..1
* extension contains VisitPostEventRef named post_event_id 0..1
* extension contains VisitOutcomeRef named outcome_id 0..1

* extension[transplant_id] ^short = "transplant_id – reference to associated Transplant"
* extension[bio_sample_id] ^short = "bio_sample_id – reference to BioSample"
* extension[pre_medication_id] ^short = "pre_medication_id – reference to PreMedication"
* extension[clinical_variable_id] ^short = "clinical_variable_id – reference to ClinicalVariable"
* extension[concomitant_episode_id] ^short = "concomitant_episode_id – reference to ConcomitantEpisode"
* extension[microbiology_id] ^short = "microbiology_id – reference to Microbiology"
* extension[pat_inst_inv_id] ^short = "pat_inst_inv_id – reference to PatientInstrumentalInvestigation"
* extension[imm_ind_pat_id] ^short = "imm_ind_pat_id – reference to ImmunosuppressiveInductionPatient"
* extension[imm_main_pat_id] ^short = "imm_main_pat_id – reference to ImmunosuppressiveMaintenancePatient"
* extension[lab_result_id] ^short = "lab_result_id – reference to LabResultObservation"
* extension[post_event_id] ^short = "post_event_id – reference to PostEvent"
* extension[outcome_id] ^short = "outcome_id – reference to Outcome"

// -----------------------------------------------------
// Example visit instance
// -----------------------------------------------------

Instance: VisitExample1
InstanceOf: Visit
Usage: #example
Title: "Example visit"
Description: "Example visit instance mapped from the visit table."

// visit_id
* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/identifiers/visit"
* identifier[0].value = "V000001"

// patient_id
* subject = Reference(ExamplePatientTransplant1)

// status & class
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"

// date
* period.start = "2023-09-15"

// visit_type
* type[0].coding[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/visit-type"
* type[0].coding[0].code = #month-1
* type[0].coding[0].display = "1 month visit"

// Example of linking to transplant and outcome via DM variable names
* extension[transplant_id].valueReference = Reference(TransplantExample1)
* extension[outcome_id].valueReference = Reference(OutcomeExample1)
