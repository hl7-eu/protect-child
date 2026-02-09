// ================================================
// Target Region – extensions & profile
// ================================================

// ================================================
// Extensions
// ================================================

// genomic_test_id – ElementReference(GenomicTest)
Extension: TargetRegionGenomicTestRef
Id: target-region-genomic-test-ref
Title: "Genomic test ID relationship"
Description: "Reference to the genomic test (platform) containing this target region."
* value[x] only Reference(GenomicTest)
* valueReference 1..1

// hgnc_id – String
Extension: TargetRegionHGNCId
Id: target-region-hgnc-id
Title: "HGNC ID"
Description: "Gene ID based on HGNC nomenclature."
* value[x] only string
* valueString 1..1

// hgnc_symbol – String
Extension: TargetRegionHGNCSymbol
Id: target-region-hgnc-symbol
Title: "HGNC symbol"
Description: "Gene symbol given by HGNC nomenclature."
* value[x] only string
* valueString 1..1

// chromosome_id – Integer
Extension: TargetRegionChromosomeId
Id: target-region-chromosome-id
Title: "Chromosome ID"
Description: "Chromosome identifier (e.g. 1–22, 23=X, 24=Y, 25=MT)."
* value[x] only integer
* valueInteger 1..1

// start_position – Integer
Extension: TargetRegionStartPosition
Id: target-region-start-position
Title: "Start position"
Description: "Start position of the target region (genomic coordinate)."
* value[x] only integer
* valueInteger 1..1

// end_position – Integer
Extension: TargetRegionEndPosition
Id: target-region-end-position
Title: "End position"
Description: "End position of the target region (genomic coordinate)."
* value[x] only integer
* valueInteger 1..1

// ================================================
// Target Region profile (using Basic)
// ================================================

Profile: TargetRegion
Parent: Basic
Id: target-region
Title: "Target Region"
Description: "Target gene / genomic region associated with a genomic test platform."

// ------------------------------------------------
// target_region_id → Basic.identifier
//   Label: Target gene ID
//   Type: ID
// ------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Target gene ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/target-region-id" (exactly)
* identifier.value 1..1

// ------------------------------------------------
// Basic.code is required.
// Use it as a simple category for the target region.
// ------------------------------------------------
* code 1..1 MS
* code ^short = "Target region category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/target-region-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// ------------------------------------------------
// Attach Target Region–specific extensions
// ------------------------------------------------
* extension contains
    TargetRegionGenomicTestRef named genomicTestId 0..1 MS and
    TargetRegionHGNCId named hgncId 0..1 MS and
    TargetRegionHGNCSymbol named hgncSymbol 0..1 MS and
    TargetRegionChromosomeId named chromosomeId 0..1 MS and
    TargetRegionStartPosition named startPosition 0..1 MS and
    TargetRegionEndPosition named endPosition 0..1 MS

// Short labels
* extension[genomicTestId] ^short = "Genomic test ID (platform relationship)"
* extension[hgncId] ^short = "HGNC ID"
* extension[hgncSymbol] ^short = "HGNC symbol"
* extension[chromosomeId] ^short = "Chromosome ID"
* extension[startPosition] ^short = "Start position"
* extension[endPosition] ^short = "End position"

// ================================================
// Example Target Region instance
// ================================================

Instance: TargetRegionExample1
InstanceOf: TargetRegion
Usage: #example
Title: "Example Target Region"
Description: "Example target region linked to a genomic test."

* id = "target-region-example-1"

// target_region_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/target-region-id"
* identifier.value = "TR0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/target-region-type#gene-region "Gene-level target region"

// genomic_test_id
* extension[genomicTestId].valueReference = Reference(GenomicTestExample1)

// hgnc_id
* extension[hgncId].valueString = "HGNC:1100"

// hgnc_symbol
* extension[hgncSymbol].valueString = "BRCA1"

// chromosome_id
* extension[chromosomeId].valueInteger = 17

// start_position
* extension[startPosition].valueInteger = 43044295

// end_position
* extension[endPosition].valueInteger = 43125482
