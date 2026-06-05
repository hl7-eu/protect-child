{% include pc-concomitant-medication-profile.svg %}

# Concomitant Medication — Logical Model → FHIR Map

Primary profile: [ConcomitantMedication](StructureDefinition-concomitant-medication.html) (`MedicationStatement`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

Concomitant medications are any non-immunosuppressant drugs the recipient is taking at the time of a given visit.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| concomitant_medication_id | M | `MedicationStatement.identifier.value` | |
| visit_id | M | `MedicationStatement.context` | [Reference(Visit)](StructureDefinition-visit.html) |
| medication_name | R | `MedicationStatement.medicationCodeableConcept.text` | Free text |
| dose | R | `MedicationStatement.dosage.doseAndRate.doseQuantity` | |
| start_date | R | `MedicationStatement.effectivePeriod.start` | |
| status | R | `MedicationStatement.status` | Ongoing → `#active`; Ended → `#completed` |
| end_date | R | `MedicationStatement.effectivePeriod.end` | Only populated when status = `#completed` |
