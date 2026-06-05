{% include pc-visit-profile.svg %}

# Visit — Logical Model → FHIR Map

Primary profile: [Visit](StructureDefinition-visit.html) (`Encounter`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| visit_id | M | `Encounter.identifier.value` | |
| patient_id | M | `Encounter.subject` | [Reference(PatientTransplant)](StructureDefinition-patient-transplant.html) |
| date | M | `Encounter.period.start` | |
| visit_type | M | `Encounter.type` | [VisitTypeVS](ValueSet-visit-type-vs.html) |
