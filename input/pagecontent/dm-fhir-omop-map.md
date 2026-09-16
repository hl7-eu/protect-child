# DM → FHIR → OMOP Crosswalk

This page presents the full three-way crosswalk for the PROTECT-CHILD data model: each data-model variable, the **FHIR** element it maps to in this IG, and the **OMOP CDM** table, field and standardized concept it maps to. It consolidates the per-entity [FHIR model maps](mapping.html) and the OMOP mapping into a single reference.

Only variables with a completed OMOP mapping are shown. **Every OMOP concept is listed on its own row**; a variable that maps to several OMOP fields (e.g. a `..._concept_id` plus a `unit_concept_id` or `value_as_concept_id`), or whose field accepts several coded values (a value set), spans as many rows as it has concepts, with the DM field and FHIR element repeated. Concept IDs are OMOP `concept_id` values — look them up by pasting the ID into the search box of the [OHDSI Athena](https://athena.ohdsi.org/) vocabulary browser. IDs ≥ `2000000000` (vocabulary **PROTECT-CHILD**) are custom concepts. A `—` marks a structural or foreign-key field with no concept code.

## Patient

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `patient_id` | `Patient.identifier.value` | `PERSON` · `person_id` | — | — |
| `gender` | `Patient.gender` | `PERSON` · `gender_concept_id` | `8532` — FEMALE | Gender |
|  |  |  | `8507` — MALE | Gender |
| `birth_year` | — _(FHIR IG derives age via `age_years`/`age_months` components, not birthDate)_ | `PERSON` · `year_of_birth` | — | — |
| `birth_month` | — _(FHIR IG derives age via `age_years`/`age_months` components, not birthDate)_ | `PERSON` · `month_of_birth` | — | — |
| `max_pra` | `Observation.component[max_pra].valueInteger` | `MEASUREMENT` · `measurement_concept_id` | `21493706` — Calculated panel reactive antibody - Serum | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8554` — percent | UCUM |
| `last_pra` | `Observation.component[last_pra].valueInteger` | `MEASUREMENT` · `measurement_concept_id` | `21493706` — Calculated panel reactive antibody - Serum | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8554` — percent | UCUM |
| `date_histological_diag` | `Observation.component[date_histological_diag].valueDateTime` | `OBSERVATION` · `observation_concept_id` | `2000000042` — Primary diagnosis confirmed by histology | PROTECT-CHILD |
|  |  | `OBSERVATION` · `observation_date` | — | — |
| `date_diag_primary_disease` | `Condition.onsetDateTime` | `CONDITION_OCCURRENCE` · `condition_start_date` | — | — |
| `diag_primary_disease` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | — | — |
|  |  | `CONDITION_OCCURRENCE` · `condition_status_concept_id` | `32902` — Primary diagnosis | Condition Status |
| `center_no` | `Patient.managingOrganization` | `PERSON` · `care_site_id` | — | — |

## Donor

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `donor_id` | `Patient.identifier.value` | `PERSON` · `person_id` | — | — |
| `age_years` | `Observation.component[age_years].valueQuantity` | `PERSON` · `year_of_birth` | — | — |
| `age_months` | `Observation.component[age_months].valueQuantity` | `PERSON` · `month_of_birth` | — | — |
| `type` | `Patient.deceasedBoolean` | `OBSERVATION` · `observation_concept_id` | `2000000016` — Type of donor | PROTECT-CHILD |
|  |  | `OBSERVATION` · `value_as_concept_id` | `45885033` — Deceased | LOINC |
|  |  |  | `45885109` — Living | LOINC |
| `liver_type` | `Observation.valueCodeableConcept` | `MEASUREMENT` · `measurement_concept_id` | `3044734` — Graft portion Liver | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `4114660` — Entire | SNOMED |
|  |  |  | `4116993` — Partial | SNOMED |

## Visit

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `visit_id` | `Encounter.identifier.value` | `VISIT_OCCURRENCE` · `visit_occurrence_id` | — | — |
| `patient_id` | `Encounter.subject` | `VISIT_OCCURRENCE` · `person_id` | — | — |
| `date` | `Encounter.period.start` | `VISIT_OCCURRENCE` · `visit_start_date` | — | — |
| `visit_type` | `Encounter.type` | `VISIT_OCCURRENCE` · `visit_concept_id` | `9202` — Outpatient Visit | Visit |
|  |  | `OBSERVATION` · `observation_concept_id` | `2000000002` — Pre-transplant visit | PROTECT-CHILD |
|  |  |  | `4081745` — Follow-up 1 month | SNOMED |
|  |  |  | `44789369` — Follow-up 3 months | SNOMED |
|  |  |  | `4103967` — Follow-up 6 months | SNOMED |
|  |  |  | `4081746` — Follow-up 1 year | SNOMED |
|  |  |  | `44789049` — Follow-up 2 years | SNOMED |
|  |  |  | `2000000003` — Clinical event visit | PROTECT-CHILD |
|  |  |  | `2000000004` — Termination visit | PROTECT-CHILD |

## Transplant

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `transplant_id` | `Procedure.identifier.value` | `PROCEDURE_OCCURRENCE` · `procedure_occurrence_id` | — | — |
| `visit_id` | `Procedure.encounter` | `VISIT_OCCURRENCE` · `visit_occurrence_id` | — | — |
| `d_r_weight_ratio` | `Observation.component[d_r_weight_ratio].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `2000000009` — Graft-to-recipient weight ratio | PROTECT-CHILD |
| `vessel_mismatch_d_r` | `Observation.component[vessel_mismatch_d_r].valueBoolean` | `OBSERVATION` · `observation_concept_id` | `2000000010` — Donor–recipient vessel mismatch | PROTECT-CHILD |
| `cold_ischemia_time` | `Observation.component[cold_ischemia_time].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3045879` — Cold ischemic time {Organ} | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8550` — minute | UCUM |
| `warm_ischemia_time` | `Observation.component[warm_ischemia_time].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3043350` — Warm ischemic time {Organ} | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8550` — minute | UCUM |
| `tx_type` | `Procedure.code` | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `4076862` — Transplantation of liver | SNOMED |
|  |  |  | `4322471` — Transplant of kidney | SNOMED |
| `date_tx` | `Procedure.performedDateTime` | `PROCEDURE_OCCURRENCE` · `procedure_date` | — | — |
| `vascular_anomalies` | `Observation.component[vascular_anomalies].valueString` | `OBSERVATION` · `observation_concept_id` | `37204873` — Vascular malformation | SNOMED |
| `type_surgical_biliary_anastomosis` | `Procedure.code` | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `2000000017` — Duct-to-Duct Anastomosis | PROTECT-CHILD |
|  |  |  | `37151270` — Choledochocholedochostomy | SNOMED |
|  |  |  | `2000000018` — Hepaticocholedochostomy | PROTECT-CHILD |
|  |  |  | `2000000019` — Bilioenteric Anastomosis | PROTECT-CHILD |
|  |  |  | `4200500` — Roux-en-Y hepaticojejunostomy | SNOMED |
| `intraoperative_complications` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `4308716` — Intraoperative hemorrhage | SNOMED |
|  |  |  | `4132549` — Injury of bile duct | SNOMED |
|  |  |  | `4308537` — Injury to blood vessel during surgery | SNOMED |
|  |  |  | `2000000031` — Liver ischemia | PROTECT-CHILD |
|  |  |  | `4087151` — Injury of ureter | SNOMED |
|  |  |  | `442553` — Injury of urinary bladder | SNOMED |
|  |  |  | `42536547` — Ischemia of kidney | SNOMED |
| `intraoperative_complications_other` | `Condition.note` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `42538061` — Intraoperative complication | SNOMED |
| `type_ureteral_graft_anastomosis` | `Procedure.code` | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `2109661` — Ureteroneocystostomy; anastomosis of single ureter to bladder | CPT4 |
|  |  |  | `4198228` — Formation of cutaneous ureterostomy | SNOMED |
|  |  |  | `4264011` — Ureterostomy | SNOMED |
|  |  |  | `4044045` — Suprapubic cystostomy | SNOMED |
| `other_type_ureteral_graft_anastomosis` | `Procedure.code.text` | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `4267594` — Anastomosis of ureter | SNOMED |

## Immunological Data

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `visit_id` | `Observation.encounter` | `VISIT_OCCURRENCE` · `visit_occurrence_id` | — | — |
| `blood_group` | `Observation.component[blood_group].valueCodeableConcept` | `MEASUREMENT` · `measurement_concept_id` | `3002529` — ABO group [Type] in Blood | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `36308333` — Group A | LOINC |
|  |  |  | `36309587` — Group B | LOINC |
|  |  |  | `36311267` — Group AB | LOINC |
|  |  |  | `36309715` — Group O | LOINC |
| `rh_factor` | `Observation.component[rh_factor].valueCodeableConcept` | `MEASUREMENT` · `measurement_concept_id` | `3003310` — Rh [Type] in Blood | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45884084` — Positive | LOINC |
|  |  |  | `45878583` — Negative | LOINC |
| `hla_a_1` | `Observation.component[hla_a_1].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3024471` — HLA-A [Type] | LOINC |
| `hla_a_2` | `Observation.component[hla_a_2].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3024471` — HLA-A [Type] | LOINC |
| `hla_b_1` | `Observation.component[hla_b_1].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3025311` — HLA-B [Type] | LOINC |
| `hla_b_2` | `Observation.component[hla_b_2].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3025311` — HLA-B [Type] | LOINC |
| `hla_c_1` | `Observation.component[hla_c_1].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3026777` — HLA-C [Type] | LOINC |
| `hla_c_2` | `Observation.component[hla_c_2].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3026777` — HLA-C [Type] | LOINC |
| `hla_drb1_1` | `Observation.component[hla_drb1_1].valueString` | `MEASUREMENT` · `measurement_concept_id` | `40760417` — HLA-DRB1 [Type] | LOINC |
| `hla_drb1_2` | `Observation.component[hla_drb1_2].valueString` | `MEASUREMENT` · `measurement_concept_id` | `40760417` — HLA-DRB1 [Type] | LOINC |
| `hla_dp_1` | `Observation.component[hla_dp_1].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3013862` — HLA-DP [Type] | LOINC |
| `hla_dp_2` | `Observation.component[hla_dp_2].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3013862` — HLA-DP [Type] | LOINC |
| `hla_dqb1_1` | `Observation.component[hla_dqb1_1].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3038881` — HLA-DQB1 [Type] | LOINC |
| `hla_dqb1_2` | `Observation.component[hla_dqb1_2].valueString` | `MEASUREMENT` · `measurement_concept_id` | `3038881` — HLA-DQB1 [Type] | LOINC |
| `mfi` | `Observation.component[mfi].valueCodeableConcept` | `MEASUREMENT` · `measurement_concept_id` | `2000000051` — MFI category: Weak Reaction (500-2k) | PROTECT-CHILD |
|  |  |  | `2000000052` — MFI category: Moderate Reaction (2k-4k) | PROTECT-CHILD |
|  |  |  | `2000000053` — MFI category: Strong Reaction (>4k) | PROTECT-CHILD |
| `banff_category` | `Observation.component[banff_category].valueCodeableConcept` | `MEASUREMENT` · `measurement_concept_id` | `2000000044` — Banff Classification of Allograft Pathology: Category 1 | PROTECT-CHILD |
|  |  |  | `2000000045` — Banff Classification of Allograft Pathology: Category 2 | PROTECT-CHILD |
|  |  |  | `2000000046` — Banff Classification of Allograft Pathology: Category 3 | PROTECT-CHILD |
|  |  |  | `2000000047` — Banff Classification of Allograft Pathology: Category 4 | PROTECT-CHILD |
|  |  |  | `2000000048` — Banff Classification of Allograft Pathology: Category 5 | PROTECT-CHILD |
| `ihc_if_c4d` | `Observation.component[ihc_if_c4d].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `4015468` — Complement C4d measurement | SNOMED |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `9189` — Negative | SNOMED |
|  |  |  | `9191` — Positive | SNOMED |
| `anca` | `Observation.component[anca].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3009628` — Neutrophil cytoplasmic Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45884084` — Positive | LOINC |
|  |  |  | `45878583` — Negative | LOINC |
| `anti_hla_antibodies` | `Observation.component[anti_hla_antibodies].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3035516` — HLA Ab [Presence] | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45884084` — Positive | LOINC |
|  |  |  | `45878583` — Negative | LOINC |

## Vital Sign

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `visit_id` | `Observation.encounter` | `MEASUREMENT` · `visit_occurrence_id` | — | — |
| `date` | `Observation.effectiveDateTime` | `MEASUREMENT` · `measurement_date` | — | — |
| `systolic_blood_pressure` | `Observation.component[systolic_bp].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3004249` — Systolic blood pressure | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8876` — millimeter mercury column | UCUM |
| `diastolic_blood_pressure` | `Observation.component[diastolic_bp].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3012888` — Diastolic blood pressure | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8876` — millimeter mercury column | UCUM |
| `heart_rate` | `Observation.component[heart_rate].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3027018` — Heart rate | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8483` — counts per minute | UCUM |
| `oxygen_saturation` | `Observation.component[oxygen_saturation].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `4196147` — Peripheral oxygen saturation | SNOMED |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8554` — percent | UCUM |
| `temperature` | `Observation.component[temperature].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3020891` — Body temperature | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `586323` — degree Celsius | UCUM |
| `bmi` | `Observation.component[bmi].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `4245997` — Body mass index | SNOMED |
| `sbp_percentile` | `Observation.component[sbp_percentile].valueInteger` | `MEASUREMENT` · `measurement_concept_id` | `44806887` — Systolic blood pressure centile | SNOMED |
| `dbp_percentile` | `Observation.component[dbp_percentile].valueInteger` | `MEASUREMENT` · `measurement_concept_id` | `44806886` — Diastolic blood pressure centile | SNOMED |
| `mean_sbp_24` | `Observation.component[mean_sbp_24].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `36032120` — Systolic blood pressure mean | LOINC |
| `mean_dbp_24` | `Observation.component[mean_dbp_24].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `36031214` — Diastolic blood pressure mean | LOINC |
| `mean_sbp_day` | `Observation.component[mean_sbp_day].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `4194471` — Average day interval systolic blood pressure | SNOMED |
| `mean_dbp_day` | `Observation.component[mean_dbp_day].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `4199654` — Average day interval diastolic blood pressure | SNOMED |
| `mean_sbp_night` | `Observation.component[mean_sbp_night].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `4199649` — Average night interval systolic blood pressure | SNOMED |
| `mean_dbp_night` | `Observation.component[mean_dbp_night].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `4194578` — Average night interval diastolic blood pressure | SNOMED |
| `sbp_load` | `Observation.component[sbp_load].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `2000000038` — Systolic blood pressure load | PROTECT-CHILD |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8554` — percent | UCUM |
| `dbp_load` | `Observation.component[dbp_load].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `2000000039` — Diastolic blood pressure load | PROTECT-CHILD |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8554` — percent | UCUM |
| `sbp_dip` | `Observation.component[sbp_dip].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `2000000040` — Systolic blood pressure Dip | PROTECT-CHILD |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8554` — percent | UCUM |
| `dbp_dip` | `Observation.component[dbp_dip].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `2000000041` — Diastolic blood pressure Dip | PROTECT-CHILD |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8554` — percent | UCUM |

## BioSample

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `bio_sample_id` | `Specimen.identifier.value` | `SPECIMEN` · `specimen_id` | — | — |
| `collection_date` | `Specimen.collection.collectedDateTime` | `SPECIMEN` · `specimen_concept_id` | `4048506` — Specimen | SNOMED |
|  |  | `SPECIMEN` · `specimen_date` | — | — |

## Pre-Medication

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `visit_id` | `MedicationStatement.context` | `DRUG_EXPOSURE` · `visit_occurrence_id` | — | — |
|  |  | `PROCEDURE_OCCURRENCE` · `visit_occurrence_id` | — | — |
| `antihypertensive_treatment` | `MedicationStatement.medicationCodeableConcept` | `DRUG_EXPOSURE` · `drug_concept_id` | `1332418` — amlodipine | RxNorm |
|  |  |  | `1318853` — nifedipine | RxNorm |
|  |  |  | `1340128` — captopril | RxNorm |
|  |  |  | `1314002` — atenolol | RxNorm |
|  |  |  | `1346823` — carvedilol | RxNorm |
|  |  |  | `1353766` — propranolol | RxNorm |
|  |  |  | `1309068` — minoxidil | RxNorm |
|  |  |  | `1398937` — clonidine | RxNorm |
|  |  |  | `1363053` — doxazosin | RxNorm |
|  |  | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `4198565` — Administration of prophylactic angiotensin converting enzyme inhibitor | SNOMED |
|  |  |  | `4207461` — Beta adrenergic receptor blocking agent therapy | SNOMED |
| `rituximab` | `MedicationStatement.status` | `DRUG_EXPOSURE` · `drug_concept_id` | `1314273` — rituximab | RxNorm |
| `date_last_rituximab` | `MedicationStatement.effectiveDateTime` | `DRUG_EXPOSURE` · `drug_exposure_end_date` | — | — |
| `antiviral_prophylaxis` | `MedicationStatement.status` | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `619308` — Administration of prophylactic antiviral | SNOMED |

## Clinical Variable

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `weight` | `Observation.component[weight].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3025315` — Body weight | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `9529` — kilogram | UCUM |
| `height` | `Observation.component[height].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3036277` — Body height | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8582` — centimeter | UCUM |
| `concomitant_disease` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `200219` — Abdominal pain | SNOMED |
|  |  |  | `45757063` — Allergic Bronchopulmonary Mycosis | SNOMED |
|  |  |  | `200528` — Ascites | SNOMED |
|  |  |  | `195856` — Cholangitis | SNOMED |
|  |  |  | `434621` — Autoimmune disease | SNOMED |
|  |  |  | `192963` — Disorder of pancreas | SNOMED |
|  |  |  | `201820` — Diabetes mellitus | SNOMED |
|  |  |  | `196523` — Diarrhea | SNOMED |
|  |  |  | `433595` — Edema | SNOMED |
|  |  |  | `4096682` — Bleeding from nose | SNOMED |
|  |  |  | `437663` — Fever | SNOMED |
|  |  |  | `40480518` — Hyperplasia of gingiva | SNOMED |
|  |  |  | `4150016` — Malabsorption of glucose | SNOMED |
|  |  |  | `378253` — Headache | SNOMED |
|  |  |  | `4223098` — Hepatic artery thrombosis | SNOMED |
|  |  |  | `4029488` — Hepatic encephalopathy | SNOMED |
|  |  |  | `4245975` — Hepatic failure | SNOMED |
|  |  |  | `197676` — Large liver | SNOMED |
|  |  |  | `4159144` — Hepatopulmonary syndrome | SNOMED |
|  |  |  | `196455` — Hepatorenal syndrome | SNOMED |
|  |  |  | `134718` — Hirsutism | SNOMED |
|  |  |  | `376965` — Hypertensive retinopathy | SNOMED |
|  |  |  | `316866` — Hypertensive disorder | SNOMED |
|  |  |  | `4120314` — Hypertriglyceridemia | SNOMED |
|  |  |  | `45766189` — Hypoxic ischemic encephalopathy | SNOMED |
|  |  |  | `4302654` — Itching | SNOMED |
|  |  |  | `137977` — Jaundice | SNOMED |
|  |  |  | `37167217` — De novo thrombotic microangiopathy following transplant of kidney | SNOMED |
|  |  |  | `4184746` — Left ventricular hypertrophy | SNOMED |
|  |  |  | `315085` — Lymphadenopathy | SNOMED |
|  |  |  | `75004` — Frank hematuria | SNOMED |
|  |  |  | `31967` — Nausea | SNOMED |
|  |  |  | `4306451` — Oliguria | SNOMED |
|  |  |  | `4094986` — Ulcer of mouth | SNOMED |
|  |  |  | `4290672` — Acholic stool | SNOMED |
|  |  |  | `140214` — Eruption | SNOMED |
|  |  |  | `377091` — Seizure | SNOMED |
|  |  |  | `4083797` — Telangiectasia disorder | SNOMED |
|  |  |  | `200527` — Splenomegaly | SNOMED |
|  |  |  | `138455` — Stomatitis | SNOMED |
|  |  |  | `4261202` — Uremia | SNOMED |
|  |  |  | `4318546` — Stenosis of ureter | SNOMED |
|  |  |  | `374034` — Visual disturbance | SNOMED |
|  |  |  | `441408` — Vomiting | SNOMED |
|  |  |  | `2000000033` — Histological evidence of MMF-related enteropathy | PROTECT-CHILD |
|  |  | `OBSERVATION` · `observation_concept_id` | `376961` — Disturbance of consciousness | SNOMED |
|  |  |  | `4223659` — Fatigue | SNOMED |
|  |  |  | `4272240` — Malaise | SNOMED |
|  |  |  | `4134010` — Weight decreased | SNOMED |
|  |  |  | `2000000028` — Histological evidence of monoclonal proliferation | PROTECT-CHILD |
|  |  |  | `2000000037` — Histological evidence on biospy | PROTECT-CHILD |
|  |  | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `4304943` — Endoscopic retrograde cholangiopancreatography | SNOMED |
|  |  |  | `44789813` — Percutaneous transhepatic biliary drainage single | SNOMED |
| `diuresis_value` | `Observation.component[diuresis_value].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `4247279` — Diuresis | SNOMED |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8752` — millimeter per hour | UCUM |

## Concomitant Medication

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `concomitant_medication_id` | `MedicationStatement.identifier.value` | `DRUG_EXPOSURE` · `drug_exposure_id` | — | — |
| `visit_id` | `MedicationStatement.context` | `DRUG_EXPOSURE` · `visit_occurrence_id` | — | — |
| `medication_name` | `MedicationStatement.medicationCodeableConcept.text` | `DRUG_EXPOSURE` · `drug_concept_id` | — | — |
| `dose` | `MedicationStatement.dosage.doseAndRate.doseQuantity` | `OBSERVATION` · `observation_concept_id` | `4162374` — Drug dose | SNOMED |
| `start_date` | `MedicationStatement.effectivePeriod.start` | `DRUG_EXPOSURE` · `drug_exposure_start_date` | — | — |
| `status` | `MedicationStatement.status` | `OBSERVATION` · `observation_concept_id` | `2000000043` — Ongoing medication | PROTECT-CHILD |
| `end_date` | `MedicationStatement.effectivePeriod.end` | `DRUG_EXPOSURE` · `drug_exposure_end_date` | — | — |

## Microbiology

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `visit_id` | `Observation.encounter` | `MEASUREMENT` · `visit_occurrence_id` | — | — |
| `ebv_dna` | `Observation.component[ebvDna].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3012570` — Epstein Barr virus DNA [Presence] in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `ebv_dna_copies` | `Observation.component[ebvDnaCopies].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3037329` — Epstein Barr virus DNA [#/volume] (viral load) in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8799` — copies per milliliter | UCUM |
| `ebv_igm_anti_ea` | `Observation.component[ebvIgmAntiEa].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3033477` — Epstein Barr virus early Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `ebv_igm_anti_vca` | `Observation.component[ebvIgmAntiVca].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3012732` — Epstein Barr virus nuclear IgM Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `ebv_igg_anti_vca` | `Observation.component[ebvIggAntiVca].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3006585` — Epstein Barr virus capsid IgG Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `ebv_igg_ebna` | `Observation.component[ebvIggEbna].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3021849` — Epstein Barr virus nuclear IgG Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `cmv_dna` | `Observation.component[cmvDna].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3021884` — Cytomegalovirus DNA [Presence] in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `cmv_dna_copies` | `Observation.component[cmvDnaCopies].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3024974` — Cytomegalovirus DNA [#/volume] (viral load) in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8799` — copies per milliliter | UCUM |
| `cmv_igm` | `Observation.component[cmvIgm].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3013332` — Cytomegalovirus IgM Ab [Presence] in Serum or Plasma | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `cmv_igg` | `Observation.component[cmvIgg].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3012887` — Cytomegalovirus IgG Ab [Presence] in Serum or Plasma by Immunoassay | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `parvovirus_b19_dna` | `Observation.component[parvoB19Dna].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3032435` — Parvovirus B19 DNA [Presence] in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `parvovirus_b19_dna_copies` | `Observation.component[parvoB19DnaCopies].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3032993` — Parvovirus B19 DNA [#/volume] (viral load) in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8799` — copies per milliliter | UCUM |
| `parvovirus_b19_igg` | `Observation.component[parvoB19Igg].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3006410` — Parvovirus B19 IgG Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `parvovirus_b19_igm` | `Observation.component[parvoB19Igm].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3008321` — Parvovirus B19 IgM Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `hsv_igg` | `Observation.component[hsvIgg].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3020134` — Herpes simplex virus IgG Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45880296` — Not detected | LOINC |
|  |  |  | `45877985` — Detected | LOINC |
| `hsv_igm` | `Observation.component[hsvIgm].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3010761` — Herpes simplex virus IgM Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `adenovirus_igg` | `Observation.component[adenovirusIgg].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3040947` — Adenovirus IgG Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `adenovirus_igm` | `Observation.component[adenovirusIgm].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3036242` — Adenovirus IgM Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `blood_adenovirus_dna` | `Observation.component[bloodAdenovirusDna].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `36203755` — Adenovirus DNA [Presence] in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `blood_adenovirus_dna_copies` | `Observation.component[bloodAdenovirusDnaCopies].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3028979` — Adenovirus DNA [#/volume] (viral load) in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8799` — copies per milliliter | UCUM |
| `vzv_igg` | `Observation.component[vzvIgg].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3022386` — Varicella zoster virus IgG Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `vzv_igm` | `Observation.component[vzvIgm].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3016065` — Varicella zoster virus IgM Ab [Presence] in Serum | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `blood_bkv_dna` | `Observation.component[bloodBkvDna].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `40766205` — BK virus DNA [Presence] in Blood | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45878583` — Negative | LOINC |
|  |  |  | `45884084` — Positive | LOINC |
| `blood_bkv_dna_copies` | `Observation.component[bloodBkvDnaCopies].valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `3029226` — BK virus DNA [#/volume] (viral load) in Blood by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `unit_concept_id` | `8799` — copies per milliliter | UCUM |
| `urine_bkv_dna` | `Observation.component[urineBkvDna].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `3029173` — BK virus DNA [Presence] in Urine by NAA with probe detection | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45880296` — Not detected | LOINC |
|  |  |  | `45877985` — Detected | LOINC |
| `bkv_dna_kidney_biopsy` | `Observation.component[bkvDnaKidneyBiopsy].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `1091792` — BK virus DNA [Presence] in Specimen | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45880296` — Not detected | LOINC |
|  |  |  | `45877985` — Detected | LOINC |
| `bkv_fish_kidney_biopsy` | `Observation.component[bkvFishKidneyBiopsy].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `1091792` — BK virus DNA [Presence] in Specimen | LOINC |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `45880296` — Not detected | LOINC |
|  |  |  | `45877985` — Detected | LOINC |
|  |  | `OBSERVATION` · `observation_concept_id` | `1073315` — Fluorescence in situ hybridization technique | SNOMED |
| `blood_colture` | `Observation.component[bloodColture].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `4107893` — Blood culture | SNOMED |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `9189` — Negative | SNOMED |
|  |  |  | `9191` — Positive | SNOMED |
| `urine_colture` | `Observation.component[urineColture].valueBoolean` | `MEASUREMENT` · `measurement_concept_id` | `4024509` — Urine culture | SNOMED |
|  |  | `MEASUREMENT` · `value_as_concept_id` | `9189` — Negative | SNOMED |
|  |  |  | `9191` — Positive | SNOMED |
| `ebv_hepatitis_liver` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `4119142` — Epstein-Barr virus hepatitis | SNOMED |
| `evidence_bkvan` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `37017585` — BK virus nephropathy | SNOMED |

## Instrumental Investigation

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `visit_id` | `Observation.encounter` | `VISIT_OCCURRENCE` · `visit_occurrence_id` | — | — |
| `instrumental_investigation` | `Observation.code` | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `4061009` — CT of abdomen | SNOMED |
|  |  |  | `4083230` — MRI of abdomen | SNOMED |
|  |  |  | `4299523` — Angiography | SNOMED |
|  |  |  | `4303663` — CT angiography with contrast | SNOMED |
|  |  |  | `37311324` — MRI of brain | SNOMED |
|  |  |  | `4329502` — SPECT of kidney using dimercaptosuccinic acid | SNOMED |
|  |  |  | `37152490` — Doppler ultrasonography | SNOMED |
|  |  |  | `4346528` — Renal isotope studies | SNOMED |
|  |  |  | `4230911` — Echocardiography | SNOMED |
|  |  |  | `4163951` — Electrocardiographic procedure | SNOMED |
|  |  |  | `4181917` — Electroencephalogram | SNOMED |
|  |  |  | `4217034` — Kidney biopsy | SNOMED |
|  |  |  | `4167052` — Doppler ultrasonography of kidney | SNOMED |
|  |  |  | `4147846` — Echography of kidney | SNOMED |
|  |  |  | `4314001` — Biopsy of liver | SNOMED |
|  |  |  | `4160708` — Doppler ultrasonography of liver and portal system | SNOMED |
|  |  |  | `4346948` — Tc99m-MAG3 renogram | SNOMED |
|  |  |  | `4194588` — Magnetic resonance cholangiopancreatography | SNOMED |
|  |  |  | `4168020` — Fluoroscopic micturating cystourethrography | SNOMED |
|  |  |  | `4305790` — Positron emission tomography | SNOMED |
|  |  |  | `4060500` — CAT scan - whole body | SNOMED |
|  |  |  | `4037672` — Ultrasonography | SNOMED |
|  |  |  | `40479203` — Ultrasound elastography of liver | SNOMED |
| `date` | `Observation.effectiveDateTime` | `PROCEDURE_OCCURRENCE` · `procedure_date` | — | — |
| `result` | `Observation.valueCodeableConcept` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `4085245` — No abnormality detected | SNOMED |
|  |  |  | `40484102` — Abnormal finding on evaluation procedure | SNOMED |

## Immunosuppressant / ImmPat

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `name` | `Medication.code` | `DRUG_EXPOSURE` · `drug_concept_id` | `1506270` — methylprednisolone | RxNorm |
|  |  |  | `1551099` — prednisone | RxNorm |
|  |  |  | `950637` — tacrolimus | RxNorm |
|  |  |  | `19010482` — cyclosporine | RxNorm |
|  |  |  | `19003999` — mycophenolate mofetil | RxNorm |
|  |  |  | `19012565` — mycophenolic acid | RxNorm |
|  |  |  | `19038440` — basiliximab | RxNorm |
|  |  |  | `19136207` — lymphocyte immune globulin, anti-thymocyte globulin | RxNorm |
|  |  |  | `19011440` — everolimus | RxNorm |
|  |  |  | `19034726` — sirolimus | RxNorm |
| `visit_id` | `MedicationStatement.context` | `DRUG_EXPOSURE` · `visit_occurrence_id` | — | — |
| `phase` | `MedicationStatement.category` | `OBSERVATION` · `qualifier_concept_id` | `905623` — Induction | HemOnc |
|  |  |  | `763393` — Maintenance dose | SNOMED |
| `dose` | `MedicationStatement.dosage.doseAndRate.doseQuantity.value` | `OBSERVATION` · `observation_concept_id` | `4162374` — Drug dose | SNOMED |
| `pre_dose_level` | `Observation.valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `2000000013` — Measurement of trough drug concentration | PROTECT-CHILD |
| `csa_2h_post_dose_level` | `Observation.valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `40483123` — Measurement of ciclosporin 2 hours after dosing | SNOMED |
| `auc` | `Observation.valueQuantity` | `MEASUREMENT` · `measurement_concept_id` | `2000000022` — Measured AUC for [drug] | PROTECT-CHILD |
| `start_date` | `MedicationStatement.effectivePeriod.start` | `DRUG_EXPOSURE` · `drug_exposure_start_date` | — | — |
| `end_date` | `MedicationStatement.effectivePeriod.end` | `DRUG_EXPOSURE` · `drug_exposure_end_date` | — | — |
| `unit` | `MedicationStatement.dosage.doseAndRate.doseQuantity.code` | `OBSERVATION` · `unit_concept_id` | `9562` — milligram per kilogram | UCUM |
|  |  |  | `9563` — milligram per square meter | UCUM |
|  |  |  | `8576` — milligram | UCUM |

## Laboratory

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `name` | `ObservationDefinition.code` | `MEASUREMENT` · `measurement_concept_id` | `3016723` — Creatinine [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3020564` — Creatinine [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3024561` — Albumin [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3034485` — Albumin/Creatinine [Mass Ratio] in Urine | LOINC |
|  |  |  | `46236949` — Alanine aminotransferase [Enzymatic activity/volume] in Serum, Plasma or Blood | LOINC |
|  |  |  | `3023183` — Ammonium ion [Moles/volume] in Plasma | LOINC |
|  |  |  | `3022592` — Ammonium ion [Moles/volume] in Arterial blood | LOINC |
|  |  |  | `3013721` — Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma | LOINC |
|  |  |  | `3026217` — Bile acid [Mass/volume] in Serum | LOINC |
|  |  |  | `3028110` — Bile acid [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3006916` — Magnesium [Mass/volume] in Blood | LOINC |
|  |  |  | `3033836` — Magnesium [Moles/volume] in Blood | LOINC |
|  |  |  | `3010421` — pH of Blood | LOINC |
|  |  |  | `3024232` — Phosphate [Mass/volume] in Blood | LOINC |
|  |  |  | `3018913` — Phosphate [Moles/volume] in Blood | LOINC |
|  |  |  | `3000620` — Complement C3 [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3017766` — Complement C4 [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3032503` — Calcium [Mass/volume] in Blood | LOINC |
|  |  |  | `3005162` — Calcium [Moles/volume] in Blood | LOINC |
|  |  |  | `3019900` — Cholesterol [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3027114` — Cholesterol [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3015185` — Cholinesterase [Enzymatic activity/volume] in Blood | LOINC |
|  |  |  | `3022907` — Direct antiglobulin test.polyspecific reagent [Presence] on Red Blood Cells | LOINC |
|  |  |  | `3029719` — Indirect antiglobulin test.unspecified reagent [Presence] in Serum or Plasma | LOINC |
|  |  |  | `46236952` — Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (MDRD)/1.73 sq M | LOINC |
|  |  |  | `3030366` — Cystatin C [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3027597` — Bilirubin.direct [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3028638` — Bilirubin.direct [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3037110` — Fasting glucose [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3018251` — Fasting glucose [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `36304157` — Cystatin C and Glomerular filtration rate by Cystatin C-based formula panel - Serum or Plasma | LOINC |
|  |  |  | `3026910` — Gamma glutamyl transferase [Enzymatic activity/volume] in Serum or Plasma | LOINC |
|  |  |  | `3004501` — Glucose [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3013826` — Glucose [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3012336` — Haptoglobin [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3034639` — Hemoglobin A1c [Mass/volume] in Blood | LOINC |
|  |  |  | `3004410` — Hemoglobin A1c/Hemoglobin.total in Blood | LOINC |
|  |  |  | `3006576` — Bicarbonate [Moles/volume] in Blood | LOINC |
|  |  |  | `3023314` — Hematocrit [Volume Fraction] of Blood by Automated count | LOINC |
|  |  |  | `3000963` — Hemoglobin [Mass/volume] in Blood | LOINC |
|  |  |  | `3007164` — IgA [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3005719` — IgG [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3028026` — IgM [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3007242` — Bilirubin.indirect [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3007359` — Bilirubin.indirect [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3022217` — INR in Platelet poor plasma by Coagulation assay | LOINC |
|  |  |  | `40762125` — Lactate [Mass/volume] in Blood | LOINC |
|  |  |  | `3047181` — Lactate [Moles/volume] in Blood | LOINC |
|  |  |  | `3016436` — Lactate dehydrogenase [Enzymatic activity/volume] in Serum or Plasma | LOINC |
|  |  |  | `3018095` — Leukocytes [#/volume] in Blood | LOINC |
|  |  |  | `4234268` — ANA measurement | SNOMED |
|  |  |  | `4179789` — Smooth muscle antibody measurement | SNOMED |
|  |  |  | `4015457` — Antibody to mitochondria measurement | SNOMED |
|  |  |  | `37170564` — LKM 1 (liver-kidney microsomal 1) antibody arbitrary concentration in serum | SNOMED |
|  |  |  | `44790054` — Anti liver cytosol type 1 antibody level | SNOMED |
|  |  |  | `44790056` — Anti soluble liver antigen/liver-pancreas antibody level | SNOMED |
|  |  |  | `2000000049` — Anti-gp210 antibody level | PROTECT-CHILD |
|  |  |  | `2000000050` — Anti-sp100 antibody level | PROTECT-CHILD |
|  |  |  | `4189395` — Perinuclear neutrophil cytoplasmic antibody level | SNOMED |
|  |  |  | `3019198` — Lymphocytes [#/volume] in Blood | LOINC |
|  |  |  | `37399254` — Percentage lymphocytes | SNOMED |
|  |  |  | `3017732` — Neutrophils [#/volume] in Blood | LOINC |
|  |  |  | `37398605` — Percentage neutrophils | SNOMED |
|  |  |  | `3007090` — Glucose tolerance [Interpretation] in Serum or Plasma | LOINC |
|  |  |  | `3007461` — Platelets [#/volume] in Blood | LOINC |
|  |  |  | `3005456` — Potassium [Moles/volume] in Blood | LOINC |
|  |  |  | `21490733` — Potassium [Mass/volume] in Blood | LOINC |
|  |  |  | `3045462` — Protein/Creatinine [Ratio] in Urine | LOINC |
|  |  |  | `3034426` — Prothrombin time (PT) | LOINC |
|  |  |  | `4141751` — Parathyroid hormone measurement | SNOMED |
|  |  |  | `37170628` — Total protein mass concentration in urine | SNOMED |
|  |  |  | `3026361` — Erythrocytes [#/volume] in Blood | LOINC |
|  |  |  | `37208985` — Schistocyte count in blood by automated count | SNOMED |
|  |  |  | `3016293` — Bicarbonate [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3019550` — Sodium [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3000285` — Sodium [Moles/volume] in Blood | LOINC |
|  |  |  | `3028833` — Bilirubin.total [Mass/volume] in Blood | LOINC |
|  |  |  | `40757494` — Bilirubin.total [Moles/volume] in Blood | LOINC |
|  |  |  | `4119650` — Total protein measurement | SNOMED |
|  |  |  | `3022038` — Triglyceride [Mass/volume] in Blood | LOINC |
|  |  |  | `42868692` — Triglyceride [Moles/volume] in Blood | LOINC |
|  |  |  | `1469591` — Tubular cells [#/volume] in Urine sediment | LOINC |
|  |  |  | `3034204` — Urea [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3020779` — Urea [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3037556` — Urate [Mass/volume] in Serum or Plasma | LOINC |
|  |  |  | `3026493` — Urate [Moles/volume] in Serum or Plasma | LOINC |
|  |  |  | `3006661` — Calcium [Mass/volume] in Urine | LOINC |
|  |  |  | `3018133` — Calcium [Moles/volume] in Urine | LOINC |
|  |  |  | `3007733` — Chloride [Moles/volume] in Urine | LOINC |
|  |  |  | `3017250` — Creatinine [Mass/volume] in Urine | LOINC |
|  |  |  | `3009508` — Creatinine [Moles/volume] in Urine | LOINC |
|  |  |  | `3026729` — Phosphate [Mass/volume] in Urine | LOINC |
|  |  |  | `3022229` — Phosphate [Moles/volume] in Urine | LOINC |
|  |  |  | `3016038` — Potassium [Moles/volume] in Urine | LOINC |
|  |  |  | `3002582` — Erythrocytes [#/volume] in Urine | LOINC |
|  |  |  | `3003181` — Sodium [Moles/volume] in Urine | LOINC |
|  |  |  | `4308739` — Vitamin D measurement | SNOMED |
| `visit_id` | `Observation.encounter` | `MEASUREMENT` · `visit_occurrence_id` | — | — |
| `date` | `Observation.effectiveDateTime` | `MEASUREMENT` · `measurement_date` | — | — |
| `unit` | `Observation.valueQuantity.code` | `MEASUREMENT` · `unit_concept_id` | `8840` — milligram per deciliter | UCUM |
|  |  |  | `8749` — micromole per liter | UCUM |
|  |  |  | `720870` — milliliter per minute per 1.73 square meter | UCUM |
|  |  |  | `8751` — milligram per liter | UCUM |
|  |  |  | `9490` — equivalent per liter | UCUM |
|  |  |  | `8753` — millimole per liter | UCUM |
|  |  |  | `8725` — nanogram per liter | UCUM |
|  |  |  | `8736` — nanomole per liter | UCUM |
|  |  |  | `8645` — unit per liter | UCUM |
|  |  |  | `8554` — percent | UCUM |
|  |  |  | `8636` — gram per liter | UCUM |
|  |  |  | `8523` — ratio | UCUM |
|  |  |  | `8713` — gram per deciliter | UCUM |
|  |  |  | `8734` — trillion per liter | UCUM |
|  |  |  | `9442` — million per liter | UCUM |
|  |  |  | `8810` — kilounit per liter | UCUM |
|  |  |  | `8555` — second | UCUM |
|  |  |  | `8784` — cells per microliter | UCUM |
|  |  |  | `8909` — milligram per 24 hours | UCUM |
|  |  |  | `9565` — milligram per milligram | UCUM |
|  |  |  | `44777612` — milligram per millimole | UCUM |
|  |  |  | `8723` — milligram per gram | UCUM |
| `value` | `Observation.valueQuantity.value` | `MEASUREMENT` · `value_as_number` | — | — |

## Clinical Event Type

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `name` | `CodeSystem-clinical-event-type-cs` concept `display` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `2000000029` — Alloimmunization | PROTECT-CHILD |
|  |  |  | `4043343` — Disorder of bile duct | SNOMED |
|  |  |  | `37017585` — BK virus nephropathy | SNOMED |
|  |  |  | `4340390` — Chronic hepatic failure | SNOMED |
|  |  |  | `4198610` — Chronic rejection of liver transplant | SNOMED |
|  |  |  | `198185` — Chronic renal failure | SNOMED |
|  |  |  | `440032` — Cytomegalovirus infection | SNOMED |
|  |  |  | `4138908` — Delayed renal graft function | SNOMED |
|  |  |  | `201820` — Diabetes mellitus | SNOMED |
|  |  |  | `4151240` — Transplanted organ failure | SNOMED |
|  |  |  | `316866` — Hypertensive disorder | SNOMED |
|  |  |  | `4128369` — Renal transplant rejection | SNOMED |
|  |  |  | `2000000023` — Liver early allograft dysfunction | PROTECT-CHILD |
|  |  |  | `4326594` — Abnormal liver function | SNOMED |
|  |  |  | `4341657` — Liver transplant rejection | SNOMED |
|  |  |  | `321876` — Disorder of capillaries | SNOMED |
|  |  |  | `2000000015` — mTOR inhibitors poisoning | PROTECT-CHILD |
|  |  |  | `2000000014` — Mycophenolate poisoning | PROTECT-CHILD |
|  |  |  | `42872891` — Posterior reversible encephalopathy syndrome | SNOMED |
|  |  |  | `435514` — Lymphoproliferative disorder following transplantation | SNOMED |
|  |  |  | `2000000024` — Relapse of primary immunomediated disease | PROTECT-CHILD |
|  |  |  | `45765696` — Calcineurin inhibitor poisoning | SNOMED |
|  |  |  | `44809014` — Urological complication of renal transplant | SNOMED |
|  |  |  | `197444` — Vascular complication of medical care | SNOMED |
|  |  | `OBSERVATION` · `observation_concept_id` | `4192056` — Abnormal renal function | SNOMED |
|  |  |  | `4306655` — Death | SNOMED |

## Clinical Event

| DM field | FHIR element | OMOP table · field | OMOP concept | Vocabulary |
|---|---|---|---|---|
| `visit_id` | `Condition.encounter` | `VISIT_OCCURRENCE` · `visit_occurrence_id` | — | — |
| `dgf` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `2000000032` — Delayed graft function | PROTECT-CHILD |
| `vascular_complication_type` | `Condition.evidence.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `4223098` — Hepatic artery thrombosis | SNOMED |
|  |  |  | `317003` — Compression of vein | SNOMED |
|  |  |  | `199837` — Portal vein thrombosis | SNOMED |
| `episodes_aki_after_ltx` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `197320` — Acute kidney injury | SNOMED |
| `histologic_evidence_cni_toxicity` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `2000000035` — Histological evidence of CNI toxicity | PROTECT-CHILD |
| `hypoxic_ischemic_event_pltx` | `Condition.code` | `CONDITION_OCCURRENCE` · `condition_concept_id` | `2000000026` — Hypoxic ischemic event | PROTECT-CHILD |
| `dialysis_type` | `Procedure.code` | `PROCEDURE_OCCURRENCE` · `procedure_concept_id` | `4120120` — Hemodialysis | SNOMED |
|  |  |  | `4324124` — Peritoneal dialysis | SNOMED |
| `dialysis_start_date` | `Procedure.performedPeriod.start` | `PROCEDURE_OCCURRENCE` · `procedure_date` | — | — |
| `dialysis_end_date` | `Procedure.performedPeriod.end` | `PROCEDURE_OCCURRENCE` · `procedure_end_date` | — | — |
| `cause_death` | `Condition.note[cause_death].text` | `DEATH` · `cause_concept_id` | — | — |
| `retransplantation_date` | `Procedure.performedDateTime` | `PROCEDURE_OCCURRENCE` · `procedure_date` | — | — |
| `treatment_adherence` | `ClinicalEventFlagObservation.code` | `OBSERVATION` · `observation_concept_id` | `36031908` — Adherence to treatment | LOINC |
|  |  | `OBSERVATION` · `value_as_concept_id` | `36032717` — Adherent to treatment | LOINC |
|  |  |  | `36032471` — Not adherent to treatment | LOINC |
| `date_entry_transplant_list` | `Procedure.performedDateTime` | `OBSERVATION` · `observation_concept_id` | `43020581` — On waiting list for organ transplant | — |
|  |  | `OBSERVATION` · `observation_date` | — | — |

Across all entities, **156** data-model variables have a completed OMOP mapping, listed as **519** rows referencing **361** standard concepts and **39** custom PROTECT-CHILD concepts (plus structural/foreign-key fields).
