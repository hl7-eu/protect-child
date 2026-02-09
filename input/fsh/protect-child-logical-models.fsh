// ============================================================================
// PROTECT-CHILD Logical Models
// Canonical base: https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child
// ============================================================================

Alias: $pc = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child

Logical: PcPatient
Id: pc-patient-lm
Title: "Patient logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `patient`."

* patientId 1..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model."
* gender 0..1 code "Gender" "Field `gender` from the PROTECT-CHILD data model."
* birthdate 0..1 date "Birthdate" "Field `birthdate` from the PROTECT-CHILD data model."
* currentAge 0..1 integer "Current age" "Field `current_age` from the PROTECT-CHILD data model."
* bloodGroup 0..1 code "Blood group" "Field `blood_group` from the PROTECT-CHILD data model."
* rhFactor 0..1 code "Rh factor" "Field `rh_factor` from the PROTECT-CHILD data model."
* maxPra 0..1 integer "Max pra" "Field `max_pra` from the PROTECT-CHILD data model."
* lastPra 0..1 integer "Last pra" "Field `last_pra` from the PROTECT-CHILD data model."
* allograftHlaClassIAb 0..1 code "Allograft hla class i ab" "Field `allograft_hla_class_i_ab` from the PROTECT-CHILD data model."
* allograftHlaClassIiAb 0..1 code "Allograft hla class ii ab" "Field `allograft_hla_class_ii_ab` from the PROTECT-CHILD data model."
* dateHistologicalDiag 0..1 dateTime "Date histological diag" "Field `date_histological_diag` from the PROTECT-CHILD data model."
* dateDiagLiverDisease 0..1 dateTime "Date diag liver disease" "Field `date_diag_liver_disease` from the PROTECT-CHILD data model."
* diagLiverDisease 0..1 code "Diag liver disease" "Field `diag_liver_disease` from the PROTECT-CHILD data model."
* diagLiverDiseaseExtra 0..1 string "Diag liver disease extra" "Field `diag_liver_disease_extra` from the PROTECT-CHILD data model."
* dateDiagRenalDisease 0..1 dateTime "Date diag renal disease" "Field `date_diag_renal_disease` from the PROTECT-CHILD data model."
* diagRenalDisease 0..1 code "Diag renal disease" "Field `diag_renal_disease` from the PROTECT-CHILD data model."
* diagRenalDiseaseExtra 0..1 string "Diag renal disease extra" "Field `diag_renal_disease_extra` from the PROTECT-CHILD data model."

Logical: PcDonor
Id: pc-donor-lm
Title: "Donor logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `donor`."

* donorId 1..1 string "Donor id" "Field `donor_id` from the PROTECT-CHILD data model."
* age 0..1 integer "Age" "Field `age` from the PROTECT-CHILD data model."
* type 0..1 code "Type" "Field `type` from the PROTECT-CHILD data model."
* liverType 0..1 code "Liver type" "Field `liver_type` from the PROTECT-CHILD data model."
* bloodGroup 0..1 code "Blood group" "Field `blood_group` from the PROTECT-CHILD data model."
* rhFactor 0..1 code "Rh factor" "Field `rh_factor` from the PROTECT-CHILD data model."
* preKtxDialysisType 0..1 code "Pre ktx dialysis type" "Field `pre_ktx_dialysis_type` from the PROTECT-CHILD data model."
* allograftHlaClassIAb 0..1 code "Allograft hla class i ab" "Field `allograft_hla_class_i_ab` from the PROTECT-CHILD data model."
* allograftHlaClassIiAb 0..1 code "Allograft hla class ii ab" "Field `allograft_hla_class_ii_ab` from the PROTECT-CHILD data model."

Logical: PcVisit
Id: pc-visit-lm
Title: "Visit logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `visit`."

* visitId 1..1 string "Visit id" "Field `visit_id` from the PROTECT-CHILD data model."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* transplantId 0..1 string "Transplant id" "Field `transplant_id` from the PROTECT-CHILD data model. Foreign key to `transplant`."
* bioSampleId 0..1 string "Bio sample id" "Field `bio_sample_id` from the PROTECT-CHILD data model. Foreign key to `bio_sample`."
* preMedicationId 0..1 string "Pre medication id" "Field `pre_medication_id` from the PROTECT-CHILD data model. Foreign key to `pre_medication`."
* clinicalVariableId 0..1 string "Clinical variable id" "Field `clinical_variable_id` from the PROTECT-CHILD data model. Foreign key to `clinical_variable`."
* concomitantEpisodeId 0..1 string "Concomitant episode id" "Field `concomitant_episode_id` from the PROTECT-CHILD data model. Foreign key to `concomitant_episode`."
* microbiologyId 0..1 string "Microbiology id" "Field `microbiology_id` from the PROTECT-CHILD data model. Foreign key to `microbiology`."
* patInstInvId 0..1 string "Pat inst inv id" "Field `pat_inst_inv_id` from the PROTECT-CHILD data model. Foreign key to `pat_inst_inv`."
* immIndPatId 0..1 string "Imm ind pat id" "Field `imm_ind_pat_id` from the PROTECT-CHILD data model. Foreign key to `imm_ind_pat`."
* immMainPatId 0..1 string "Imm main pat id" "Field `imm_main_pat_id` from the PROTECT-CHILD data model. Foreign key to `imm_main_pat`."
* labResultId 0..1 string "Lab result id" "Field `lab_result_id` from the PROTECT-CHILD data model. Foreign key to `lab_result`."
* postEventId 0..1 string "Post event id" "Field `post_event_id` from the PROTECT-CHILD data model. Foreign key to `post_event`."
* outcomeId 0..1 string "Outcome id" "Field `outcome_id` from the PROTECT-CHILD data model. Foreign key to `outcome`."
* date 0..1 dateTime "Date" "Field `date` from the PROTECT-CHILD data model."
* visitType 0..1 CodeableConcept "Visit type" "Field `visit_type` from the PROTECT-CHILD data model."

Logical: PcTransplant
Id: pc-transplant-lm
Title: "Transplant logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `transplant`."

* transplantId 1..1 string "Transplant id" "Field `transplant_id` from the PROTECT-CHILD data model."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* donorId 0..1 string "Donor id" "Field `donor_id` from the PROTECT-CHILD data model. Foreign key to `donor`."
* dRWeightRation 0..1 decimal "D r weight ration" "Field `d_r_weight_ration` from the PROTECT-CHILD data model."
* vesselMismatchDR 0..1 boolean "Vessel mismatch d r" "Field `vessel_mismatch_d_r` from the PROTECT-CHILD data model."
* coldIschemiaTime 0..1 integer "Cold ischemia time" "Field `cold_ischemia_time` from the PROTECT-CHILD data model."
* txType 0..1 code "Tx type" "Field `tx_type` from the PROTECT-CHILD data model."
* dateTx 0..1 dateTime "Date tx" "Field `date_tx` from the PROTECT-CHILD data model."
* timeDiagToTx 0..1 decimal "Time diag to tx" "Field `time_diag_to_tx` from the PROTECT-CHILD data model."
* WarmIschemiaTime1 0..1 integer "1 warm ischemia time" "Field `1_warm_ischemia_time` from the PROTECT-CHILD data model."
* WarmIschemiaTime2 0..1 integer "2 warm ischemia time" "Field `2_warm_ischemia_time` from the PROTECT-CHILD data model."
* vascularAnomalies 0..1 string "Vascular anomalies" "Field `vascular_anomalies` from the PROTECT-CHILD data model."
* typeSurgicalBiliaryAnastomosis 0..1 CodeableConcept "Type surgical biliary anastomosis" "Field `type_surgical_biliary_anastomosis` from the PROTECT-CHILD data model."
* intraoperativeComplications 0..1 CodeableConcept "Intraoperative complications" "Field `intraoperative_complications` from the PROTECT-CHILD data model."
* intraoperativeComplicationsOther 0..1 string "Intraoperative complications other" "Field `intraoperative_complications_other` from the PROTECT-CHILD data model."
* nephrectomyOriginalKidney 0..1 boolean "Nephrectomy original kidney" "Field `nephrectomy_original_kidney` from the PROTECT-CHILD data model."
* kidneySide 0..1 code "Kidney side" "Field `kidney_side` from the PROTECT-CHILD data model."

Logical: PcBioSample
Id: pc-bio-sample-lm
Title: "BioSample logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `bio_sample`."

* bioSampleId 1..1 string "Bio sample id" "Field `bio_sample_id` from the PROTECT-CHILD data model."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* genomicTestId 0..1 string "Genomic test id" "Field `genomic_test_id` from the PROTECT-CHILD data model."
* epigenomeStudyId 0..1 string "Epigenome study id" "Field `epigenome_study_id` from the PROTECT-CHILD data model."
* methylomicStudyId 0..1 string "Methylomic study id" "Field `methylomic_study_id` from the PROTECT-CHILD data model."
* collectionDate 0..1 dateTime "Collection date" "Field `collection_date` from the PROTECT-CHILD data model."
* sendIngemmDate 0..1 dateTime "Send ingemm date" "Field `send_ingemm_date` from the PROTECT-CHILD data model."
* tissueType 0..1 CodeableConcept "Tissue type" "Field `tissue_type` from the PROTECT-CHILD data model."
* dnaConcentration 0..1 decimal "Dna concentration" "Field `dna_concentration` from the PROTECT-CHILD data model."

Logical: PcReferenceGenome
Id: pc-reference-genome-lm
Title: "ReferenceGenome logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `reference_genome`."

* referenceGenomeId 1..1 string "Reference genome id" "Field `reference_genome_id` from the PROTECT-CHILD data model."
* buildName 0..1 CodeableConcept "Build name" "Field `build_name` from the PROTECT-CHILD data model."
* fastaPath 0..1 string "Fasta path" "Field `fasta_path` from the PROTECT-CHILD data model."

Logical: PcTargetRegion
Id: pc-target-region-lm
Title: "TargetRegion logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `target_region`."

* targetRegionId 1..1 string "Target region id" "Field `target_region_id` from the PROTECT-CHILD data model."
* genomicTestId 0..1 string "Genomic test id" "Field `genomic_test_id` from the PROTECT-CHILD data model. Foreign key to `genomic_test`."
* hgncId 0..1 string "Hgnc id" "Field `hgnc_id` from the PROTECT-CHILD data model."
* hgncSymbol 0..1 string "Hgnc symbol" "Field `hgnc_symbol` from the PROTECT-CHILD data model."
* chromosomeId 0..1 integer "Chromosome id" "Field `chromosome_id` from the PROTECT-CHILD data model."
* startPosition 0..1 integer "Start position" "Field `start_position` from the PROTECT-CHILD data model."
* endPosition 0..1 integer "End position" "Field `end_position` from the PROTECT-CHILD data model."

Logical: PcGenomicTest
Id: pc-genomic-test-lm
Title: "GenomicTest logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `genomic_test`."

* genomicTestId 1..1 string "Genomic test id" "Field `genomic_test_id` from the PROTECT-CHILD data model. Foreign key to `bio_sample`."
* referenceGenomeId 0..1 string "Reference genome id" "Field `reference_genome_id` from the PROTECT-CHILD data model. Foreign key to `reference_genome`."
* testName 0..1 string "Test name" "Field `test_name` from the PROTECT-CHILD data model."
* testVersion 0..1 string "Test version" "Field `test_version` from the PROTECT-CHILD data model."
* sequencingDevice 0..1 string "Sequencing device" "Field `sequencing_device` from the PROTECT-CHILD data model."
* targetCapture 0..1 string "Target capture" "Field `target_capture` from the PROTECT-CHILD data model."
* readType 0..1 CodeableConcept "Read type" "Field `read_type` from the PROTECT-CHILD data model."
* readLength 0..1 integer "Read length" "Field `read_length` from the PROTECT-CHILD data model."
* meanTargetCoverage 0..1 decimal "Mean target coverage" "Field `mean_target_coverage` from the PROTECT-CHILD data model."
* perTargetBaseCover100x 0..1 decimal "Per target base cover 100x" "Field `per_target_base_cover_100x` from the PROTECT-CHILD data model."
* alignmentTools 0..1 string "Alignment tools" "Field `alignment_tools` from the PROTECT-CHILD data model."
* variantCallingTools 0..1 string "Variant calling tools" "Field `variant_calling_tools` from the PROTECT-CHILD data model."
* chromosomeCorrdinate 0..1 string "Chromosome corrdinate" "Field `chromosome_corrdinate` from the PROTECT-CHILD data model."
* annotationTools 0..1 string "Annotation tools" "Field `annotation_tools` from the PROTECT-CHILD data model."
* annotationDatabases 0..1 string "Annotation databases" "Field `annotation_databases` from the PROTECT-CHILD data model."

Logical: PcVariantOccurrence
Id: pc-variant-occurrence-lm
Title: "VariantOccurrence logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `variant_occurrence`."

* variantOccurrenceId 1..1 string "Variant occurrence id" "Field `variant_occurrence_id` from the PROTECT-CHILD data model."
* targetRegionId 0..1 string "Target region id" "Field `target_region_id` from the PROTECT-CHILD data model. Foreign key to `target_region`."
* referenceSequence 0..1 string "Reference sequence" "Field `reference_sequence` from the PROTECT-CHILD data model."
* rsId 0..1 string "Rs id" "Field `rs_id` from the PROTECT-CHILD data model."
* referenceAllele 0..1 string "Reference allele" "Field `reference_allele` from the PROTECT-CHILD data model."
* alternateAllele 0..1 string "Alternate allele" "Field `alternate_allele` from the PROTECT-CHILD data model."
* hgvsC 0..1 string "Hgvs c" "Field `hgvs_c` from the PROTECT-CHILD data model."
* hgvsP 0..1 string "Hgvs p" "Field `hgvs_p` from the PROTECT-CHILD data model."
* variantReadDepth 0..1 integer "Variant read depth" "Field `variant_read_depth` from the PROTECT-CHILD data model."
* variantExonNumber 0..1 integer "Variant exon number" "Field `variant_exon_number` from the PROTECT-CHILD data model."
* copyNumber 0..1 decimal "Copy number" "Field `copy_number` from the PROTECT-CHILD data model."
* cnvLocus 0..1 string "Cnv locus" "Field `cnv_locus` from the PROTECT-CHILD data model."
* fusionBreakpoint 0..1 string "Fusion breakpoint" "Field `fusion_breakpoint` from the PROTECT-CHILD data model."
* fusionSupportingReads 0..1 integer "Fusion supporting reads" "Field `fusion_supporting_reads` from the PROTECT-CHILD data model."
* sequenceAlteration 0..1 string "Sequence alteration" "Field `sequence_alteration` from the PROTECT-CHILD data model."
* variantFeature 0..1 string "Variant feature" "Field `variant_feature` from the PROTECT-CHILD data model."
* geneticOrigin 0..1 string "Genetic origin" "Field `genetic_origin` from the PROTECT-CHILD data model."
* genotype 0..1 CodeableConcept "Genotype" "Field `genotype` from the PROTECT-CHILD data model."

Logical: PcVariantAnnotation
Id: pc-variant-annotation-lm
Title: "VariantAnnotation logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `variant_annotation`."

* variantAnnotationId 1..1 string "Variant annotation id" "Field `variant_annotation_id` from the PROTECT-CHILD data model."
* variantOccurrenceId 0..1 string "Variant occurrence id" "Field `variant_occurrence_id` from the PROTECT-CHILD data model. Foreign key to `variant_occurrence`."
* annotationDatabase 0..1 string "Annotation database" "Field `annotation_database` from the PROTECT-CHILD data model."
* variantOrigin 0..1 string "Variant origin" "Field `variant_origin` from the PROTECT-CHILD data model."
* variantPathogeny 0..1 string "Variant pathogeny" "Field `variant_pathogeny` from the PROTECT-CHILD data model."
* variantClassLevel 0..1 string "Variant class level" "Field `variant_class_level` from the PROTECT-CHILD data model."
* variantTierLevel 0..1 string "Variant tier level" "Field `variant_tier_level` from the PROTECT-CHILD data model."
* alleleFrequency 0..1 decimal "Allele frequency" "Field `allele_frequency` from the PROTECT-CHILD data model."
* medication 0..1 string "Medication" "Field `medication` from the PROTECT-CHILD data model."

Logical: PcEpigenomeStudy
Id: pc-epigenome-study-lm
Title: "EpigenomeStudy logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `epigenome_study`."

* epigenomeStudyId 1..1 string "Epigenome study id" "Field `epigenome_study_id` from the PROTECT-CHILD data model."
* genomicTestId 0..1 string "Genomic test id" "Field `genomic_test_id` from the PROTECT-CHILD data model."
* bisulfiteReferenceKit 0..1 string "Bisulfite reference kit" "Field `bisulfite_reference_kit` from the PROTECT-CHILD data model."
* bisulfiteDate 0..1 dateTime "Bisulfite date" "Field `bisulfite_date` from the PROTECT-CHILD data model."
* ageAtDnaExtraction 0..1 integer "Age at DNA extraction" "Field `age_at_DNA_extraction` from the PROTECT-CHILD data model."
* arrayDate 0..1 dateTime "Array date" "Field `array_date` from the PROTECT-CHILD data model."
* snpReaderDevice 0..1 string "SNP reader device" "Field `SNP_reader_device` from the PROTECT-CHILD data model."
* sampleType 0..1 CodeableConcept "Sample type" "Field `sample_type` from the PROTECT-CHILD data model."
* poolId 0..1 string "Pool id" "Field `pool_id` from the PROTECT-CHILD data model."
* sampleId 0..1 string "Sample id" "Field `sample_id` from the PROTECT-CHILD data model."
* sentrixBarcodearray 0..1 string "Sentrix barcodearray" "Field `sentrix_barcodearray` from the PROTECT-CHILD data model."
* sentrixPosition 0..1 string "Sentrix position" "Field `sentrix_position` from the PROTECT-CHILD data model."
* chipType 0..1 CodeableConcept "Chip type" "Field `chip_type` from the PROTECT-CHILD data model."
* manifestNumber 0..1 string "Manifest number" "Field `manifest_number` from the PROTECT-CHILD data model."
* scanDate 0..1 dateTime "Scan date" "Field `scan_date` from the PROTECT-CHILD data model."
* rawData 0..1 string "Raw data" "Field `raw_data` from the PROTECT-CHILD data model."
* targetDiseaseId 0..1 string "Target disease ID" "Field `target_disease_ID` from the PROTECT-CHILD data model."

Logical: PcMethylomicStudy
Id: pc-methylomic-study-lm
Title: "MethylomicStudy logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `methylomic_study`."

* methylomicStudyId 1..1 string "Methylomic study id" "Field `methylomic_study_id` from the PROTECT-CHILD data model. Foreign key to `bio_sample`."
* referenceGenomeId 0..1 string "Reference genome id" "Field `reference_genome_id` from the PROTECT-CHILD data model. Foreign key to `reference_genome`."
* targetRegionId 0..1 string "Target region id" "Field `target_region_id` from the PROTECT-CHILD data model."
* betaValue 0..1 decimal "Beta value" "Field `beta_value` from the PROTECT-CHILD data model."
* mValue 0..1 decimal "M value" "Field `m_value` from the PROTECT-CHILD data model."
* detectionPValue 0..1 decimal "Detection p value" "Field `detection_p_value` from the PROTECT-CHILD data model."
* readCount 0..1 integer "Read count" "Field `read_count` from the PROTECT-CHILD data model."
* methylatedReads 0..1 integer "Methylated reads" "Field `methylated_reads` from the PROTECT-CHILD data model."

Logical: PcPreMedication
Id: pc-pre-medication-lm
Title: "PreMedication logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `pre_medication`."

* preMedicationId 1..1 string "Pre medication id" "Field `pre_medication_id` from the PROTECT-CHILD data model."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* antihypertensiveTreatment 0..1 CodeableConcept "Antihypertensive treatment" "Field `antihypertensive_treatment` from the PROTECT-CHILD data model."
* rituximab 0..1 boolean "Rituximab" "Field `rituximab` from the PROTECT-CHILD data model."
* antiviralPhrophylaxis 0..1 boolean "Antiviral phrophylaxis" "Field `antiviral_phrophylaxis` from the PROTECT-CHILD data model."
* otherMedications 0..1 string "Other medications" "Field `other_medications` from the PROTECT-CHILD data model."

Logical: PcClinicalVariable
Id: pc-clinical-variable-lm
Title: "ClinicalVariable logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `clinical_variable`."

* clinicalVariableId 1..1 string "Clinical variable id" "Field `clinical_variable_id` from the PROTECT-CHILD data model."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* date 0..1 dateTime "Date" "Field `date` from the PROTECT-CHILD data model."
* weight 0..1 decimal "Weight" "Field `weight` from the PROTECT-CHILD data model."
* height 0..1 decimal "Height" "Field `height` from the PROTECT-CHILD data model."
* systolicBloodPressure 0..1 integer "Systolic blood pressure" "Field `systolic_blood_pressure` from the PROTECT-CHILD data model."
* diastolicBloodPressure 0..1 integer "Diastolic blood pressure" "Field `diastolic_blood_pressure` from the PROTECT-CHILD data model."
* heartRate 0..1 integer "Heart rate" "Field `heart_rate` from the PROTECT-CHILD data model."
* oxygenSaturation 0..1 integer "Oxygen saturation" "Field `oxygen_saturation` from the PROTECT-CHILD data model."
* temperature 0..1 integer "Temperature" "Field `temperature` from the PROTECT-CHILD data model."

Logical: PcConcomitantDisease
Id: pc-concomitant-disease-lm
Title: "ConcomitantDisease logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `concomitant_disease`."

* concomitantDiseaseId 1..1 string "Concomitant disease id" "Field `concomitant_disease_id` from the PROTECT-CHILD data model."
* name 0..1 CodeableConcept "Name" "Field `name` from the PROTECT-CHILD data model."

Logical: PcConcomitantMedication
Id: pc-concomitant-medication-lm
Title: "ConcomitantMedication logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `concomitant_medication`."

* concomitantMedicationId 1..1 string "Concomitant medication id" "Field `concomitant_medication_id` from the PROTECT-CHILD data model."
* concomitantEpisodeId 0..1 string "Concomitant episode id" "Field `concomitant_episode_id` from the PROTECT-CHILD data model. Foreign key to `concomitant_episode`."
* medication 0..1 CodeableConcept "Medication" "Field `medication` from the PROTECT-CHILD data model."

Logical: PcConcomitantEpisode
Id: pc-concomitant-episode-lm
Title: "ConcomitantEpisode logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `concomitant_episode`."

* concomitantEpisodeId 1..1 string "Concomitant episode id" "Field `concomitant_episode_id` from the PROTECT-CHILD data model."
* concomitantDiseaseId 0..1 string "Concomitant disease id" "Field `concomitant_disease_id` from the PROTECT-CHILD data model. Foreign key to `concomitant_disease`."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* date 0..1 dateTime "Date" "Field `date` from the PROTECT-CHILD data model."
* description 0..1 string "Description" "Field `description` from the PROTECT-CHILD data model."

Logical: PcMicrobiology
Id: pc-microbiology-lm
Title: "Microbiology logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `microbiology`."

* microbiologyId 1..1 string "Microbiology id" "Field `microbiology_id` from the PROTECT-CHILD data model."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* donorId 0..1 string "Donor id" "Field `donor_id` from the PROTECT-CHILD data model. Foreign key to `donor`."
* ebvDna 0..1 decimal "Ebv dna" "Field `ebv_dna` from the PROTECT-CHILD data model."
* ebvIgmAntiEa 0..1 boolean "Ebv igm anti ea" "Field `ebv_igm_anti_ea` from the PROTECT-CHILD data model."
* ebvIgmAntiVca 0..1 boolean "Ebv igm anti vca" "Field `ebv_igm_anti_vca` from the PROTECT-CHILD data model."
* ebvIggAntiVca 0..1 boolean "Ebv igg anti vca" "Field `ebv_igg_anti_vca` from the PROTECT-CHILD data model."
* ebvIggEbna 0..1 boolean "Ebv igg ebna" "Field `ebv_igg_ebna` from the PROTECT-CHILD data model."
* cmvDna 0..1 boolean "Cmv dna" "Field `cmv_dna` from the PROTECT-CHILD data model."
* cmvIgm 0..1 boolean "Cmv igm" "Field `cmv_igm` from the PROTECT-CHILD data model."
* cmvIgg 0..1 boolean "Cmv igg" "Field `cmv_igg` from the PROTECT-CHILD data model."
* parvovirusB19Dna 0..1 boolean "Parvovirus b19 dna" "Field `parvovirus_b19_dna` from the PROTECT-CHILD data model."
* parvovirusB19DnaIgg 0..1 boolean "Parvovirus b19 dna igg" "Field `parvovirus_b19_dna_igg` from the PROTECT-CHILD data model."
* parvovirusB19DnaIgm 0..1 boolean "Parvovirus b19 dna igm" "Field `parvovirus_b19_dna_igm` from the PROTECT-CHILD data model."
* hsvIgg 0..1 boolean "Hsv igg" "Field `hsv_igg` from the PROTECT-CHILD data model."
* hsvIgm 0..1 boolean "Hsv igm" "Field `hsv_igm` from the PROTECT-CHILD data model."
* adenovirusIgg 0..1 boolean "Adenovirus igg" "Field `adenovirus_igg` from the PROTECT-CHILD data model."
* adenovirusIgm 0..1 boolean "Adenovirus igm" "Field `adenovirus_igm` from the PROTECT-CHILD data model."
* vzvIgg 0..1 boolean "Vzv igg" "Field `vzv_igg` from the PROTECT-CHILD data model."
* vzvIgm 0..1 boolean "Vzv igm" "Field `vzv_igm` from the PROTECT-CHILD data model."
* bloodBkvDna 0..1 boolean "Blood bkv dna" "Field `blood_bkv_dna` from the PROTECT-CHILD data model."
* urineBkvDna 0..1 boolean "Urine bkv dna" "Field `urine_bkv_dna` from the PROTECT-CHILD data model."
* bkvDnaKidneyBiopsy 0..1 boolean "Bkv dna kidney biopsy" "Field `bkv_dna_kidney_biopsy` from the PROTECT-CHILD data model."
* bkvFishKidneyBiopsy 0..1 boolean "Bkv fish kidney biopsy" "Field `bkv_fish_kidney_biopsy` from the PROTECT-CHILD data model."

Logical: PcInstrumentalInvestigation
Id: pc-instrumental-investigation-lm
Title: "InstrumentalInvestigation logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `instrumental_investigation`."

* instrumentalInvestigationId 1..1 string "Instrumental investigation id" "Field `instrumental_investigation_id` from the PROTECT-CHILD data model."
* name 0..1 CodeableConcept "Name" "Field `name` from the PROTECT-CHILD data model."

Logical: PcPatInstInv
Id: pc-pat-inst-inv-lm
Title: "PatInstInv logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `pat_inst_inv`."

* patInstInvId 1..1 string "Pat inst inv id" "Field `pat_inst_inv_id` from the PROTECT-CHILD data model."
* instrumentalInvestigationId 0..1 string "Instrumental investigation id" "Field `instrumental_investigation_id` from the PROTECT-CHILD data model. Foreign key to `instrumental_investigation`."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* date 0..1 dateTime "Date" "Field `date` from the PROTECT-CHILD data model."
* result 0..1 CodeableConcept "Result" "Field `result` from the PROTECT-CHILD data model."
* observations 0..1 string "Observations" "Field `observations` from the PROTECT-CHILD data model."

Logical: PcImmunosuppressant
Id: pc-immunosuppressant-lm
Title: "Immunosuppressant logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `immunosuppressant`."

* immId 1..1 string "Imm id" "Field `imm_id` from the PROTECT-CHILD data model."
* name 0..1 CodeableConcept "Name" "Field `name` from the PROTECT-CHILD data model."

Logical: PcImmIndPat
Id: pc-imm-ind-pat-lm
Title: "ImmIndPat logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `imm_ind_pat`."

* immIndPatId 1..1 string "Imm ind pat id" "Field `imm_ind_pat_id` from the PROTECT-CHILD data model."
* immId 0..1 string "Imm id" "Field `imm_id` from the PROTECT-CHILD data model. Foreign key to `immunosuppressant`."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* dose 0..1 decimal "Dose" "Field `dose` from the PROTECT-CHILD data model."
* unit 0..1 CodeableConcept "Unit" "Field `unit` from the PROTECT-CHILD data model."

Logical: PcImmMainPat
Id: pc-imm-main-pat-lm
Title: "ImmMainPat logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `imm_main_pat`."

* immMainPatId 1..1 string "Imm main pat id" "Field `imm_main_pat_id` from the PROTECT-CHILD data model."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* immId 0..1 string "Imm id" "Field `imm_id` from the PROTECT-CHILD data model. Foreign key to `immunosuppressant`."
* unitId 0..1 string "Unit id" "Field `unit_id` from the PROTECT-CHILD data model."
* dose 0..1 decimal "Dose" "Field `dose` from the PROTECT-CHILD data model."
* preDoseLevel 0..1 decimal "Pre dose level" "Field `pre_dose_level` from the PROTECT-CHILD data model."
* csa2hPostDoseLevel 0..1 decimal "Csa 2h post dose level" "Field `csa_2h_post_dose_level` from the PROTECT-CHILD data model."
* auc 0..1 decimal "Auc" "Field `auc` from the PROTECT-CHILD data model."
* startDate 0..1 dateTime "Start date" "Field `start_date` from the PROTECT-CHILD data model."
* endDate 0..1 dateTime "End date" "Field `end_date` from the PROTECT-CHILD data model."

Logical: PcLabTest
Id: pc-lab-test-lm
Title: "LabTest logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `lab_test`."

* labTestId 1..1 string "Lab test id" "Field `lab_test_id` from the PROTECT-CHILD data model."
* unitId 0..1 string "Unit id" "Field `unit_id` from the PROTECT-CHILD data model. Foreign key to `unit`."
* name 0..1 CodeableConcept "Name" "Field `name` from the PROTECT-CHILD data model."

Logical: PcUnit
Id: pc-unit-lm
Title: "Unit logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `unit`."

* unitId 1..1 string "Unit id" "Field `unit_id` from the PROTECT-CHILD data model."
* ucum 0..1 code "UCUM" "Field `UCUM` from the PROTECT-CHILD data model."
* label 0..1 string "Label" "Field `Label` from the PROTECT-CHILD data model."

Logical: PcLabResult
Id: pc-lab-result-lm
Title: "LabResult logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `lab_result`."

* labResultId 1..1 string "Lab result id" "Field `lab_result_id` from the PROTECT-CHILD data model."
* labTestId 0..1 string "Lab test id" "Field `lab_test_id` from the PROTECT-CHILD data model. Foreign key to `lab_test`."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* unitId 0..1 CodeableConcept "Unit id" "Field `unit_id` from the PROTECT-CHILD data model."
* date 0..1 dateTime "Date" "Field `date` from the PROTECT-CHILD data model."
* value 0..1 decimal "Value" "Field `value` from the PROTECT-CHILD data model."

Logical: PcMarkImmFunc
Id: pc-mark-imm-func-lm
Title: "MarkImmFunc logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `mark_imm_func`."

* markImmFuncId 1..1 string "Mark imm func id" "Field `mark_imm_func_id` from the PROTECT-CHILD data model."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* hlaAntibodyClass 0..1 string "Hla antibody class" "Field `hla_antibody_class` from the PROTECT-CHILD data model."
* mfiValue 0..1 string "Mfi value" "Field `mfi_value` from the PROTECT-CHILD data model."
* dsa 0..1 boolean "Dsa" "Field `dsa` from the PROTECT-CHILD data model."
* atr1 0..1 decimal "Atr1" "Field `atr1` from the PROTECT-CHILD data model."
* etar 0..1 decimal "Etar" "Field `etar` from the PROTECT-CHILD data model."
* mica 0..1 decimal "Mica" "Field `mica` from the PROTECT-CHILD data model."
* micb 0..1 decimal "Micb" "Field `micb` from the PROTECT-CHILD data model."
* aecaOther 0..1 string "Aeca other" "Field `aeca_other` from the PROTECT-CHILD data model."

Logical: PcPostEvent
Id: pc-post-event-lm
Title: "PostEvent logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `post_event`."

* postEventId 1..1 string "Post event id" "Field `post_event_id` from the PROTECT-CHILD data model."
* postEventTypeId 0..1 string "Post event type id" "Field `post_event_type_id` from the PROTECT-CHILD data model. Foreign key to `post_event_type`."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* onsetDate 0..1 dateTime "Onset date" "Field `onset_date` from the PROTECT-CHILD data model."
* endDate 0..1 dateTime "End date" "Field `end_date` from the PROTECT-CHILD data model."
* description 0..1 string "Description" "Field `description` from the PROTECT-CHILD data model."

Logical: PcPostEventType
Id: pc-post-event-type-lm
Title: "PostEventType logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `post_event_type`."

* postEventTypeId 1..1 string "Post event type id" "Field `post_event_type_id` from the PROTECT-CHILD data model."
* name 0..1 CodeableConcept "Name" "Field `name` from the PROTECT-CHILD data model."

Logical: PcOutcomeType
Id: pc-outcome-type-lm
Title: "OutcomeType logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `outcome_type`."

* outcomeTypeId 1..1 string "Outcome type id" "Field `outcome_type_id` from the PROTECT-CHILD data model."
* name 0..1 CodeableConcept "Name" "Field `name` from the PROTECT-CHILD data model."

Logical: PcOutcome
Id: pc-outcome-lm
Title: "Outcome logical model"
Description: "Logical model representing the PROTECT-CHILD data model entity `outcome`."

* outcomeId 1..1 string "Outcome id" "Field `outcome_id` from the PROTECT-CHILD data model."
* outcomeTypeId 0..1 string "Outcome type id" "Field `outcome_type_id` from the PROTECT-CHILD data model. Foreign key to `outcome_type`."
* patientId 0..1 string "Patient id" "Field `patient_id` from the PROTECT-CHILD data model. Foreign key to `patient`."
* date 0..1 dateTime "Date" "Field `date` from the PROTECT-CHILD data model."
* preMedication 0..1 string "Pre medication" "Field `pre_medication` from the PROTECT-CHILD data model."
* clinicalVariableId 0..1 string "Clinical variable id" "Field `clinical_variable_id` from the PROTECT-CHILD data model."
* concomitantEpisodeId 0..1 string "Concomitant episode id" "Field `concomitant_episode_id` from the PROTECT-CHILD data model."
* microbiologyId 0..1 string "Microbiology id" "Field `microbiology_id` from the PROTECT-CHILD data model."
* patInstInvId 0..1 string "Pat inst inv id" "Field `pat_inst_inv_id` from the PROTECT-CHILD data model."
* labTestId 0..1 string "Lab test id" "Field `lab_test_id` from the PROTECT-CHILD data model."
* postEventId 0..1 string "Post event id" "Field `post_event_id` from the PROTECT-CHILD data model."
