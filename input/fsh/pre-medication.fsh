// ================================================
// Pre-medication — pre_medication table
// MedicationStatement
// ================================================

// ------------------------------------------------
// Terminology — antihypertensive drugs
// ------------------------------------------------

CodeSystem: PreMedicationAntihypertensiveDrugCS
Id: pre-medication-antihypertensive-drug-cs
Title: "Pre-medication Antihypertensive Drug CodeSystem"
Description: "Antihypertensive drugs used as pre-transplant medication."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #1332418 "Amlodipine"
* #1318853 "Nifedipine"
* #1340128 "Captopril"
* #1314002 "Atenolol"
* #1346823 "Carvedilol"
* #1353766 "Propranolol"
* #1309068 "Minoxidil"
* #1398937 "Clonidine"
* #1363053 "Doxazosin"

ValueSet: PreMedicationAntihypertensiveDrugVS
Id: pre-medication-antihypertensive-drug-vs
Title: "Pre-medication Antihypertensive Drug ValueSet"
Description: "Allowed antihypertensive drugs for antihypertensive_treatment."
* ^experimental = true
* PreMedicationAntihypertensiveDrugCS#1332418
* PreMedicationAntihypertensiveDrugCS#1318853
* PreMedicationAntihypertensiveDrugCS#1340128
* PreMedicationAntihypertensiveDrugCS#1314002
* PreMedicationAntihypertensiveDrugCS#1346823
* PreMedicationAntihypertensiveDrugCS#1353766
* PreMedicationAntihypertensiveDrugCS#1309068
* PreMedicationAntihypertensiveDrugCS#1398937
* PreMedicationAntihypertensiveDrugCS#1363053


// rituximab, date_last_rituximab, antiviral_prophylaxis are carried as separate
// MedicationStatement resources that reference the parent PreMedication via partOf:
//
//   rituximab given     → MedicationStatement { medication = Rituximab,
//                           status = #completed, effectiveDateTime = date_last_rituximab,
//                           partOf = Reference(PreMedication) }
//   rituximab not given → MedicationStatement { medication = Rituximab,
//                           status = #not-taken,
//                           partOf = Reference(PreMedication) }
//
//   antiviral given     → MedicationStatement { medication = AntiviralProphylaxis,
//                           status = #completed,
//                           partOf = Reference(PreMedication) }
//   antiviral not given → MedicationStatement { medication = AntiviralProphylaxis,
//                           status = #not-taken,
//                           partOf = Reference(PreMedication) }
//
// partOf explicitly groups child records under the parent PreMedication.
// Reverse lookup: MedicationStatement?part-of={pre-medication-id}
// MedicationStatement.status #not-taken is the native R4 way to record "explicitly not given".
//
// other_medications is carried via MedicationStatement.note (native Annotation field).


// ================================================
// PreMedication profile — MedicationStatement
// ================================================

Profile: PreMedication
Parent: MedicationStatement
Id: pre-medication
Title: "Pre-transplant Medication"
Description: "Pre-transplant medication record aligned with the pre_medication table."

// pre_medication_id → MedicationStatement.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/pre-medication-id" (exactly)
* identifier.value 1..1

// patient_id → MedicationStatement.subject
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id — transplant recipient"

// antihypertensive_treatment → MedicationStatement.medication[x]
* medication[x] only CodeableConcept
* medicationCodeableConcept 1..1 MS
* medicationCodeableConcept from PreMedicationAntihypertensiveDrugVS (required)
* medicationCodeableConcept ^short = "antihypertensive_treatment — coded antihypertensive drug"

* status 1..1 MS
* status ^short = "Use #completed for pre-transplant medications"

// visit_id → MedicationStatement.context
* context 1..1 MS
* context only Reference(Visit)
* context ^short = "visit_id — Visit at which pre-transplant medications were recorded"

// other_medications → MedicationStatement.note (native Annotation field)
* note 0..* MS
* note ^short = "other_medications — other relevant pre-transplant medications (free text)"


// ================================================
// PreMedicationChild profile — MedicationStatement
// Covers rituximab desensitisation and antiviral prophylaxis.
// Each child links back to its parent PreMedication via partOf.
// status #completed = given; #not-taken = not given (native R4 pattern).
// ================================================

Profile: PreMedicationChild
Parent: MedicationStatement
Id: pre-medication-child
Title: "Pre-transplant Medication — Child Record"
Description: "A subsidiary pre-transplant medication record (rituximab desensitisation or antiviral prophylaxis) linked to its parent PreMedication via MedicationStatement.partOf. status #completed = given; status #not-taken = explicitly not given."

// Link to parent PreMedication (M)
* partOf 1..1 MS
* partOf only Reference(PreMedication)
* partOf ^short = "Reference to the parent PreMedication record"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

* status 1..1 MS
* status ^short = "#completed = given; #not-taken = not given"

// visit_id — navigable via partOf → PreMedication.context
* context 0..1 MS
* context only Reference(Visit)
* context ^short = "visit_id — inherited from parent PreMedication; populate for direct searchability"

// medication — coded (RxNorm or NationalMedicationCode preferred)
* medication[x] 1..1 MS
* medication[x] only CodeableConcept
* medicationCodeableConcept ^short = "Drug code — use RxNorm (e.g. 121191 for rituximab) or local code"

// date of last dose
* effective[x] 0..1 MS
* effective[x] only dateTime
* effectiveDateTime ^short = "date_last_rituximab — date of last dose (populate on rituximab record)"


// ================================================
// Example
// ================================================

Instance: PreMedicationExample1
InstanceOf: PreMedication
Usage: #example
Title: "Example Pre-medication"
Description: "Example record of pre-transplant medications for a liver transplant recipient."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/pre-medication-id"
* identifier.value = "PM0001"
* status = #completed
* subject = Reference(ExamplePatientTransplant1)
* context = Reference(VisitExample1)
* medicationCodeableConcept = PreMedicationAntihypertensiveDrugCS#1332418 "Amlodipine"
* note[0].text = "Low-dose aspirin"
// rituximab and antiviral prophylaxis are separate MedicationStatement resources
// with status = #completed or #not-taken, linked via context = Reference(VisitExample1)
