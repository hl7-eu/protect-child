{% include pc-lab-profile.svg %}

# Laboratory — Logical Model → FHIR Map

## Lab Test Catalogue

Profile: [LabTest](StructureDefinition-lab-test.html) (`ObservationDefinition`)

| DM field | Card. | FHIR path |
|---|---|---|
| lab_test_id | M | `ObservationDefinition.identifier.value` |
| name | M | `ObservationDefinition.code` |

---

## Lab Result

Primary profile: [LabResultObservation](StructureDefinition-lab-result-observation.html) (`Observation`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

Each row in the `lab_result` DM table maps to one `Observation` resource. The analyte is identified via `Observation.code` bound to [LabTestNameVS](ValueSet-lab-test-name-vs.html) (LOINC-based catalogue of 50+ analytes).

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| lab_result_id | M | `Observation.identifier.value` | |
| lab_test_id | M | `Observation.code` | [LabTestNameVS](ValueSet-lab-test-name-vs.html). Link to the [LabTest (ObservationDefinition)](StructureDefinition-lab-test.html) is implicit — match on `Observation.code` = `ObservationDefinition.code`. R4 `Observation.basedOn` does not allow `Reference(ObservationDefinition)`; this is supported in R5 via `Observation.instantiates[x]`. |
| visit_id | M | `Observation.encounter` | [Reference(Visit)](StructureDefinition-visit.html) |
| date | M | `Observation.effectiveDateTime` | |
| unit | M | `Observation.valueQuantity.code` | [LabResultUnitVS](ValueSet-lab-result-unit-vs.html); present whenever value is present |
| value | R | `Observation.valueQuantity.value` | Numeric result (0..1). When absent, populate `Observation.dataAbsentReason` instead (invariant `pc-lab-1`) |
| *(missing value)* | — | `Observation.dataAbsentReason` | Required when `value[x]` is absent — use standard codes e.g. `#not-performed`, `#error`, `#below-detection-limit` |
| gfr_formula | R | `Observation.method` | Formula used to calculate GFR (creatinine-based); use `method.text` for free-text name (e.g. CKD-EPI, Schwartz) |
| gfr_cyst_formula | R | `Observation.method` | Formula used to calculate GFR (cystatin C-based); use `method.text` |
