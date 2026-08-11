# PROTECT-CHILD data model (ERD)

This page shows the Entity–Relationship Diagram (ERD) for the PROTECT-CHILD data model (v1.2), followed by an accessible list of entities and the full relationship table.

<div style="max-width: 100%; overflow-x: auto; border: 1px solid #eee; padding: 0.5rem;">
  <object data="Protect_Child_DM_ERD.svg" type="image/svg+xml"
          style="width: 100%; min-width: 900px; height: 600px; display: block;">
    <img src="Protect_Child_DM_ERD.svg" alt="PROTECT-CHILD data model ERD v1.2" style="width:100%; height:auto;"/>
  </object>
</div>

## Entities

| Entity | FHIR resource | Description |
| --- | --- | --- |
| `patient` | `Patient` | Transplant recipient. |
| `donor` | `Patient` (Donor) | Organ donor (living/deceased). |
| `visit` | `Encounter` | Central hub — every clinical record links to a visit. |
| `transplant` | `Procedure` + TransplantDetails | The transplant event and intraoperative details. |
| `immunological_data` | `Observation` panel | ABO/Rh, HLA, DSA, Banff, C4d, ANCA. |
| `bio_sample` | `Specimen` | Biospecimen collection (→ genomic/epigenomic analysis). |
| `pre_medication` | `MedicationStatement` | Pre-transplant medication incl. desensitisation. |
| `clinical_variable` | `Observation` | Symptoms, comorbidities, organ dysfunction. |
| `vital_sign` | `Observation` panel | Vitals incl. 24-h ABPM. |
| `concomitant_medication` | `MedicationStatement` | Concomitant medications. |
| `microbiology` | `Observation` panel | EBV, CMV, BKV, and other virology + cultures. |
| `instrumental_investigation` | `Observation` | Imaging and functional studies. |
| `immunosuppressant` | `Medication` | Immunosuppressant drug catalogue. |
| `imm_pat` | `MedicationStatement` + ImmPatPKObservation | Immunosuppression to patient (induction/maintenance) + PK. |
| `lab_test` | `ObservationDefinition` | Laboratory test catalogue. |
| `lab_result` | `Observation` | Laboratory results. |
| `clinical_event_type` | `CodeSystem` / `ValueSet` | Controlled vocabulary of clinical event types. |
| `clinical_event` | `Condition` | Post-transplant complications and outcomes. |

## Relationships

The 19 relationships below are taken from the data model's `RELATIONSHIPS` definition. **Visit** is the hub: almost every per-visit record carries a `visit_id` foreign key.

| Parent | | Child | Key | Cardinality | Notes |
| --- | :-: | --- | --- | --- | --- |
| `patient` | → | `visit` | `patient_id` | One-to-Many |  |
| `visit` | → | `transplant` | `visit_id` | One-to-Many |  |
| `donor` | → | `transplant` | `donor_id` | One-to-Many |  |
| `visit` | → | `immunological_data` | `visit_id` | One-to-Many |  |
| `donor` | → | `immunological_data` | `donor_id` | One-to-Many | This can be 0-to-N |
| `visit` | → | `pre_medication` | `visit_id` | One-to-Many |  |
| `visit` | → | `clinical_variable` | `visit_id` | One-to-Many |  |
| `visit` | → | `vital_sign` | `visit_id` | One-to-Many |  |
| `visit` | → | `concomitant_medication` | `visit_id` | One-to-Many |  |
| `visit` | → | `microbiology` | `visit_id` | One-to-Many |  |
| `donor` | → | `microbiology` | `donor_id` | One-to-Many | This can be 0-to-N |
| `visit` | → | `instrumental_investigation` | `visit_id` | One-to-Many |  |
| `immunosuppressant` | → | `imm_ind_pat` | `imm_id` | One-to-Many |  |
| `visit` | → | `imm_ind_pat` | `visit_id` | One-to-Many |  |
| `lab_test` | → | `lab_result` | `lab_test_id` | One-to-Many |  |
| `visit` | → | `lab_result` | `visit_id` | One-to-Many |  |
| `clinical_event_type` | → | `clinical_event` | `clinical_event_type_id` | One-to-Many |  |
| `visit` | → | `clinical_event` | `visit_id` | One-to-One |  |
| `visit` | → | `bio_sample` | `visit_id` | One-to-Many |  |

> Note: the data model table `imm_ind_pat` is realised in this IG as the **ImmPat** profile (`imm_pat`). The `visit → clinical_event` relationship is one-to-one in the data model.