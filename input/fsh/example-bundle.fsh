// Liver worked example — REC-1-0001 at centre 1 (La Paz).
// Collection Bundle inlining instances defined across the IG; every internal
// reference resolves. entry.fullUrl is {canonical}/{ResourceType}/{id}.

Instance: ProtectChildRecipientJourneyExample
InstanceOf: Bundle
Usage: #example
Title: "Worked Example — recipient REC-1-0001 full transplant journey"
Description: "A single paediatric liver transplant recipient (REC-1-0001, La Paz) from enrolment through donor, transplant, intra-operative findings, follow-up visit, labs, biospecimen, immunosuppression, microbiology and post-transplant clinical events — assembled as one collection Bundle in which every internal reference resolves."

* type = #collection
* timestamp = "2024-09-01T10:00:00+02:00"

// ---- Study centre and patients ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Organization/PCCenter1LaPaz"
* entry[=].resource = PCCenter1LaPaz
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Patient/ExamplePatientTransplant1"
* entry[=].resource = ExamplePatientTransplant1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Patient/ExampleDonor1"
* entry[=].resource = ExampleDonor1

// ---- Catalogue entries (study-wide, no date of their own) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Medication/ImmunosuppressantExample1"
* entry[=].resource = ImmunosuppressantExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Medication/ImmunosuppressantTacrolimus1"
* entry[=].resource = ImmunosuppressantTacrolimus1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ObservationDefinition/LabTestExample1"
* entry[=].resource = LabTestExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ObservationDefinition/InstrumentalInvestigationExample1"
* entry[=].resource = InstrumentalInvestigationExample1

// ---- Recipient history — primary disease ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/ExamplePatientLiverDiagnosis1"
* entry[=].resource = ExamplePatientLiverDiagnosis1

// ---- Pre-transplant episode and transplant admission (2023-07-25 .. 2023-08-28) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/VisitPreTxExample1"
* entry[=].resource = VisitPreTxExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/PreMedicationExample1"
* entry[=].resource = PreMedicationExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/PreMedicationChildExample1"
* entry[=].resource = PreMedicationChildExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ExamplePatientImmunologyObservation1"
* entry[=].resource = ExamplePatientImmunologyObservation1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ImmunologicalDataExample1"
* entry[=].resource = ImmunologicalDataExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ExampleDonorAgeObservation1"
* entry[=].resource = ExampleDonorAgeObservation1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ExampleDonorLiverType1"
* entry[=].resource = ExampleDonorLiverType1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ExamplePatientAgeObservation1"
* entry[=].resource = ExamplePatientAgeObservation1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Procedure/TransplantExample1"
* entry[=].resource = TransplantExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Procedure/TransplantAnastomosisExample1"
* entry[=].resource = TransplantAnastomosisExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/IntraoperativeComplicationExample1"
* entry[=].resource = IntraoperativeComplicationExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/TransplantDetailsExample1"
* entry[=].resource = TransplantDetailsExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/ImmPatInductionExample1"
* entry[=].resource = ImmPatInductionExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/ClinicalEventAkiExample1"
* entry[=].resource = ClinicalEventAkiExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Procedure/ClinicalEventDialysisProcedureExample1"
* entry[=].resource = ClinicalEventDialysisProcedureExample1

// ---- 1-month follow-up visit (2023-09-15) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/VisitExample1"
* entry[=].resource = VisitExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/VitalSignExample1"
* entry[=].resource = VitalSignExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-observation-example-1"
* entry[=].resource = LabResultObservationExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-albumin-month-1"
* entry[=].resource = LabResultAlbuminMonth1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-alt-month-1"
* entry[=].resource = LabResultAltMonth1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Specimen/biosample-example-1"
* entry[=].resource = BioSampleExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/ServiceRequest/BioSampleGenomicRequest1"
* entry[=].resource = BioSampleGenomicRequest1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ClinicalVariableExample1"
* entry[=].resource = ClinicalVariableExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/ConcomitantDiseaseExample1"
* entry[=].resource = ConcomitantDiseaseExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/microbiology-example-1"
* entry[=].resource = MicrobiologyExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/MicrobiologyDiagnosisExample1"
* entry[=].resource = MicrobiologyDiagnosisExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/ImmPatMaintenanceExample1"
* entry[=].resource = ImmPatMaintenanceExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ImmPatPKObservationExample1"
* entry[=].resource = ImmPatPKObservationExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/ImmPatEbvReducedExample1"
* entry[=].resource = ImmPatEbvReducedExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/LiverHistologyEbvExample1"
* entry[=].resource = LiverHistologyEbvExample1

// ---- Clinical-event visit — acute rejection episode (2023-11-15) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/VisitClinicalEventExample1"
* entry[=].resource = VisitClinicalEventExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/ClinicalEventExample1"
* entry[=].resource = ClinicalEventExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ImmunologicalDataExample2"
* entry[=].resource = ImmunologicalDataExample2
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/ClinicalEventFlagObservationExample1"
* entry[=].resource = ClinicalEventFlagObservationExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-alt-rejection-1"
* entry[=].resource = LabResultAltRejection1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-bilirubin-rejection-1"
* entry[=].resource = LabResultBilirubinRejection1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-ggt-rejection-1"
* entry[=].resource = LabResultGgtRejection1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/ImmPatRejectionTreatmentExample1"
* entry[=].resource = ImmPatRejectionTreatmentExample1

// ---- 6-month follow-up visit (2024-02-15) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/VisitMonth6Example1"
* entry[=].resource = VisitMonth6Example1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/ConcomitantMedicationExample1"
* entry[=].resource = ConcomitantMedicationExample1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/PatientInstrumentalInvestigationExample1"
* entry[=].resource = PatientInstrumentalInvestigationExample1

// ---- 12-month follow-up visit (2024-08-15) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/VisitMonth12Example1"
* entry[=].resource = VisitMonth12Example1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/VitalSignExample2"
* entry[=].resource = VitalSignExample2
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-observation-example-2"
* entry[=].resource = LabResultObservationExample2
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-albumin-month-12"
* entry[=].resource = LabResultAlbuminMonth12
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/lab-result-alt-month-12"
* entry[=].resource = LabResultAltMonth12
