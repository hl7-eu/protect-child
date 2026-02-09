// ================================================
// Epigenome Study – extensions & profile
// ================================================

// ================================================
// Extensions
// ================================================

// genomic_test_id – ElementReference(GenomicTest)
Extension: EpigenomeStudyGenomicTestRef
Id: epigenome-study-genomic-test-ref
Title: "Genomic test ID relationship"
Description: "Reference to the genomic test used in this epigenome study."
* value[x] only Reference(GenomicTest)
* valueReference 1..1

// bisulfite_reference_kit – String
Extension: EpigenomeStudyBisulfiteReferenceKit
Id: epigenome-study-bisulfite-reference-kit
Title: "Bisulfite reference kit"
Description: "Bisulfite conversion kit used in the epigenome experiment."
* value[x] only string
* valueString 1..1

// bisulfite_date – Date
Extension: EpigenomeStudyBisulfiteDate
Id: epigenome-study-bisulfite-date
Title: "Bisulfite date"
Description: "Date of bisulfite conversion."
* value[x] only date
* valueDate 1..1

// age_at_DNA_extraction – Decimal (age in years)
Extension: EpigenomeStudyAgeAtDNAExtraction
Id: epigenome-study-age-at-dna-extraction
Title: "Age at DNA extraction"
Description: "Age (in years) of the subject at the time of DNA extraction."
* value[x] only decimal
* valueDecimal 1..1

// array_date – Date
Extension: EpigenomeStudyArrayDate
Id: epigenome-study-array-date
Title: "Array date"
Description: "Date when the array was run."
* value[x] only date
* valueDate 1..1

// SNP_reader_device – String
Extension: EpigenomeStudySNPReaderDevice
Id: epigenome-study-snp-reader-device
Title: "SNP reader device"
Description: "Device used as SNP reader."
* value[x] only string
* valueString 1..1

// sample_type – uses BioSample tissue type value set (Blood / Saliva / Other tissues)
Extension: EpigenomeStudySampleType
Id: epigenome-study-sample-type
Title: "Sample type"
Description: "Type of sample used in the epigenome study (Blood, Saliva, Other tissues)."
* value[x] only CodeableConcept
* valueCodeableConcept from BioSampleTissueTypeVS (required)

// pool_id – String
Extension: EpigenomeStudyPoolId
Id: epigenome-study-pool-id
Title: "Pool ID"
Description: "Identifier of the sample pool."
* value[x] only string
* valueString 1..1

// sample_id – String
Extension: EpigenomeStudySampleId
Id: epigenome-study-sample-id
Title: "Sample ID"
Description: "Sample identifier used in the epigenome study."
* value[x] only string
* valueString 1..1

// sentrix_barcodearray – String
Extension: EpigenomeStudySentrixBarcodeArray
Id: epigenome-study-sentrix-barcodearray
Title: "Sentrix barcode array"
Description: "Sentrix array barcode."
* value[x] only string
* valueString 1..1

// sentrix_position – String
Extension: EpigenomeStudySentrixPosition
Id: epigenome-study-sentrix-position
Title: "Sentrix position"
Description: "Position on the Sentrix array."
* value[x] only string
* valueString 1..1

// chip_type – String
Extension: EpigenomeStudyChipType
Id: epigenome-study-chip-type
Title: "Chip type"
Description: "Type of chip used for the epigenome array."
* value[x] only string
* valueString 1..1

// manifest_number – String
Extension: EpigenomeStudyManifestNumber
Id: epigenome-study-manifest-number
Title: "Manifest number"
Description: "Manifest number for the array."
* value[x] only string
* valueString 1..1

// scan_date – Date
Extension: EpigenomeStudyScanDate
Id: epigenome-study-scan-date
Title: "Scan date"
Description: "Date when the array was scanned."
* value[x] only date
* valueDate 1..1

// raw_data – String
Extension: EpigenomeStudyRawData
Id: epigenome-study-raw-data
Title: "Raw data"
Description: "Link or identifier to raw data files."
* value[x] only string
* valueString 1..1

// target_disease_ID – String (could later become a Reference to a disease entity)
Extension: EpigenomeStudyTargetDiseaseId
Id: epigenome-study-target-disease-id
Title: "Target disease ID"
Description: "Identifier of the target disease for this epigenome study."
* value[x] only string
* valueString 1..1


// ================================================
// Epigenome Study profile (using Basic)
// ================================================

Profile: EpigenomeStudy
Parent: Basic
Id: epigenome-study
Title: "Epigenome Study"
Description: "Epigenome (e.g. methylation array) study metadata and platform details."

// ------------------------------------------------
// epigenome_study_id → Basic.identifier
//   Type: ID
// ------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Epigenome study ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/epigenome-study-id" (exactly)
* identifier.value 1..1

// ------------------------------------------------
// Basic.code is required.
// Use as a simple category for epigenome studies.
// ------------------------------------------------
* code 1..1 MS
* code ^short = "Epigenome study category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/epigenome-study-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// ------------------------------------------------
// Attach Epigenome Study–specific extensions
// ------------------------------------------------
* extension contains
    EpigenomeStudyGenomicTestRef named genomicTestId 0..1 MS and
    EpigenomeStudyBisulfiteReferenceKit named bisulfiteReferenceKit 0..1 MS and
    EpigenomeStudyBisulfiteDate named bisulfiteDate 0..1 MS and
    EpigenomeStudyAgeAtDNAExtraction named ageAtDNAExtraction 0..1 MS and
    EpigenomeStudyArrayDate named arrayDate 0..1 MS and
    EpigenomeStudySNPReaderDevice named snpReaderDevice 0..1 MS and
    EpigenomeStudySampleType named sampleType 0..1 MS and
    EpigenomeStudyPoolId named poolId 0..1 MS and
    EpigenomeStudySampleId named sampleId 0..1 MS and
    EpigenomeStudySentrixBarcodeArray named sentrixBarcodeArray 0..1 MS and
    EpigenomeStudySentrixPosition named sentrixPosition 0..1 MS and
    EpigenomeStudyChipType named chipType 0..1 MS and
    EpigenomeStudyManifestNumber named manifestNumber 0..1 MS and
    EpigenomeStudyScanDate named scanDate 0..1 MS and
    EpigenomeStudyRawData named rawData 0..1 MS and
    EpigenomeStudyTargetDiseaseId named targetDiseaseId 0..1 MS

// Short labels
* extension[genomicTestId] ^short = "Genomic test ID relationship"
* extension[bisulfiteReferenceKit] ^short = "Bisulfite reference kit"
* extension[bisulfiteDate] ^short = "Bisulfite date"
* extension[ageAtDNAExtraction] ^short = "Age at DNA extraction (years)"
* extension[arrayDate] ^short = "Array date"
* extension[snpReaderDevice] ^short = "SNP reader device"
* extension[sampleType] ^short = "Sample type"
* extension[poolId] ^short = "Pool ID"
* extension[sampleId] ^short = "Sample ID"
* extension[sentrixBarcodeArray] ^short = "Sentrix barcode array"
* extension[sentrixPosition] ^short = "Sentrix position"
* extension[chipType] ^short = "Chip type"
* extension[manifestNumber] ^short = "Manifest number"
* extension[scanDate] ^short = "Scan date"
* extension[rawData] ^short = "Raw data (file/link identifier)"
* extension[targetDiseaseId] ^short = "Target disease ID"


// ================================================
// Example Epigenome Study instance
// ================================================

Instance: EpigenomeStudyExample1
InstanceOf: EpigenomeStudy
Usage: #example
Title: "Example Epigenome Study"
Description: "Example epigenome (methylation array) study record."

* id = "epigenome-study-example-1"

// epigenome_study_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/epigenome-study-id"
* identifier.value = "ES0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/epigenome-study-type#array "Methylation array epigenome study"

// genomic_test_id
* extension[genomicTestId].valueReference = Reference(GenomicTestExample1)

// bisulfite_reference_kit
* extension[bisulfiteReferenceKit].valueString = "EZ DNA Methylation-Gold Kit"

// bisulfite_date
* extension[bisulfiteDate].valueDate = "2025-01-10"

// age_at_DNA_extraction
* extension[ageAtDNAExtraction].valueDecimal = 45.0

// array_date
* extension[arrayDate].valueDate = "2025-01-12"

// SNP_reader_device
* extension[snpReaderDevice].valueString = "iScan System"

// sample_type
* extension[sampleType].valueCodeableConcept = BioSampleTissueTypeCS#blood "Blood"

// pool_id
* extension[poolId].valueString = "POOL-01"

// sample_id
* extension[sampleId].valueString = "SAMPLE-123"

// sentrix_barcodearray
* extension[sentrixBarcodeArray].valueString = "203456789012"

// sentrix_position
* extension[sentrixPosition].valueString = "R01C01"

// chip_type
* extension[chipType].valueString = "Infinium MethylationEPIC BeadChip"

// manifest_number
* extension[manifestNumber].valueString = "METH-EPIC-201"

// scan_date
* extension[scanDate].valueDate = "2025-01-13"

// raw_data
* extension[rawData].valueString = "gs://bucket/methylation/ES0001/idat/"

// target_disease_ID
* extension[targetDiseaseId].valueString = "OMIM:123456"
