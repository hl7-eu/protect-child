{% include pc-clinical-variable-profile.svg %}

# Clinical Variable — Logical Model → FHIR Map

Primary profile: [ClinicalVariable](StructureDefinition-clinical-variable.html) (`Observation`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

The ClinicalVariable entity consolidates per-visit anthropometrics and symptom notes. Concomitant diseases are represented separately as [ConcomitantDisease](StructureDefinition-concomitant-disease.html) (`Condition`) resources — one per disease.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| clinical_variable_id | M | `Observation.identifier.value` | |
| visit_id | M | `Observation.encounter` | [Reference(Visit)](StructureDefinition-visit.html) |
| weight | R | `Observation.component[weight].valueQuantity` | LOINC 29463-7; kg |
| height | R | `Observation.component[height].valueQuantity` | LOINC 8302-2; cm |
| concomitant_disease | M | `Condition.code` | Each disease is a [ConcomitantDisease](StructureDefinition-concomitant-disease.html) (`Condition`, problem-list-item); [ConcomitantDiseaseCategoryVS](ValueSet-concomitant-disease-category-vs.html); one Condition per disease |
| description | R | `Observation.note` | Free text |
| diuresis_value | R | `Observation.component[diuresis_value].valueQuantity` | LOINC 9192-6; mL/d |
| other_symptoms | R | `Observation.note` | Free text |
| other_concomitant | R | `Observation.note` | Free text |
| organ_dysfunction | R | `Observation.note` | Free text |
