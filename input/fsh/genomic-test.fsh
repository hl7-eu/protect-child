// ================================================
// Genomic Test – extensions & profile
// ================================================

// ================================================
// Extensions
// ================================================

// reference_genome_id – ElementReference(ReferenceGenome)
Extension: GenomicTestReferenceGenome
Id: genomic-test-reference-genome
Title: "Reference Genome ID relationship"
Description: "Reference to the reference genome used for this genomic test."
* value[x] only Reference(ReferenceGenome)
* valueReference 1..1

// test_name – String
Extension: GenomicTestName
Id: genomic-test-name
Title: "Genomic Test Name"
Description: "Name of the platform using sequencing, assigned by the institution."
* value[x] only string
* valueString 1..1

// test_version – String
Extension: GenomicTestVersion
Id: genomic-test-version
Title: "Genomic Test Version"
Description: "Version of the platform using sequencing, assigned by the institution."
* value[x] only string
* valueString 1..1

// sequencing_device – String
Extension: GenomicTestSequencingDevice
Id: genomic-test-sequencing-device
Title: "Sequencing device"
Description: "Sequencer machine information."
* value[x] only string
* valueString 1..1

// target_capture – String
Extension: GenomicTestTargetCapture
Id: genomic-test-target-capture
Title: "Target capture"
Description: "Information about the capture method of examined and targeted region."
* value[x] only string
* valueString 1..1

// read_type – String
Extension: GenomicTestReadType
Id: genomic-test-read-type
Title: "Read type"
Description: "Information about the method of sequence reading."
* value[x] only string
* valueString 1..1

// read_length – Integer
Extension: GenomicTestReadLength
Id: genomic-test-read-length
Title: "Read length"
Description: "Information about the length of the read."
* value[x] only integer
* valueInteger 1..1

// mean_target_coverage – Float (decimal)
Extension: GenomicTestMeanTargetCoverage
Id: genomic-test-mean-target-coverage
Title: "Mean target coverage"
Description: "Mean target coverage."
* value[x] only decimal
* valueDecimal 1..1

// per_target_base_cover_100x – Float (decimal)
Extension: GenomicTestPerTargetBaseCover100x
Id: genomic-test-per-target-base-cover-100x
Title: "Per target base cover x100"
Description: "Percentage of selected bases covered at ≥100x."
* value[x] only decimal
* valueDecimal 1..1

// alignment_tools – String
Extension: GenomicTestAlignmentTools
Id: genomic-test-alignment-tools
Title: "Alignment tools"
Description: "Name and version of the alignment tool."
* value[x] only string
* valueString 1..1

// variant_calling_tools – String
Extension: GenomicTestVariantCallingTools
Id: genomic-test-variant-calling-tools
Title: "Variant calling tools"
Description: "Name and version of the variant calling tool."
* value[x] only string
* valueString 1..1

// chromosome_corrdinate – String
Extension: GenomicTestChromosomeCorrdinate
Id: genomic-test-chromosome-corrdinate
Title: "Chromosome coordinate"
Description: "Coordinate system for numbering the chromosomes."
* value[x] only string
* valueString 1..1

// annotation_tools – String
Extension: GenomicTestAnnotationTools
Id: genomic-test-annotation-tools
Title: "Annotation tools"
Description: "Information about the tool used for annotation."
* value[x] only string
* valueString 1..1

// annotation_databases – String
Extension: GenomicTestAnnotationDatabases
Id: genomic-test-annotation-databases
Title: "Annotation databases"
Description: "Information about the databases used for annotation."
* value[x] only string
* valueString 1..1

// ================================================
// Genomic Test profile (using Basic)
// ================================================

Profile: GenomicTest
Parent: Basic
Id: genomic-test
Title: "Genomic Test"
Description: "Definition of a genomic test / sequencing platform and pipeline configuration."

// ------------------------------------------------
// genomic_test_id → Basic.identifier
//   Label: Genomic Test ID
//   Type: ID
// ------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Genomic Test ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/genomic-test-id" (exactly)
* identifier.value 1..1

// ------------------------------------------------
// Basic.code is required by the base resource.
// We use it as a simple category of genomic test.
// ------------------------------------------------
* code 1..1 MS
* code ^short = "Genomic test category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/genomic-test-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// ------------------------------------------------
// Attach all specific extensions
// ------------------------------------------------
* extension contains
    GenomicTestReferenceGenome named referenceGenomeId 0..1 MS and
    GenomicTestName named testName 0..1 MS and
    GenomicTestVersion named testVersion 0..1 MS and
    GenomicTestSequencingDevice named sequencingDevice 0..1 MS and
    GenomicTestTargetCapture named targetCapture 0..1 MS and
    GenomicTestReadType named readType 0..1 MS and
    GenomicTestReadLength named readLength 0..1 MS and
    GenomicTestMeanTargetCoverage named meanTargetCoverage 0..1 MS and
    GenomicTestPerTargetBaseCover100x named perTargetBaseCover100x 0..1 MS and
    GenomicTestAlignmentTools named alignmentTools 0..1 MS and
    GenomicTestVariantCallingTools named variantCallingTools 0..1 MS and
    GenomicTestChromosomeCorrdinate named chromosomeCorrdinate 0..1 MS and
    GenomicTestAnnotationTools named annotationTools 0..1 MS and
    GenomicTestAnnotationDatabases named annotationDatabases 0..1 MS


// ================================================
// Example Genomic Test instance
// ================================================

Instance: GenomicTestExample1
InstanceOf: GenomicTest
Usage: #example
Title: "Example Genomic Test"
Description: "Example genomic test / sequencing platform configuration."

* id = "genomic-test-example-1"

// genomic_test_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/genomic-test-id"
* identifier.value = "GT0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/genomic-test-type#exome "Exome sequencing"

// reference_genome_id
* extension[referenceGenomeId].valueReference = Reference(ReferenceGenomeExampleGRCh38)

// test_name
* extension[testName].valueString = "ExomeSeq v1"

// test_version
* extension[testVersion].valueString = "1.2.3"

// sequencing_device
* extension[sequencingDevice].valueString = "Illumina NovaSeq 6000"

// target_capture
* extension[targetCapture].valueString = "Exome capture kit XYZ v5"

// read_type
* extension[readType].valueString = "Paired-end"

// read_length
* extension[readLength].valueInteger = 150

// mean_target_coverage
* extension[meanTargetCoverage].valueDecimal = 120.5

// per_target_base_cover_100x
* extension[perTargetBaseCover100x].valueDecimal = 95.3

// alignment_tools
* extension[alignmentTools].valueString = "BWA-MEM 0.7.17"

// variant_calling_tools
* extension[variantCallingTools].valueString = "GATK HaplotypeCaller 4.2.0"

// chromosome_corrdinate
* extension[chromosomeCorrdinate].valueString = "GRCh38 (1-based, inclusive)"

// annotation_tools
* extension[annotationTools].valueString = "VEP 104"

// annotation_databases
* extension[annotationDatabases].valueString = "gnomAD v3.1, ClinVar 2025-01, dbNSFP 4.3"
