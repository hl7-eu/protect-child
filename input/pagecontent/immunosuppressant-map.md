{% include pc-immunosuppressant-profile.svg %}

# Immunosuppressant — Logical Model → FHIR Map

## Immunosuppressant Catalogue

Profile: [Immunosuppressant](StructureDefinition-immunosuppressant.html) (`Medication`)

| DM field | Card. | FHIR path |
|---|---|---|
| imm_id | M | `Medication.identifier.value` |
| name | M | `Medication.code` |

---

## Immunosuppressant to Patient

Primary profile: [ImmPat](StructureDefinition-imm-pat.html) (`MedicationStatement`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

This entity links a specific immunosuppressant drug to a recipient at a given visit, capturing dosing, drug levels, and phase (Induction or Maintenance). The `induction` and `maintenance` DM tables are unified here via the `phase` field.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| imm_pat_id | M | `MedicationStatement.identifier.value` | |
| imm_id | M | `MedicationStatement.medicationReference` | [Reference(Immunosuppressant)](StructureDefinition-immunosuppressant.html) |
| visit_id | M | `MedicationStatement.context` | [Reference(Visit)](StructureDefinition-visit.html) |
| phase | M | `MedicationStatement.category` | [ImmPatPhaseVS](ValueSet-imm-pat-phase-vs.html) (`#induction` / `#maintenance`) |
| dose | R | `MedicationStatement.dosage.doseAndRate.doseQuantity.value` | Numeric dose value |
| unit | R | `MedicationStatement.dosage.doseAndRate.doseQuantity.code` | UCUM unit code (e.g. `mg.kg-1`) |
| start_date | R | `MedicationStatement.effectivePeriod.start` | |
| end_date | R | `MedicationStatement.effectivePeriod.end` | |

### Pharmacokinetic Monitoring

PK monitoring values are represented as [ImmPatPKObservation](StructureDefinition-imm-pat-pk-observation.html) (`Observation`) resources linked to the parent `ImmPat` via `Observation.partOf`. Query pattern: `Observation?part-of={imm-pat-id}`.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| pre_dose_level | R | `Observation.valueQuantity` | `Observation.code` = `ImmPatPKTypeCS#pre-dose-level` |
| csa_2h_post_dose_level | R | `Observation.valueQuantity` | `Observation.code` = `ImmPatPKTypeCS#post-dose-2h-level` |
| auc | R | `Observation.valueQuantity` | `Observation.code` = `ImmPatPKTypeCS#auc` |
