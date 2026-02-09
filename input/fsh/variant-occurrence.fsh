// ================================================
// Variant Occurrence – extensions & profile
// ================================================

// ================================================
// Extensions
// ================================================

// target_region_id – ElementReference(TargetRegion)
Extension: VariantOccurrenceTargetRegionRef
Id: variant-occurrence-target-region-ref
Title: "Target region ID relationship"
Description: "Reference to the target region (gene/region) for which the variant information is recorded."
* value[x] only Reference(TargetRegion)
* valueReference 1..1

// reference_sequence – String
Extension: VariantOccurrenceReferenceSequence
Id: variant-occurrence-reference-sequence
Title: "Reference sequence"
Description: "Transcript ID based on a protein-coding RNA (mRNA), including accession and version number."
* value[x] only string
* valueString 1..1

// rs_id – String
Extension: VariantOccurrenceRsId
Id: variant-occurrence-rs-id
Title: "dbSNP rsID"
Description: "dbSNP reference ID (rsID) maintained by NCBI."
* value[x] only string
* valueString 1..1

// reference_allele – String
Extension: VariantOccurrenceReferenceAllele
Id: variant-occurrence-reference-allele
Title: "Reference allele"
Description: "Reference allele sequence (e.g., A)."
* value[x] only string
* valueString 1..1

// alternate_allele – String
Extension: VariantOccurrenceAlternateAllele
Id: variant-occurrence-alternate-allele
Title: "Alternate allele"
Description: "Variant allele sequence (e.g., C)."
* value[x] only string
* valueString 1..1

// hgvs_c – String
Extension: VariantOccurrenceHgvsC
Id: variant-occurrence-hgvs-c
Title: "HGVS c. notation"
Description: "Nomenclature for the sequence variant at the DNA level (HGVS c. notation)."
* value[x] only string
* valueString 1..1

// hgvs_p – String
Extension: VariantOccurrenceHgvsP
Id: variant-occurrence-hgvs-p
Title: "HGVS p. notation"
Description: "Nomenclature for the sequence variant at the protein level (HGVS p. notation)."
* value[x] only string
* valueString 1..1

// variant_read_depth – Integer
Extension: VariantOccurrenceVariantReadDepth
Id: variant-occurrence-variant-read-depth
Title: "Variant read depth"
Description: "Variant depth divided by read depth."
* value[x] only integer
* valueInteger 1..1

// variant_exon_number – Integer
Extension: VariantOccurrenceVariantExonNumber
Id: variant-occurrence-variant-exon-number
Title: "Variant exon number"
Description: "Exon number in which the variant occurred."
* value[x] only integer
* valueInteger 1..1

// copy_number – Float (decimal)
Extension: VariantOccurrenceCopyNumber
Id: variant-occurrence-copy-number
Title: "Copy number"
Description: "Copy number value for CNV data."
* value[x] only decimal
* valueDecimal 1..1

// cnv_locus – String
Extension: VariantOccurrenceCnvLocus
Id: variant-occurrence-cnv-locus
Title: "CNV locus"
Description: "Locus information for CNV."
* value[x] only string
* valueString 1..1

// fusion_breakpoint – String
Extension: VariantOccurrenceFusionBreakpoint
Id: variant-occurrence-fusion-breakpoint
Title: "Fusion breakpoint"
Description: "Genomic position where a fusion variant occurs."
* value[x] only string
* valueString 1..1

// fusion_supporting_reads – Integer
Extension: VariantOccurrenceFusionSupportingReads
Id: variant-occurrence-fusion-supporting-reads
Title: "Fusion supporting reads"
Description: "Supporting read count of the fusion."
* value[x] only integer
* valueInteger 1..1

// sequence_alteration – String
Extension: VariantOccurrenceSequenceAlteration
Id: variant-occurrence-sequence-alteration
Title: "Sequence alteration"
Description: "Structural variant type."
* value[x] only string
* valueString 1..1

// variant_feature – String
Extension: VariantOccurrenceVariantFeature
Id: variant-occurrence-variant-feature
Title: "Variant feature"
Description: "Functional variant type."
* value[x] only string
* valueString 1..1

// genetic_origin – String
Extension: VariantOccurrenceGeneticOrigin
Id: variant-occurrence-genetic-origin
Title: "Genetic origin"
Description: "Somatic or germline origin of the variant."
* value[x] only string
* valueString 1..1

// genotype – String
Extension: VariantOccurrenceGenotype
Id: variant-occurrence-genotype
Title: "Genotype"
Description: "Allele state."
* value[x] only string
* valueString 1..1


// ================================================
// Variant Occurrence profile (using Basic)
// ================================================

Profile: VariantOccurrence
Parent: Basic
Id: variant-occurrence
Title: "Variant Occurrence"
Description: "Variant occurrence information within a target region."

// ------------------------------------------------
// variant_occurrence_id → Basic.identifier
//   Label: Variant occurrence ID
//   Type: ID
// ------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Variant occurrence ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/variant-occurrence-id" (exactly)
* identifier.value 1..1

// ------------------------------------------------
// Basic.code is required.
// Use it as a simple category of variant.
// ------------------------------------------------
* code 1..1 MS
* code ^short = "Variant occurrence category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/variant-occurrence-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// ------------------------------------------------
// Attach Variant Occurrence–specific extensions
// ------------------------------------------------
* extension contains
    VariantOccurrenceTargetRegionRef named targetRegionId 0..1 MS and
    VariantOccurrenceReferenceSequence named referenceSequence 0..1 MS and
    VariantOccurrenceRsId named rsId 0..1 MS and
    VariantOccurrenceReferenceAllele named referenceAllele 0..1 MS and
    VariantOccurrenceAlternateAllele named alternateAllele 0..1 MS and
    VariantOccurrenceHgvsC named hgvsC 0..1 MS and
    VariantOccurrenceHgvsP named hgvsP 0..1 MS and
    VariantOccurrenceVariantReadDepth named variantReadDepth 0..1 MS and
    VariantOccurrenceVariantExonNumber named variantExonNumber 0..1 MS and
    VariantOccurrenceCopyNumber named copyNumber 0..1 MS and
    VariantOccurrenceCnvLocus named cnvLocus 0..1 MS and
    VariantOccurrenceFusionBreakpoint named fusionBreakpoint 0..1 MS and
    VariantOccurrenceFusionSupportingReads named fusionSupportingReads 0..1 MS and
    VariantOccurrenceSequenceAlteration named sequenceAlteration 0..1 MS and
    VariantOccurrenceVariantFeature named variantFeature 0..1 MS and
    VariantOccurrenceGeneticOrigin named geneticOrigin 0..1 MS and
    VariantOccurrenceGenotype named genotype 0..1 MS

// Short labels
* extension[targetRegionId] ^short = "Target region ID relationship"
* extension[referenceSequence] ^short = "Reference sequence"
* extension[rsId] ^short = "dbSNP rsID"
* extension[referenceAllele] ^short = "Reference allele"
* extension[alternateAllele] ^short = "Alternate allele"
* extension[hgvsC] ^short = "HGVS c. notation"
* extension[hgvsP] ^short = "HGVS p. notation"
* extension[variantReadDepth] ^short = "Variant read depth"
* extension[variantExonNumber] ^short = "Variant exon number"
* extension[copyNumber] ^short = "Copy number"
* extension[cnvLocus] ^short = "CNV locus"
* extension[fusionBreakpoint] ^short = "Fusion breakpoint"
* extension[fusionSupportingReads] ^short = "Fusion supporting reads"
* extension[sequenceAlteration] ^short = "Sequence alteration"
* extension[variantFeature] ^short = "Variant feature"
* extension[geneticOrigin] ^short = "Genetic origin"
* extension[genotype] ^short = "Genotype"


// ================================================
// Example Variant Occurrence instance
// ================================================

Instance: VariantOccurrenceExample1
InstanceOf: VariantOccurrence
Usage: #example
Title: "Example Variant Occurrence"
Description: "Example variant occurrence linked to a target region."

* id = "variant-occurrence-example-1"

// variant_occurrence_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/variant-occurrence-id"
* identifier.value = "VO0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/variant-occurrence-type#snv "Single nucleotide variant"

// target_region_id
* extension[targetRegionId].valueReference = Reference(TargetRegionExample1)

// reference_sequence
* extension[referenceSequence].valueString = "NM_007294.4"

// rs_id
* extension[rsId].valueString = "rs80357713"

// reference_allele
* extension[referenceAllele].valueString = "A"

// alternate_allele
* extension[alternateAllele].valueString = "C"

// hgvs_c
* extension[hgvsC].valueString = "c.5266dupC"

// hgvs_p
* extension[hgvsP].valueString = "p.(Gln1756Profs*74)"

// variant_read_depth
* extension[variantReadDepth].valueInteger = 120

// variant_exon_number
* extension[variantExonNumber].valueInteger = 20

// copy_number
* extension[copyNumber].valueDecimal = 2.0

// cnv_locus
* extension[cnvLocus].valueString = "chr17:43044295-43125482"

// fusion_breakpoint
* extension[fusionBreakpoint].valueString = "NA"

// fusion_supporting_reads
* extension[fusionSupportingReads].valueInteger = 0

// sequence_alteration
* extension[sequenceAlteration].valueString = "missense_variant"

// variant_feature
* extension[variantFeature].valueString = "pathogenic_variant"

// genetic_origin
* extension[geneticOrigin].valueString = "somatic"

// genotype
* extension[genotype].valueString = "heterozygous"
