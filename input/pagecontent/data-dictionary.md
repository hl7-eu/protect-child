# Data Dictionary

A consolidated, searchable reference of every variable in the PROTECT-CHILD data model (v1.2), grouped by entity. For each entity the table lists the data-model field, its label, data type, requiredness, and organ scope; the entity header links to the FHIR profile mapping. For the exact FHIR element each field maps to, follow the map-page link.

**Requiredness:** M = Mandatory · R = Recommended · O = Optional. **Organ:** Both / Liver / Kidney.

## Patient

**FHIR mapping:** `Patient` + PatientDemographicsObservation + PatientImmunologyObservation + Condition (diagnosis) — see [Patient map](patient-map.html). *(DM table: `patient`, 10 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `patient_id` | patient_id | ID | M | Both |
| `gender` | Gender | Code | M | Both |
| `age_years` | Patient age (years) | Integer | R | Both |
| `age_months` | Patient age (months) | Integer | R | Both |
| `max_pra` | Pre-transplant PRA max | Integer | R | Both |
| `last_pra` | Pre-transplant PRA last | Integer | R | Both |
| `date_histological_diag` | Date of histological diagnosis | Date | M | Both |
| `date_diag_primary_disease` | Date of diagnosis of primary liver disease | Date | M | Both |
| `diag_primary_disease` | Diagnosis of primary liver disease | String | M | Both |
| `center_no` | Center number | CustomCode | M | Both |

## Donor

**FHIR mapping:** `Patient` (Donor profile) — see [Donor map](donor-map.html). *(DM table: `donor`, 5 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `donor_id` | id | ID | M | Both |
| `age_years` | Donor age (years) | Integer | M | Both |
| `age_months` | Donor age (months) | Integer | M | Both |
| `type` | Donor type | Code | M | Both |
| `liver_type` | Liver type | Code | R | Liver |

## Visit

**FHIR mapping:** `Encounter` — see [Visit map](visit-map.html). *(DM table: `visit`, 4 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `visit_id` | Visit ID | ID | M | Both |
| `patient_id` | Patient ID relationship | ElementReference | M | Both |
| `date` | Date | Date | M | Both |
| `visit_type` | Visit type | CustomCode | M | Both |

## Transplant

**FHIR mapping:** `Procedure` + TransplantDetails (`Observation` panel) — see [Transplant map](transplant-map.html). *(DM table: `transplant`, 16 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `transplant_id` | transplant_id | ID | M | Both |
| `donor_id` | Donor ID | ElementReference | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `d_r_weight_ratio` | Weight D/R ratio | Float | R | Both |
| `vessel_mismatch_d_r` | Vessel mismatch donor/recipient | Boolean | R | Both |
| `cold_ischemia_time` | Cold ischemia time | Integer | R | Both |
| `warm_ischemia_time` | Warm ischemia time | Integer | R | Both |
| `tx_type` | Type of transplant (liver, kidney, combined) | Code | M | Both |
| `date_tx` | Date of transplant | Date | M | Both |
| `time_diag_to_tx` | Time from diagnosis to transplant | Calculated | M | Both |
| `vascular_anomalies` | Vascular anomalies | String | R | Both |
| `type_surgical_biliary_anastomosis` | Type of surgical biliary anastomosis | Code | R | Liver |
| `intraoperative_complications` | Intraoperative complications | Code | R | Both |
| `intraoperative_complications_other` | Intraoperative complications (specify) | String | R | Liver |
| `type_ureteral_graft_anastomosis` | Type of ureteral graft anastomosis | Code | O | Both |
| `other_type_ureteral_graft_anastomosis` | Other type of ureteral graft anastomosis | String | O | Both |

## Immunological Data

**FHIR mapping:** `Observation` panel — see [Immunological Data map](immunological-data-map.html). *(DM table: `immunological_data`, 27 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `immunological_data_id` | immunological_data_id | ID | M | Both |
| `donor_id` | donor_id | ElementReference | O | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `blood_group` | Blood group | Code | R | Both |
| `rh_factor` | Rh Factor | Code | R | Both |
| `hla_a_1` | HLA A (Allele 1) | Integer | R | Both |
| `hla_a_2` | HLA A (Allele 2) | Integer | R | Both |
| `hla_b_1` | HLA B (Allele 1) | Integer | R | Both |
| `hla_b_2` | HLA B (Allele 2) | Integer | R | Both |
| `hla_c_1` | HLA C (Allele 1) | Integer | R | Both |
| `hla_c_2` | HLA C (Allele 2) | Integer | R | Both |
| `hla_drb1_1` | HLA DRB1 (Allele 1) | Integer | R | Both |
| `hla_drb1_2` | HLA DRB1 (Allele 2) | Integer | R | Both |
| `hla_dp_1` | HLA DP (Allele 1) | Integer | R | Both |
| `hla_dp_2` | HLA DP (Allele 2) | Integer | R | Both |
| `hla_dqb1_1` | HLA DQB1 (Allele 1) | Integer | R | Both |
| `hla_dqb1_2` | HLA DQB1 (Allele 2) | Integer | R | Both |
| `post_transplant_ab_anti_hla_dsa_class` | Post-transplant Ab anti-HLA DSA (Class) | Code | R | Both |
| `pre_trasnplant_anti_hla_dsa` | Pre-transplant anti-HLA DSA | String | R | Both |
| `mfi` | MFI Category | Code | R | Both |
| `banff_category` | Banff category (Done?) | Code | R | Both |
| `ihc_if_c4d` | IHC/IF C4d (Result) | Boolean | R | Both |
| `if` | IF | String | R | Both |
| `c4d` | C4d | String | R | Both |
| `anca` | ANCA | Boolean | R | Both |
| `antibody_type` | Antibody Type (Specification) | String | R | Both |
| `anti_hla_antibodies` | Presence of anti-HLA antibodies | Boolean | O | Both |

## BioSample

**FHIR mapping:** `Specimen` + `ServiceRequest` (analysis request) — see [BioSample map](biosample-map.html). *(DM table: `bio_sample`, 6 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `bio_sample_id` | Biological Sample ID | ID | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `collection_date` | Sample collection date | Date | R | Both |
| `send_ingemm_date` | Sample send to INGEMM date | Date | R | Both |
| `genomic_sample` | Genomic sample | Boolean | R | Both |
| `epigenomic_sample` | Epigenomic Sample | Boolean | R | Both |

## Pre-Medication

**FHIR mapping:** `MedicationStatement` (+ child statements) — see [Pre-Medication map](pre-medication-map.html). *(DM table: `pre_medication`, 7 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `pre_medication_id` | pre_med_id | ID | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `antihypertensive_treatment` | Antihypertensive treatment (describe) | Code | R | Both |
| `rituximab` | Rituximab | Boolean | R | Both |
| `date_last_rituximab` | Date of last Rituximab dose | Date | R | Both |
| `other_medications` | Other medications | String | R | Both |
| `antiviral_prophylaxis` | Antiviral prophylaxis | Boolean | R | Both |

## Clinical Variable

**FHIR mapping:** `Observation` panel — see [Clinical Variable map](clinical-variable-map.html). *(DM table: `clinical_variable`, 10 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `clinical_variable_id` | clinical_variable_id | ID | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `weight` | Weight | Float | R | Both |
| `height` | Height | Float | R | Both |
| `concomitant_disease` | concomitant_disease_id | Code | M | Both |
| `description` | Description | String | R | Both |
| `diuresis_value` | Diuresis value (ml/day) | Float | R | Both |
| `other_symptoms` | Other Symptoms | String | R | Both |
| `other_concomitant` | Other concomitant diseases | String | R | Both |
| `organ_dysfunction` | Specify organ dysfunction | String | R | Both |

## Vital Sign

**FHIR mapping:** `Observation` panel — see [Vital Sign map](vital-sign-map.html). *(DM table: `vital_sign`, 21 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `vital_sign_id` | vital_sign_id | ID | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `date` | Date | Date | M | Both |
| `systolic_blood_pressure` | Systolic blood pressure | Integer | R | Both |
| `diastolic_blood_pressure` | Diastolic blood pressure | Integer | R | Both |
| `heart_rate` | Heart rate | Integer | R | Both |
| `oxygen_saturation` | Oxygen saturation | Integer | R | Both |
| `temperature` | Temperature | Float | R | Both |
| `bmi` | BMI | Float | R | Both |
| `sbp_percentile` | Systolic BP (mmHg) | Integer | R | Both |
| `dbp_percentile` | Diastolic BP (mmHg) | Integer | R | Both |
| `mean_sbp_24` | Mean SBP – 24h (mmHg) | Integer | R | Both |
| `mean_dbp_24` | Mean DBP – 24h (mmHg) | Integer | R | Both |
| `mean_sbp_day` | Mean SBP – Daytime (mmHg) | Integer | R | Both |
| `mean_dbp_day` | Mean DBP – Daytime (mmHg) | Integer | R | Both |
| `mean_sbp_night` | Mean SBP – Night time (mmHg) | Integer | R | Both |
| `mean_dbp_night` | Mean DBP – Night time (mmHg) | Integer | R | Both |
| `sbp_load` | SBP Load (%) | Integer | R | Both |
| `dbp_load` | DBP Load (%) | Integer | R | Both |
| `sbp_dip` | SBP Dip (%) | Integer | R | Both |
| `dbp_dip` | DBP Dip (%) | Integer | R | Both |

## Concomitant Medication

**FHIR mapping:** `MedicationStatement` — see [Concomitant Medication map](concomitant-medication-map.html). *(DM table: `concomitant_medication`, 7 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `concomitant_medication_id` | concomitant_medication_id | ID | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `medication_name` | Medication | String | R | Both |
| `dose` |  | Float | R | Both |
| `start_date` |  | Date | R | Both |
| `status` |  | Code | R | Both |
| `end_date` |  | Date | R | Both |

## Microbiology

**FHIR mapping:** `Observation` panel — see [Microbiology map](microbiology-map.html). *(DM table: `microbiology`, 35 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `microbiology_id` | microbiology_id | ID | M | Both |
| `donor_id` | donor_id | ElementReference | O | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `ebv_dna` | Blood EBV-DNA | Boolean | R | Both |
| `ebv_dna_copies` | EBV-DNA (copies/ml) | Float | R | Both |
| `ebv_igm_anti_ea` | EBV serology IgM anti-EA | Boolean | R | Both |
| `ebv_igm_anti_vca` | EBV serology IgM anti-VCA | Boolean | R | Both |
| `ebv_igg_anti_vca` | EBV serology IgG anti-VCA | Boolean | R | Both |
| `ebv_igg_ebna` | EBV serology IgG EBNA | Boolean | R | Both |
| `cmv_dna` | Blood CMV-DNA | Boolean | R | Both |
| `cmv_dna_copies` | CMV-DNA (copies/ml) | Float | R | Both |
| `cmv_igm` | CMV serology IgM | Boolean | R | Both |
| `cmv_igg` | CMV serology IgG | Boolean | R | Both |
| `parvovirus_b19_dna` | Blood Parvovirus B19-DNA | Boolean | R | Both |
| `parvovirus_b19_dna_copies` | Blood Parvovirus B19 DNA (copies/ml) | Float | R | Both |
| `parvovirus_b19_igg` | Parvovirus B19 serology IgG | Boolean | R | Both |
| `parvovirus_b19_igm` | Parvovirus B19 serology IgM | Boolean | R | Both |
| `hsv_igg` | HSV serology IgG | Boolean | R | Both |
| `hsv_igm` | HSV serology IgM | Boolean | R | Both |
| `adenovirus_igg` | Adenovirus serology IgG | Boolean | R | Both |
| `adenovirus_igm` | Adenovirus serology IgM | Boolean | R | Both |
| `blood_adenovirus_dna` | Blood Adenovirus DNA Result | Boolean | R | Both |
| `blood_adenovirus_dna_copies` | Blood Adenovirus DNA (copies/ml) | Float | R | Both |
| `vzv_igg` | VZV serology IgG | Boolean | R | Both |
| `vzv_igm` | VZV serology IgM | Boolean | R | Both |
| `blood_bkv_dna` | Blood BKV-DNA | Boolean | R | Both |
| `blood_bkv_dna_copies` | Blood BKV-DNA (copies/ml) | Float | R | Both |
| `urine_bkv_dna` | Urine BKV-DNA | Boolean | R | Both |
| `bkv_dna_kidney_biopsy` | BKV-DNA on kidney biopsy | Boolean | R | Kidney |
| `bkv_fish_kidney_biopsy` | BKV FISH on kidney biopsy | Boolean | R | Kidney |
| `blood_colture` | Blood colture | Boolean | R | Kidney |
| `urine_colture` | Urine colture | Boolean | R | Kidney |
| `other_positivity` | Other positivity | String | R | Kidney |
| `ebv_hepatitis_liver` | EBV-Hepatitis on liver | Boolean | R | Liver |
| `evidence_bkvan` | Histological evidence of BKVAN | Code | R | Both |

## Instrumental Investigation

**FHIR mapping:** `Observation` — see [Instrumental Investigation map](instrumental-investigation-map.html). *(DM table: `instrumental_investigation`, 7 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `inst_inv_id` | Patient Instrumental Investigation ID | ID | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `instrumental_investigation` | Instrumental investigation | Code | M | Both |
| `date` | Date | Date | R | Both |
| `result` | Result | Code | R | Both |
| `abnormality` | Abnormality | String | R | Both |
| `other_investigation` | Other Investigation | String | R | Both |

## Immunosuppressant

**FHIR mapping:** `Medication` — see [Immunosuppressant map](immunosuppressant-map.html). *(DM table: `immunosuppressant`, 2 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `imm_id` | Immunosuppressant ID |  | ID | Both |
| `name` | Name | Initial immunosuppressive treatment after transplantation (M)
Immunosuppresive treatment
Immunosuppressive drug type | Code | Both |

## Immunosuppressant to Patient (ImmPat)

**FHIR mapping:** `MedicationStatement` + ImmPatPKObservation (`Observation`) — see [Immunosuppressant to Patient (ImmPat) map](immunosuppressant-map.html). *(DM table: `imm_pat`, 11 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `imm_pat_id` | Immunosuppressant to patient ID | ID | M | Both |
| `imm_id` | Immunosuppressant ID relationship | ElementReference | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `phase` | Phase | CustomCode | M | Both |
| `dose` | dose | Float | R | Both |
| `pre_dose_level` | pre-dose level | Float | R | Both |
| `csa_2h_post_dose_level` | CsA 2h post-dose level | String | R | Both |
| `auc` | AUC | Float | R | Both |
| `start_date` | start_date | Date | R | Both |
| `end_date` | end_date | Date | R | Both |
| `unit` | Unit | Code | R | Both |

## Lab Test

**FHIR mapping:** `ObservationDefinition` — see [Lab Test map](lab-map.html). *(DM table: `lab_test`, 2 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `lab_test_id` | lab_test_id | ID | M | Both |
| `name` | Name | Code | M | Both |

## Lab Result

**FHIR mapping:** `Observation` — see [Lab Result map](lab-map.html). *(DM table: `lab_result`, 8 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `lab_result_id` | lab_result_id | ID | M | Both |
| `lab_test_id` | lab_test_id | ElementReference | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `date` | Date | Date | M | Both |
| `unit` | unit | Code | M | Both |
| `value` | Value | Float | R | Both |
| `gfr_formula` | Formula used GFR | String | R | Both |
| `gfr_cyst_formula` | Formula used (GFR Cyst) | String | R | Both |

## Clinical Event Type

**FHIR mapping:** `CodeSystem` / `ValueSet` — see [Clinical Event Type map](clinical-event-type-map.html). *(DM table: `clinical_event_type`, 2 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `clinical_event_type_id` | patient_id | ID | M | Both |
| `name` | Name | Code | M | Both |

## Clinical Event

**FHIR mapping:** `Condition` + ClinicalEventFlagObservation + ClinicalEventProcedure — see [Clinical Event map](clinical-event-map.html). *(DM table: `clinical_event`, 23 fields.)*

| Field | Label | Type | Req | Organ |
| --- | --- | --- | --- | --- |
| `clinical_event_id` | Clinical Event ID | ID | M | Both |
| `clinical_event_type_id` | Clinical Event Type ID | ElementReference | M | Both |
| `visit_id` | Visit ID | ElementReference | M | Both |
| `event_phase` | Event Phase | CustomCode | R | Both |
| `event_number` | Event Number | Calculated | R | Both |
| `specify_kidney_rejection_episode` | Specify Kidney Rejection Episode | String | O | Both |
| `dgf` | Delayed Graft Function | Boolean | O | Both |
| `previous_urological_intervention` | Previous urological intervention | String | O | Both |
| `vascular_complication_type` | Vascular Complication Type | Code | O | Both |
| `episodes_aki_after_ltx` | Episodes of AKI after LTx | Boolean | O | Both |
| `histologic_evidence_cni_toxicity` | Histologic evidence of CNI toxicity | Boolean | O | Both |
| `hypoxic_ischemic_event_pltx` | Hypoxic ischemic events after pLTx | Boolean | O | Both |
| `dialysis_type` | Type (Dialysis) | Code | O | Both |
| `dialysis_start_date` | Start date (Dialysis) | Date | O | Both |
| `dialysis_end_date` | End date (Dialysis) | Date | O | Both |
| `cause_death` | Cause of Death | String | O | Both |
| `concomitant_medications` | Concomitant medications | Boolean | O | Both |
| `retransplantation` | Retransplantation (Status) | Boolean | O | Both |
| `retransplantation_date` | Retransplantation (Start date) | Date | O | Both |
| `treatment_adherence` | Treatment adherence (Status) | Boolean | O | Both |
| `date_entry_transplant_list` | Date of entry in transplant list | Date | O | Both |
| `underlying_prothrombotic_disorders` | Underlying prothrombotic disorders | String | O | Both |
| `kidney_biopsy` | Kidney Biopsy | String | O | Both |
