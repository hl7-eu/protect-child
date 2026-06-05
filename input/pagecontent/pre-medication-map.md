{% include pc-pre-medication-profile.svg %}

# Pre-Medication — Logical Model → FHIR Map

Primary profile: [PreMedication](StructureDefinition-pre-medication.html) (`MedicationStatement`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

Pre-medication records capture antihypertensive treatment, rituximab desensitisation, antiviral prophylaxis, and other medications given to the recipient **before** transplant surgery.

## Antihypertensive Treatment (`PreMedication`)

Primary record: one [PreMedication](StructureDefinition-pre-medication.html) (`MedicationStatement`) per visit.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| pre_medication_id | M | `MedicationStatement.identifier.value` | |
| visit_id | M | `MedicationStatement.context` | [Reference(Visit)](StructureDefinition-visit.html) |
| antihypertensive_treatment | R | `MedicationStatement.medicationCodeableConcept` | [PreMedicationAntihypertensiveDrugVS](ValueSet-pre-medication-antihypertensive-drug-vs.html) |
| other_medications | R | `MedicationStatement.note.text` | Free text |

## Rituximab and Antiviral Prophylaxis

These are recorded as **separate `MedicationStatement` resources**. Each carries `partOf = Reference(PreMedication)` to explicitly group them under the parent antihypertensive record. `MedicationStatement.status = #not-taken` (native R4) captures the "not given" case without a custom extension.

Navigation:
- From child → parent: `MedicationStatement.partOf`
- From parent → children: search `MedicationStatement?part-of={pre-medication-id}`

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| rituximab | R | `MedicationStatement.status` | `#completed` = given; `#not-taken` = not given. `medication` = Rituximab (RxNorm [121191](https://mor.nlm.nih.gov/RxNav/search?searchBy=RXCUI&searchTerm=121191)) |
| date_last_rituximab | R | `MedicationStatement.effectiveDateTime` | Date of last Rituximab infusion — on the Rituximab `MedicationStatement` |
| antiviral_prophylaxis | R | `MedicationStatement.status` | `#completed` = given; `#not-taken` = not given. `medication` = antiviral drug code |
| *(all above)* | R | `MedicationStatement.partOf` | [Reference(PreMedication)](StructureDefinition-pre-medication.html) — links child records to the parent antihypertensive record |
