// ================================================
// BioSample – profile & extensions
// ================================================

// ================================================
// Invariants
// ================================================

Invariant: biosample-dna-concentration-nonnegative
Description: "DNA concentration must be zero or positive."
Severity: #error
Expression: "valueDecimal >= 0"

// ================================================
// Tissue type terminology (tissue_type)
// ================================================

CodeSystem: BioSampleTissueTypeCS
Id: biosample-tissue-type-cs
Title: "BioSample Tissue Type CodeSystem"
Description: "Tissue types for biological samples (from the bio_sample table)."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/biosample-tissue-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #blood        "Blood"
* #saliva       "Saliva"
* #other-tissue "Other tissues"

ValueSet: BioSampleTissueTypeVS
Id: biosample-tissue-type-vs
Title: "BioSample Tissue Type ValueSet"
Description: "Allowed tissue types for BioSample.tissue_type."
* BioSampleTissueTypeCS#blood
* BioSampleTissueTypeCS#saliva
* BioSampleTissueTypeCS#other-tissue

// ================================================
// Extensions
// ================================================

// genomic_test_id (O)
Extension: BioSampleGenomicTestRef
Id: biosample-genomic-test-ref
Title: "Genomic Test ID Relationship"
Description: "genomic_test_id – reference to the genomic test configuration used for this sample."
* value[x] only Reference(GenomicTest)
* valueReference 1..1

// epigenome_study_id (O)
Extension: BioSampleEpigenomeStudyRef
Id: biosample-epigenome-study-ref
Title: "Epigenome Study ID Relationship"
Description: "epigenome_study_id – reference to epigenome study linked to this sample."
* value[x] only Reference(EpigenomeStudy)
* valueReference 1..1

// methylomic_study_id (O)
Extension: BioSampleMethylomicStudyRef
Id: biosample-methylomic-study-ref
Title: "Methylomic Study ID Relationship"
Description: "methylomic_study_id – reference to methylomic study linked to this sample."
* value[x] only Reference(MethylomicStudy)
* valueReference 1..1

// send_ingemm_date (R)
Extension: BioSampleSendIngemmDate
Id: biosample-send-ingemm-date
Title: "Sample send to INGEMM date"
Description: "send_ingemm_date – date when the sample was sent to INGEMM."
* value[x] only date
* valueDate 1..1

// dna_concentration (optional, Float ≥ 0)
// Note: FHIR uses decimal; semantically this is a float.
Extension: BioSampleDNAConcentration
Id: biosample-dna-concentration
Title: "DNA concentration"
Description: "dna_concentration – DNA concentration for the sample (float)."
* value[x] only decimal
* valueDecimal 1..1
* obeys biosample-dna-concentration-nonnegative

// ================================================
// BioSample profile (Specimen)
// ================================================

Profile: BioSample
Parent: Specimen
Id: biosample
Title: "Biological Sample"
Description: "Biological sample linked to transplant patients and omics studies, aligned with the bio_sample table."

// bio_sample_id → Specimen.identifier (M)
* identifier 1..1 MS
* identifier ^short = "bio_sample_id – primary identifier for the biological sample"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/biosample-id" (exactly)
* identifier.value 1..1

// patient_id → Specimen.subject (M)
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id – reference to the transplant recipient"

// collection_date → Specimen.collection.collectedDateTime (R)
* collection 1..1 MS
* collection ^short = "Sample collection details"
* collection.collected[x] 1..1
* collection.collected[x] only dateTime
* collection.collectedDateTime ^short = "collection_date – sample collection date"

// tissue_type → Specimen.type (R)
* type 1..1 MS
* type ^short = "tissue_type – type of tissue sampled"
* type ^binding.strength = #required
* type ^binding.valueSet = Canonical(BioSampleTissueTypeVS)
* type.text 1..1

// Attach BioSample-specific extensions, with DM variable names as slice names
* extension contains
    BioSampleGenomicTestRef named genomic_test_id 0..1 MS and
    BioSampleEpigenomeStudyRef named epigenome_study_id 0..1 MS and
    BioSampleMethylomicStudyRef named methylomic_study_id 0..1 MS and
    BioSampleSendIngemmDate named send_ingemm_date 1..1 MS and
    BioSampleDNAConcentration named dna_concentration 0..1 MS

* extension[genomic_test_id] ^short = "genomic_test_id – Reference to GenomicTest"
* extension[epigenome_study_id] ^short = "epigenome_study_id – Reference to EpigenomeStudy"
* extension[methylomic_study_id] ^short = "methylomic_study_id – Reference to MethylomicStudy"
* extension[send_ingemm_date] ^short = "send_ingemm_date – date sample sent to INGEMM"
* extension[dna_concentration] ^short = "dna_concentration – DNA concentration (float, ≥ 0)"

// ================================================
// Example BioSample instance
// ================================================

Instance: BioSampleExample1
InstanceOf: BioSample
Usage: #example
Title: "Example Biological Sample"
Description: "Example biological sample used in Visit example."

* id = "biosample-example-1"

// bio_sample_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/biosample-id"
* identifier.value = "BS0001"

// patient_id
* subject = Reference(ExamplePatientTransplant1)

// collection_date
* collection.collectedDateTime = "2025-01-15"

// tissue_type
* type.coding[0].system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/biosample-tissue-type"
* type.coding[0].code = #blood
* type.coding[0].display = "Blood"
* type.text = "Peripheral blood"

// genomic_test_id
* extension[genomic_test_id].valueReference = Reference(GenomicTestExample1)

// epigenome_study_id
* extension[epigenome_study_id].valueReference = Reference(EpigenomeStudyExample1)

// methylomic_study_id
* extension[methylomic_study_id].valueReference = Reference(MethylomicStudyExample1)

// send_ingemm_date
* extension[send_ingemm_date].valueDate = "2025-01-20"

// dna_concentration (float/decimal)
* extension[dna_concentration].valueDecimal = 35.2
