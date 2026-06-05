{% include pc-patient-profile.svg %}

# Patient — Logical Model → FHIR Map

Primary profile: [PatientTransplant](StructureDefinition-patient-transplant.html) (`Patient`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

Demographics panel: [PatientDemographicsObservation](StructureDefinition-patient-demographics-observation.html) (`Observation`, category `survey`) — age at transplant  
Immunology panel: [PatientImmunologyObservation](StructureDefinition-patient-immunology-observation.html) (`Observation`, category `laboratory`) — PRA and histological date  
Diagnoses: [PatientLiverDiseaseDiagnosis](StructureDefinition-patient-liver-disease-diagnosis.html) · [PatientRenalDiseaseDiagnosis](StructureDefinition-patient-renal-disease-diagnosis.html) (`Condition`)

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| patient_id | M | `Patient.identifier.value` | |
| gender | M | `Patient.gender` | |
| age_years | R | `Observation.component[age_years].valueQuantity` | UCUM `a`; in [PatientDemographicsObservation](StructureDefinition-patient-demographics-observation.html) |
| age_months | R | `Observation.component[age_months].valueQuantity` | UCUM `mo`; in [PatientDemographicsObservation](StructureDefinition-patient-demographics-observation.html) |
| max_pra | R | `Observation.component[max_pra].valueInteger` | `PatientPRATypeCS#max`; in [PatientImmunologyObservation](StructureDefinition-patient-immunology-observation.html) |
| last_pra | R | `Observation.component[last_pra].valueInteger` | `PatientPRATypeCS#last`; in [PatientImmunologyObservation](StructureDefinition-patient-immunology-observation.html) |
| date_histological_diag | M | `Observation.component[date_histological_diag].valueDateTime` | LOINC 77975-1; in [PatientImmunologyObservation](StructureDefinition-patient-immunology-observation.html) |
| diag_primary_disease | M | `Condition.code` | Shared across both Condition profiles below; the free-text diagnosis name |
| date_diag_primary_disease | M | `Condition.onsetDateTime` | Shared across both Condition profiles below |
| date_diag_primary_disease + diag_liver_disease | M | `Condition.onsetDateTime` (date); `Condition.code` (diagnosis) | [PatientLiverDiseaseDiagnosis](StructureDefinition-patient-liver-disease-diagnosis.html); bodySite = SNOMED 10200004; **Liver only** |
| date_diag_primary_disease + diag_renal_disease | M | `Condition.onsetDateTime` (date); `Condition.code` (diagnosis) | [PatientRenalDiseaseDiagnosis](StructureDefinition-patient-renal-disease-diagnosis.html); bodySite = SNOMED 64033007; **Kidney only** |
| center_no | M | `Patient.managingOrganization` | [Reference(StudyCentre)](StructureDefinition-study-centre.html); `identifier.value` = 1–4 |
