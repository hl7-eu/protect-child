{% include pc-instrumental-investigation-profile.svg %}

# Instrumental Investigation — Logical Model → FHIR Map

Primary profile: [PatientInstrumentalInvestigation](StructureDefinition-patient-instrumental-investigation.html) (`Observation`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

Instrumental investigations capture the result (Normal / Abnormal) of imaging, biopsy, and functional studies performed at a visit.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| inst_inv_id | M | `Observation.identifier.value` | |
| visit_id | M | `Observation.encounter` | [Reference(Visit)](StructureDefinition-visit.html) |
| instrumental_investigation | M | `Observation.code` | [InstrumentalInvestigationNameVS](ValueSet-instrumental-investigation-name-vs.html) |
| date | R | `Observation.effectiveDateTime` | |
| result | R | `Observation.valueCodeableConcept` | Normal / Abnormal |
| abnormality | R | `Observation.note[abnormality].text` | `authorString = "abnormality"` |
| other_investigation | R | `Observation.note[other_investigation].text` | `authorString = "other_investigation"` |
