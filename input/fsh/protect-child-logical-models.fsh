// ============================================================================
// PROTECT-CHILD Logical Models
// Canonical base: https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child
// ============================================================================
// NOTE: Logical models do not use MustSupport (MS). Requiredness is
// represented with cardinalities only (1..1 = M, 0..1 = R/O).

Alias: $pc = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child

// ─── Patient ────────────────────────────────────────────────────────────────

Logical: PcPatient
Id: pcPatientLm
Title: "Patient logical model"
Description: "Logical model for the PROTECT-CHILD patient table."

* patientId 1..1 string "patient_id" "Patient ID."
* gender 1..1 code "gender" "Patient sex at birth."
* ageYears 0..1 integer "age_years" "Patient age in years."
* ageMonths 0..1 integer "age_months" "Patient age in months (sub-year precision)."
* maxPra 0..1 integer "max_pra" "Maximum historical pre-transplant PRA/cPRA (0-100%)."
* lastPra 0..1 integer "last_pra" "Most recent pre-transplant PRA/cPRA (0-100%)."
* dateHistologicalDiag 1..1 date "date_histological_diag" "Date histology confirmed the primary disease."
* dateDiagPrimaryDisease 1..1 date "date_diag_primary_disease" "Date primary disease was first diagnosed."
* diagPrimaryDisease 1..1 string "diag_primary_disease" "Primary diagnosis leading to transplant."
* centerNo 1..1 code "center_no" "Study centre (1=La Paz, 2=Padova, 3=Palma, 4=Hamburg)."

// ─── Donor ──────────────────────────────────────────────────────────────────

Logical: PcDonor
Id: pcDonorLm
Title: "Donor logical model"
Description: "Logical model for the PROTECT-CHILD donor table."

* donorId 1..1 string "donor_id" "Donor ID."
* ageYears 1..1 integer "age_years" "Donor age in years at donation."
* ageMonths 1..1 integer "age_months" "Donor age in months."
* type 1..1 code "type" "Alive or Deceased donor."
* liverType 0..1 code "liver_type" "Whole or Split liver graft (Liver only)."

// ─── Visit ──────────────────────────────────────────────────────────────────

Logical: PcVisit
Id: pcVisitLm
Title: "Visit logical model"
Description: "Logical model for the PROTECT-CHILD visit table."

* visitId 1..1 string "visit_id" "Visit ID."
* patientId 1..1 string "patient_id" "FK to patient."
* date 1..1 date "date" "Date of the visit."
* visitType 1..1 code "visit_type" "Type of visit (Pre-transplant, 1m, 3m, 6m, 12m, 24m, Clinical Event, Termination)."

// ─── Transplant ─────────────────────────────────────────────────────────────

Logical: PcTransplant
Id: pcTransplantLm
Title: "Transplant logical model"
Description: "Logical model for the PROTECT-CHILD transplant table."

* transplantId 1..1 string "transplant_id" "Transplant ID."
* visitId 1..1 string "visit_id" "FK to visit."
* donorId 1..1 string "donor_id" "FK to donor."
* dRWeightRatio 0..1 decimal "d_r_weight_ratio" "Donor/recipient weight ratio."
* vesselMismatchDR 0..1 boolean "vessel_mismatch_d_r" "Vessel mismatch donor/recipient."
* coldIschemiaTime 0..1 integer "cold_ischemia_time" "Cold ischemia time (minutes)."
* warmIschemiaTime 0..1 integer "warm_ischemia_time" "Warm ischemia time (minutes)."
* txType 1..1 code "tx_type" "Transplant type: Liver, Kidney, or Combined."
* dateTx 1..1 date "date_tx" "Date of transplant surgery."
* timeDiagToTx 1..1 decimal "time_diag_to_tx" "Months from diagnosis to transplant (calculated)."
* vascularAnomalies 0..1 string "vascular_anomalies" "Vascular anomalies (free text)."
* typeSurgicalBiliaryAnastomosis 0..1 code "type_surgical_biliary_anastomosis" "Biliary anastomosis type (Liver)."
* intraoperativeComplications 0..1 code "intraoperative_complications" "Intraoperative complications."
* intraoperativeComplicationsOther 0..1 string "intraoperative_complications_other" "Other complications (free text, Liver)."
* typeUreteralGraftAnastomosis 0..1 code "type_ureteral_graft_anastomosis" "Ureteral graft anastomosis type (Optional)."
* otherTypeUreteralGraftAnastomosis 0..1 string "other_type_ureteral_graft_anastomosis" "Other ureteral anastomosis type (free text)."

// ─── Immunological Data ─────────────────────────────────────────────────────

Logical: PcImmunologicalData
Id: pcImmunologicalDataLm
Title: "Immunological Data logical model"
Description: "Logical model for the PROTECT-CHILD immunological_data table. Covers blood group, Rh, HLA allele typing, DSA, Banff category, C4d, and ANCA."

* immunologicalDataId 1..1 string "immunological_data_id" "Immunological data record ID."
* visitId 1..1 string "visit_id" "FK to visit (Mandatory)."
* donorId 0..1 string "donor_id" "FK to donor (Optional — for donor-side typing)."
* bloodGroup 0..1 code "blood_group" "ABO blood group (A/B/AB/0)."
* rhFactor 0..1 code "rh_factor" "Rh factor (Positive/Negative)."
// HLA alleles use IMGT/HLA string notation (e.g. "A*02:01"), not numeric codes.
// The DMv1.2 source column type is listed as Integer (0-99) but IMGT/HLA notation
// is the interoperability standard and is used in the FHIR profile.
* hlaA1 0..1 string "hla_a_1" "HLA-A allele 1 (IMGT/HLA notation, e.g. 'A*02:01')."
* hlaA2 0..1 string "hla_a_2" "HLA-A allele 2 (IMGT/HLA notation)."
* hlaB1 0..1 string "hla_b_1" "HLA-B allele 1 (IMGT/HLA notation)."
* hlaB2 0..1 string "hla_b_2" "HLA-B allele 2 (IMGT/HLA notation)."
* hlaC1 0..1 string "hla_c_1" "HLA-C allele 1 (IMGT/HLA notation)."
* hlaC2 0..1 string "hla_c_2" "HLA-C allele 2 (IMGT/HLA notation)."
* hlaDrb11 0..1 string "hla_drb1_1" "HLA-DRB1 allele 1 (IMGT/HLA notation)."
* hlaDrb12 0..1 string "hla_drb1_2" "HLA-DRB1 allele 2 (IMGT/HLA notation)."
* hlaDp1 0..1 string "hla_dp_1" "HLA-DP allele 1 (IMGT/HLA notation)."
* hlaDp2 0..1 string "hla_dp_2" "HLA-DP allele 2 (IMGT/HLA notation)."
* hlaDqb11 0..1 string "hla_dqb1_1" "HLA-DQB1 allele 1 (IMGT/HLA notation)."
* hlaDqb12 0..1 string "hla_dqb1_2" "HLA-DQB1 allele 2 (IMGT/HLA notation)."
* postTransplantAbAntiHlaDsaClass 0..1 code "post_transplant_ab_anti_hla_dsa_class" "Post-transplant DSA HLA class (I/II)."
// Note: DMv1.2 spreadsheet has a typo "pre_trasnplant_anti_hla_dsa" — corrected here.
* preTransplantAntiHlaDsa 0..1 string "pre_transplant_anti_hla_dsa" "Pre-transplant anti-HLA DSA (free text)."
* mfi 0..1 code "mfi" "MFI category (WR/MR/SR)."
* banffCategory 0..1 code "banff_category" "Banff rejection category (1-5)."
* ihcIfC4d 0..1 boolean "ihc_if_c4d" "IHC/IF C4d result."
* ifResult 0..1 string "if" "IF result (free text)."
* c4dResult 0..1 string "c4d" "C4d result (free text)."
* anca 0..1 boolean "anca" "ANCA result."
* antibodyType 0..1 string "antibody_type" "Antibody type specification (free text)."
* antiHlaAntibodies 0..1 boolean "anti_hla_antibodies" "Presence of anti-HLA antibodies (Optional)."

// ─── Vital Sign ─────────────────────────────────────────────────────────────

Logical: PcVitalSign
Id: pcVitalSignLm
Title: "Vital Sign logical model"
Description: "Logical model for the PROTECT-CHILD vital_sign table. Contains standard vitals and ABPM measurements."

* vitalSignId 1..1 string "vital_sign_id" "Vital sign record ID."
* visitId 1..1 string "visit_id" "FK to visit."
* date 1..1 date "date" "Date vitals were measured."
* systolicBloodPressure 0..1 integer "systolic_blood_pressure" "Systolic BP (mmHg)."
* diastolicBloodPressure 0..1 integer "diastolic_blood_pressure" "Diastolic BP (mmHg)."
* heartRate 0..1 integer "heart_rate" "Heart rate (bpm)."
* oxygenSaturation 0..1 integer "oxygen_saturation" "O2 saturation at rest (%)."
* temperature 0..1 decimal "temperature" "Body temperature (°C)."
* bmi 0..1 decimal "bmi" "Body mass index."
* sbpPercentile 0..1 integer "sbp_percentile" "Systolic BP percentile."
* dbpPercentile 0..1 integer "dbp_percentile" "Diastolic BP percentile."
* meanSbp24 0..1 integer "mean_sbp_24" "Mean 24h systolic BP (mmHg)."
* meanDbp24 0..1 integer "mean_dbp_24" "Mean 24h diastolic BP (mmHg)."
* meanSbpDay 0..1 integer "mean_sbp_day" "Mean daytime systolic BP (mmHg)."
* meanDbpDay 0..1 integer "mean_dbp_day" "Mean daytime diastolic BP (mmHg)."
* meanSbpNight 0..1 integer "mean_sbp_night" "Mean night-time systolic BP (mmHg)."
* meanDbpNight 0..1 integer "mean_dbp_night" "Mean night-time diastolic BP (mmHg)."
* sbpLoad 0..1 integer "sbp_load" "Systolic BP load (%)."
* dbpLoad 0..1 integer "dbp_load" "Diastolic BP load (%)."
* sbpDip 0..1 integer "sbp_dip" "Systolic BP nocturnal dip (%)."
* dbpDip 0..1 integer "dbp_dip" "Diastolic BP nocturnal dip (%)."

// ─── BioSample ──────────────────────────────────────────────────────────────

Logical: PcBioSample
Id: pcBioSampleLm
Title: "BioSample logical model"
Description: "Logical model for the PROTECT-CHILD bio_sample table."

* bioSampleId 1..1 string "bio_sample_id" "Bio sample ID."
* visitId 1..1 string "visit_id" "FK to visit."
* collectionDate 0..1 date "collection_date" "Sample collection date."
* sendIngemmDate 0..1 date "send_ingemm_date" "Date sample sent to INGEMM."
* genomicSample 0..1 boolean "genomic_sample" "Sample used for genomic analysis."
* epigenomicSample 0..1 boolean "epigenomic_sample" "Sample used for epigenomic analysis."

// ─── Pre-Medication ─────────────────────────────────────────────────────────

Logical: PcPreMedication
Id: pcPreMedicationLm
Title: "PreMedication logical model"
Description: "Logical model for the PROTECT-CHILD pre_medication table."

* preMedicationId 1..1 string "pre_medication_id" "Pre-medication record ID."
* visitId 1..1 string "visit_id" "FK to visit."
* antihypertensiveTreatment 0..1 code "antihypertensive_treatment" "Antihypertensive drug used."
* rituximab 0..1 boolean "rituximab" "Rituximab given pre-transplant."
* dateLastRituximab 0..1 date "date_last_rituximab" "Date of last Rituximab dose."
* otherMedications 0..1 string "other_medications" "Other pre-transplant medications (free text)."
* antiviralProphylaxis 0..1 boolean "antiviral_prophylaxis" "Antiviral prophylaxis given."

// ─── Clinical Variable ───────────────────────────────────────────────────────

Logical: PcClinicalVariable
Id: pcClinicalVariableLm
Title: "ClinicalVariable logical model"
Description: "Logical model for the PROTECT-CHILD clinical_variable table. Includes weight, height, diuresis, and concomitant disease."

* clinicalVariableId 1..1 string "clinical_variable_id" "Clinical variable record ID."
* visitId 1..1 string "visit_id" "FK to visit."
* weight 0..1 decimal "weight" "Patient weight (kg)."
* height 0..1 decimal "height" "Patient height (cm)."
* concomitantDisease 1..1 code "concomitant_disease" "Concomitant disease code (repeatable per concurrent disease)."
* description 0..1 string "description" "Free-text description of concomitant episode."
* diuresisValue 0..1 decimal "diuresis_value" "Diuresis value (ml/day)."
* otherSymptoms 0..1 string "other_symptoms" "Other symptoms (free text)."
* otherConcomitant 0..1 string "other_concomitant" "Other concomitant diseases (free text)."
* organDysfunction 0..1 string "organ_dysfunction" "Organ dysfunction specification (free text)."

// ─── Concomitant Medication ──────────────────────────────────────────────────

Logical: PcConcomitantMedication
Id: pcConcomitantMedicationLm
Title: "ConcomitantMedication logical model"
Description: "Logical model for the PROTECT-CHILD concomitant_medication table."

* concomitantMedicationId 1..1 string "concomitant_medication_id" "Record ID."
* visitId 1..1 string "visit_id" "FK to visit."
* medicationName 0..1 string "medication_name" "Medication name (free text)."
* dose 0..1 decimal "dose" "Medication dose."
* startDate 0..1 date "start_date" "Date medication started."
* status 0..1 code "status" "Treatment status: End or Ongoing."
* endDate 0..1 date "end_date" "Date medication ended."

// ─── Microbiology ────────────────────────────────────────────────────────────

Logical: PcMicrobiology
Id: pcMicrobiologyLm
Title: "Microbiology logical model"
Description: "Logical model for the PROTECT-CHILD microbiology table. Covers viral serology, DNA quantification, culture results, and BKVAN evidence."

* microbiologyId 1..1 string "microbiology_id" "Microbiology record ID."
* visitId 1..1 string "visit_id" "FK to visit (Mandatory)."
* donorId 0..1 string "donor_id" "FK to donor (Optional)."
* ebvDna 0..1 boolean "ebv_dna" "EBV-DNA result."
* ebvDnaCopies 0..1 decimal "ebv_dna_copies" "EBV-DNA copies/ml."
* ebvIgmAntiEa 0..1 boolean "ebv_igm_anti_ea" "EBV IgM anti-EA."
* ebvIgmAntiVca 0..1 boolean "ebv_igm_anti_vca" "EBV IgM anti-VCA."
* ebvIggAntiVca 0..1 boolean "ebv_igg_anti_vca" "EBV IgG anti-VCA."
* ebvIggEbna 0..1 boolean "ebv_igg_ebna" "EBV IgG EBNA."
* cmvDna 0..1 boolean "cmv_dna" "CMV-DNA result."
* cmvDnaCopies 0..1 decimal "cmv_dna_copies" "CMV-DNA copies/ml."
* cmvIgm 0..1 boolean "cmv_igm" "CMV IgM."
* cmvIgg 0..1 boolean "cmv_igg" "CMV IgG."
* parvovirusB19Dna 0..1 boolean "parvovirus_b19_dna" "Parvovirus B19 DNA."
* parvovirusB19DnaCopies 0..1 decimal "parvovirus_b19_dna_copies" "Parvovirus B19 DNA copies/ml."
* parvovirusB19Igg 0..1 boolean "parvovirus_b19_igg" "Parvovirus B19 IgG."
* parvovirusB19Igm 0..1 boolean "parvovirus_b19_igm" "Parvovirus B19 IgM."
* hsvIgg 0..1 boolean "hsv_igg" "HSV IgG."
* hsvIgm 0..1 boolean "hsv_igm" "HSV IgM."
* adenovirusIgg 0..1 boolean "adenovirus_igg" "Adenovirus IgG."
* adenovirusIgm 0..1 boolean "adenovirus_igm" "Adenovirus IgM."
* bloodAdenovirusDna 0..1 boolean "blood_adenovirus_dna" "Blood Adenovirus DNA."
* bloodAdenovirusDnaCopies 0..1 decimal "blood_adenovirus_dna_copies" "Blood Adenovirus DNA copies/ml."
* vzvIgg 0..1 boolean "vzv_igg" "VZV IgG."
* vzvIgm 0..1 boolean "vzv_igm" "VZV IgM."
* bloodBkvDna 0..1 boolean "blood_bkv_dna" "Blood BKV-DNA."
* bloodBkvDnaCopies 0..1 decimal "blood_bkv_dna_copies" "Blood BKV-DNA copies/ml."
* urineBkvDna 0..1 boolean "urine_bkv_dna" "Urine BKV-DNA."
* bkvDnaKidneyBiopsy 0..1 boolean "bkv_dna_kidney_biopsy" "BKV-DNA on kidney biopsy (Kidney)."
* bkvFishKidneyBiopsy 0..1 boolean "bkv_fish_kidney_biopsy" "BKV FISH on kidney biopsy (Kidney)."
* bloodColture 0..1 boolean "blood_colture" "Blood culture (Kidney)."
* urineColture 0..1 boolean "urine_colture" "Urine culture (Kidney)."
* otherPositivity 0..1 string "other_positivity" "Other positivity (free text, Kidney)."
* ebvHepatitisLiver 0..1 boolean "ebv_hepatitis_liver" "EBV hepatitis on liver (Liver)."
* evidenceBkvan 0..1 code "evidence_bkvan" "Histological evidence of BKVAN (No/Yes/Unknown)."

// ─── Instrumental Investigation ──────────────────────────────────────────────

Logical: PcInstrumentalInvestigation
Id: pcInstrumentalInvestigationLm
Title: "InstrumentalInvestigation logical model"
Description: "Logical model for the PROTECT-CHILD instrumental_investigation table."

* instInvId 1..1 string "inst_inv_id" "Record ID (renamed from pat_inst_inv_id)."
* visitId 1..1 string "visit_id" "FK to visit."
* instrumentalInvestigation 1..1 code "instrumental_investigation" "Investigation type."
* date 0..1 date "date" "Date investigation performed."
* result 0..1 code "result" "Result: Normal or Abnormal."
* abnormality 0..1 string "abnormality" "Abnormality description (free text)."
* otherInvestigation 0..1 string "other_investigation" "Other investigation (free text)."

// ─── Immunosuppressant ───────────────────────────────────────────────────────

Logical: PcImmunosuppressant
Id: pcImmunosuppressantLm
Title: "Immunosuppressant logical model"
Description: "Logical model for the PROTECT-CHILD immunosuppressant catalogue table."

* immId 1..1 string "imm_id" "Immunosuppressant ID."
* name 1..1 code "name" "Drug name."

// ─── Imm Pat (merged induction + maintenance) ────────────────────────────────

Logical: PcImmPat
Id: pcImmPatLm
Title: "ImmPat logical model"
Description: "Logical model for the PROTECT-CHILD imm_pat table. Phase field (Induction / Maintenance) maps to MedicationStatement.category."

* immPatId 1..1 string "imm_pat_id" "Record ID."
* immId 1..1 string "imm_id" "FK to immunosuppressant."
* visitId 1..1 string "visit_id" "FK to visit."
* phase 1..1 code "phase" "Induction or Maintenance."
* dose 0..1 decimal "dose" "Dose."
* preDoseLevel 0..1 decimal "pre_dose_level" "Trough drug level (C0)."
* csa2hPostDoseLevel 0..1 string "csa_2h_post_dose_level" "CsA 2h post-dose level (C2)."
* auc 0..1 decimal "auc" "Pharmacokinetic AUC."
* startDate 0..1 date "start_date" "Treatment start date."
* endDate 0..1 date "end_date" "Treatment end date."
* unit 0..1 code "unit" "Dose unit (mg/kg, mg/m², mg, mg/mq)."

// ─── Lab Test ────────────────────────────────────────────────────────────────

Logical: PcLabTest
Id: pcLabTestLm
Title: "LabTest logical model"
Description: "Logical model for the PROTECT-CHILD lab_test catalogue table."

* labTestId 1..1 string "lab_test_id" "Lab test ID."
* name 1..1 code "name" "Lab test name."

// ─── Lab Result ──────────────────────────────────────────────────────────────

Logical: PcLabResult
Id: pcLabResultLm
Title: "LabResult logical model"
Description: "Logical model for the PROTECT-CHILD lab_result table."

* labResultId 1..1 string "lab_result_id" "Lab result ID."
* labTestId 1..1 string "lab_test_id" "FK to lab_test."
* visitId 1..1 string "visit_id" "FK to visit."
* date 1..1 date "date" "Date of the lab test."
* unit 1..1 code "unit" "Unit of measurement."
* value 0..1 decimal "value" "Numeric result."
* gfrFormula 0..1 string "gfr_formula" "Formula used to estimate GFR (free text)."
* gfrCystFormula 0..1 string "gfr_cyst_formula" "Formula used to estimate GFR-Cystatin (free text)."

// ─── Clinical Event Type ────────────────────────────────────────────────────

Logical: PcClinicalEventType
Id: pcClinicalEventTypeLm
Title: "ClinicalEventType logical model"
Description: "Logical model for the PROTECT-CHILD clinical_event_type table."

* clinicalEventTypeId 1..1 string "clinical_event_type_id" "Clinical event type ID."
* name 1..1 code "name" "Clinical event type name (26-value code list)."

// ─── Clinical Event ──────────────────────────────────────────────────────────

Logical: PcClinicalEvent
Id: pcClinicalEventLm
Title: "ClinicalEvent logical model"
Description: "Logical model for the PROTECT-CHILD clinical_event table. Each visit record captures either the start or end of a clinical event."

* clinicalEventId 1..1 string "clinical_event_id" "Clinical event ID."
* clinicalEventTypeId 1..1 string "clinical_event_type_id" "FK to clinical_event_type."
* visitId 1..1 string "visit_id" "FK to visit (One-to-One relationship)."
* eventPhase 0..1 code "event_phase" "START or END of the event. Mapped to Condition.onsetDateTime (START) or Condition.abatementDateTime (END) + clinicalStatus."
* eventNumber 0..1 integer "event_number" "Auto-incremental event number per patient (calculated)."
* specifyKidneyRejectionEpisode 0..1 string "specify_kidney_rejection_episode" "Kidney rejection episode specification (Optional)."
* dgf 0..1 boolean "dgf" "Delayed graft function (Optional)."
* previousUrologicalIntervention 0..1 string "previous_urological_intervention" "Previous urological intervention (Optional)."
* vascularComplicationType 0..1 code "vascular_complication_type" "Vascular complication type (Optional)."
* episodesAkiAfterLtx 0..1 boolean "episodes_aki_after_ltx" "Episodes of AKI after LTx (Optional)."
* histologicEvidenceCniToxicity 0..1 boolean "histologic_evidence_cni_toxicity" "Histologic evidence of CNI toxicity (Optional)."
* hypoxicIschemicEventPltx 0..1 boolean "hypoxic_ischemic_event_pltx" "Hypoxic ischaemic events after pLTx (Optional)."
* dialysisType 0..1 code "dialysis_type" "Dialysis type (Optional)."
* dialysisStartDate 0..1 date "dialysis_start_date" "Dialysis start date (Optional)."
* dialysisEndDate 0..1 date "dialysis_end_date" "Dialysis end date (Optional)."
* causeDeath 0..1 string "cause_death" "Cause of death (Optional)."
* concomitantMedications 0..1 boolean "concomitant_medications" "Concomitant medications at event (Optional)."
* retransplantation 0..1 boolean "retransplantation" "Retransplantation status (Optional)."
* retransplantationDate 0..1 date "retransplantation_date" "Retransplantation date (Optional)."
* treatmentAdherence 0..1 boolean "treatment_adherence" "Treatment adherence (Optional)."
* dateEntryTransplantList 0..1 date "date_entry_transplant_list" "Date of entry in transplant list (Optional)."
* underlyingProthromboticDisorders 0..1 string "underlying_prothrombotic_disorders" "Underlying prothrombotic disorders (Optional)."
* kidneyBiopsy 0..1 string "kidney_biopsy" "Kidney biopsy (Optional)."
