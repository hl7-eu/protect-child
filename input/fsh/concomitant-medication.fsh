// ================================================
// Concomitant Medication — concomitant_medication table
// MedicationStatement
// ================================================

// ================================================
// ConcomitantMedication profile — MedicationStatement
// ================================================

Profile: ConcomitantMedication
Parent: MedicationStatement
Id: concomitant-medication
Title: "Concomitant Medication"
Description: "Concomitant medication record for a transplant patient at a visit, aligned with the DMv1.2 concomitant_medication table."

// concomitant_medication_id → MedicationStatement.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-medication-id" (exactly)
* identifier.value 1..1
* identifier ^short = "concomitant_medication_id"

// medication_name → MedicationStatement.medicationCodeableConcept
* medication[x] only CodeableConcept
* medicationCodeableConcept 1..1 MS
* medicationCodeableConcept.text 1..1
* medicationCodeableConcept ^short = "medication_name — medication name (free text in DMv1.2)"

// status (End / Ongoing) → MedicationStatement.status (native FHIR)
//   DM status = Ongoing → #active
//   DM status = End     → #completed  (or #stopped if discontinued early)
* status 1..1 MS
* status ^short = "status — Ongoing → #active; End → #completed"

// visit_id → MedicationStatement.context
* context 1..1 MS
* context only Reference(Visit)
* context ^short = "visit_id — Visit at which this medication was recorded"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// start_date / end_date → MedicationStatement.effectivePeriod
* effective[x] 0..1 MS
* effectivePeriod MS
* effectivePeriod.start 0..1
* effectivePeriod.start ^short = "start_date — date medication started"
* effectivePeriod.end 0..1
* effectivePeriod.end ^short = "end_date — date medication ended"

// dose → MedicationStatement.dosage.doseAndRate.doseQuantity
* dosage 0..1 MS
* dosage.doseAndRate 0..1 MS
* dosage.doseAndRate.doseQuantity 0..1 MS
* dosage.doseAndRate.doseQuantity ^short = "dose — medication dose"


// ================================================
// Example
// ================================================

Instance: ConcomitantMedicationExample1
InstanceOf: ConcomitantMedication
Usage: #example
Title: "Example Concomitant Medication"
Description: "Example ongoing concomitant antihypertensive medication (DMv1.2)."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-medication-id"
* identifier.value = "CM0001"
* status = #active
* subject = Reference(ExamplePatientTransplant1)
* context = Reference(VisitExample1)
* medicationCodeableConcept.text = "Amlodipine"
* effectivePeriod.start = "2024-01-10"
* dosage.doseAndRate.doseQuantity.value = 5.0
* dosage.doseAndRate.doseQuantity.system = "http://unitsofmeasure.org"
* dosage.doseAndRate.doseQuantity.code = #mg
* dosage.doseAndRate.doseQuantity.unit = "mg"
