// visit.fsh

// -----------------------------------------------------
// Visit type terminology (visit_type)
// -----------------------------------------------------

CodeSystem: VisitTypeCS
Id: visit-type-cs
Title: "Visit Type CodeSystem"
Description: "Type of visit in the transplant follow-up schedule."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #pre-transplant    "Pre-transplant visit" "Pre-transplant (baseline) visit."
* #month-1           "1 month visit" "1-month post-transplant follow-up visit."
* #month-3           "3 month visit" "3-month post-transplant follow-up visit."
* #month-6           "6 month visit" "6-month post-transplant follow-up visit."
* #month-12          "12 month visit" "12-month post-transplant follow-up visit."
* #month-24          "24 month visit" "24-month post-transplant follow-up visit."
* #clinical-event    "Clinical Event visit" "Unscheduled visit prompted by a clinical event."
* #termination       "Termination visit" "Study termination / end-of-follow-up visit."

ValueSet: VisitTypeVS
Id: visit-type-vs
Title: "Visit Type ValueSet"
Description: "Allowed types of visits in the transplant follow-up schedule (DMv1.2)."
* ^experimental = true
* VisitTypeCS#pre-transplant
* VisitTypeCS#month-1
* VisitTypeCS#month-3
* VisitTypeCS#month-6
* VisitTypeCS#month-12
* VisitTypeCS#month-24
* VisitTypeCS#clinical-event
* VisitTypeCS#termination


// -----------------------------------------------------
// Reference strategy (no extensions on Visit)
// -----------------------------------------------------
// All clinical resources back-reference the Visit using native FHIR elements:
//
//   Observation.encounter:       ClinicalVariable, VitalSign, ImmunologicalData,
//                                Microbiology, InstrumentalInvestigation, LabResult
//   Condition.encounter:         ClinicalEvent
//   MedicationStatement.context: PreMedication, ImmPat, ConcomitantMedication
//   Specimen extension:          BioSample → extension[visit_id]
//   Transplant (Procedure):      links to Visit via Procedure.encounter (forward reference)


// -----------------------------------------------------
// Visit profile on Encounter
// -----------------------------------------------------

Profile: Visit
Parent: Encounter
Id: visit
Title: "Visit"
Description: "Encounter profile representing a visit in the transplant follow-up schedule. All clinical resources back-reference this Visit via their native encounter/context element or a slim extension on the resource itself. No extensions are needed on Visit."

// visit_id → Encounter.identifier (Mandatory)
* identifier 1..* MS
* identifier ^short = "visit_id – visit identifier"
* identifier.system 1..1 MS
* identifier.value 1..1 MS

// patient_id → Encounter.subject (Mandatory)
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id – transplant recipient for this visit"

// date → Encounter.period.start (Mandatory)
* period 1..1 MS
* period.start 1..1 MS
* period.start ^short = "date — date the visit began"
* period.end 0..1 MS
* period.end ^short = "Visit end date — populate when the visit spans multiple days or a termination date is recorded"

// visit_type → Encounter.type (Mandatory)
* type 1..1 MS
* type from VisitTypeVS (required)
* type ^short = "Type of visit in the transplant follow-up schedule"

* status 1..1 MS
* class 1..1 MS


// -----------------------------------------------------
// Example visit instance
// -----------------------------------------------------

Instance: VisitExample1
InstanceOf: Visit
Usage: #example
Title: "Example visit"
Description: "Example visit. Clinical resources (ClinicalVariable, Microbiology, PreMedication, etc.) carry the back-reference to this Visit via their own .encounter / .context element or extension."

* identifier[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/identifiers/visit"
* identifier[0].value = "V000001"
* subject = Reference(ExamplePatientTransplant1)
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* period.start = "2023-09-15"
* type[0].coding[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/visit-type-cs"
* type[0].coding[0].code = #month-1
* type[0].coding[0].display = "1 month visit"
