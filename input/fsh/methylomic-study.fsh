// ================================================
// Methylomic Study – extensions & profile
// ================================================

// ================================================
// Extensions
// ================================================

// reference_genome_id – ElementReference(ReferenceGenome)
Extension: MethylomicStudyReferenceGenomeRef
Id: methylomic-study-reference-genome-ref
Title: "Reference genome ID relationship"
Description: "Reference to the reference genome used in this methylomic study."
* value[x] only Reference(ReferenceGenome)
* valueReference 1..1

// target_region_id – String (ID of target region; could be linked to TargetRegion table)
Extension: MethylomicStudyTargetRegionId
Id: methylomic-study-target-region-id
Title: "Target region ID"
Description: "Identifier of the target region for which methylation information is recorded."
* value[x] only string
* valueString 1..1

// beta_value – Float (decimal)
Extension: MethylomicStudyBetaValue
Id: methylomic-study-beta-value
Title: "Beta value"
Description: "Beta value representing methylation level."
* value[x] only decimal
* valueDecimal 1..1

// m_value – Float (decimal)
Extension: MethylomicStudyMValue
Id: methylomic-study-m-value
Title: "M value"
Description: "M-value transformation of the beta value."
* value[x] only decimal
* valueDecimal 1..1

// detection_p_value – Float (decimal)
Extension: MethylomicStudyDetectionPValue
Id: methylomic-study-detection-p-value
Title: "Detection p-value"
Description: "Detection p-value for the methylation measurement."
* value[x] only decimal
* valueDecimal 1..1

// read_count – Integer
Extension: MethylomicStudyReadCount
Id: methylomic-study-read-count
Title: "Read count"
Description: "Total number of reads for this locus."
* value[x] only integer
* valueInteger 1..1

// methylated_reads – Integer
Extension: MethylomicStudyMethylatedReads
Id: methylomic-study-methylated-reads
Title: "Methylated reads"
Description: "Number of reads showing methylation."
* value[x] only integer
* valueInteger 1..1


// ================================================
// Methylomic Study profile (using Basic)
// ================================================

Profile: MethylomicStudy
Parent: Basic
Id: methylomic-study
Title: "Methylomic Study"
Description: "Methylomic study / locus-level methylation metrics."

// ------------------------------------------------
// methylomic_study_id → Basic.identifier
//   Type: ID
// ------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Methylomic study ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/methylomic-study-id" (exactly)
* identifier.value 1..1

// ------------------------------------------------
// Basic.code is required.
// Use as a simple category for methylomic records.
// ------------------------------------------------
* code 1..1 MS
* code ^short = "Methylomic study category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/methylomic-study-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// ------------------------------------------------
// Attach Methylomic Study–specific extensions
// ------------------------------------------------
* extension contains
    MethylomicStudyReferenceGenomeRef named referenceGenomeId 0..1 MS and
    MethylomicStudyTargetRegionId named targetRegionId 0..1 MS and
    MethylomicStudyBetaValue named betaValue 0..1 MS and
    MethylomicStudyMValue named mValue 0..1 MS and
    MethylomicStudyDetectionPValue named detectionPValue 0..1 MS and
    MethylomicStudyReadCount named readCount 0..1 MS and
    MethylomicStudyMethylatedReads named methylatedReads 0..1 MS

// Short labels
* extension[referenceGenomeId] ^short = "Reference genome ID relationship"
* extension[targetRegionId] ^short = "Target region ID"
* extension[betaValue] ^short = "Beta value"
* extension[mValue] ^short = "M value"
* extension[detectionPValue] ^short = "Detection p-value"
* extension[readCount] ^short = "Read count"
* extension[methylatedReads] ^short = "Methylated reads"


// ================================================
// Example Methylomic Study instance
// ================================================

Instance: MethylomicStudyExample1
InstanceOf: MethylomicStudy
Usage: #example
Title: "Example Methylomic Study"
Description: "Example methylomic record for a locus."

* id = "methylomic-study-example-1"

// methylomic_study_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/methylomic-study-id"
* identifier.value = "MS0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/methylomic-study-type#locus "Locus-level methylomic record"

// reference_genome_id
* extension[referenceGenomeId].valueReference = Reference(ReferenceGenomeExampleGRCh38)

// target_region_id
* extension[targetRegionId].valueString = "TR0001"

// beta_value
* extension[betaValue].valueDecimal = 0.72

// m_value
* extension[mValue].valueDecimal = 1.85

// detection_p_value
* extension[detectionPValue].valueDecimal = 0.0003

// read_count
* extension[readCount].valueInteger = 250

// methylated_reads
* extension[methylatedReads].valueInteger = 180
