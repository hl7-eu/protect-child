{% include pc-clinical-variable-profile.svg %}

# Clinical Variable — Logical Model → FHIR Map

Primary profile: [ClinicalVariable](StructureDefinition-clinical-variable.html) (`Observation`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

The ClinicalVariable entity consolidates per-visit anthropometrics, concomitant disease flags, and symptom notes. Multiple `component` slices are used — one per concomitant disease where applicable.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| clinical_variable_id | M | `Observation.identifier.value` | |
| visit_id | M | `Observation.encounter` | [Reference(Visit)](StructureDefinition-visit.html) |
| weight | R | `Observation.component[weight].valueQuantity` | LOINC 29463-7; kg |
| height | R | `Observation.component[height].valueQuantity` | LOINC 8302-2; cm |
| concomitant_disease | M | `Observation.component[concomitant_disease].valueCodeableConcept` | [ConcomitantDiseaseCategoryVS](ValueSet-concomitant-disease-category-vs.html); repeat slice per disease |
| description | R | `Observation.note` | Free text |
| diuresis_value | R | `Observation.component[diuresis_value].valueQuantity` | LOINC 9192-6; mL/d |
| other_symptoms | R | `Observation.note` | Free text |
| other_concomitant | R | `Observation.note` | Free text |
| organ_dysfunction | R | `Observation.note` | Free text |
