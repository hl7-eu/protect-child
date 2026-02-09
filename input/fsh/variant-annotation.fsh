// ================================================
// Variant Annotation – extensions & profile
// ================================================

// ================================================
// Extensions
// ================================================

// variant_occurrence_id – ElementReference(VariantOccurrence)
Extension: VariantAnnotationVariantOccurrenceRef
Id: variant-annotation-variant-occurrence-ref
Title: "Variant occurrence ID relationship"
Description: "Reference to the variant occurrence this annotation refers to."
* value[x] only Reference(VariantOccurrence)
* valueReference 1..1

// annotation_database – String
Extension: VariantAnnotationAnnotationDatabase
Id: variant-annotation-annotation-database
Title: "Annotation database"
Description: "Database used for this variant annotation."
* value[x] only string
* valueString 1..1

// variant_origin – String
Extension: VariantAnnotationVariantOrigin
Id: variant-annotation-variant-origin
Title: "Variant origin"
Description: "Origin of the variant (e.g., inherited, de novo, somatic)."
* value[x] only string
* valueString 1..1

// variant_pathogeny – String
Extension: VariantAnnotationVariantPathogeny
Id: variant-annotation-variant-pathogeny
Title: "Variant pathogenicity"
Description: "Pathogenicity assessment (e.g., pathogenic, likely pathogenic, VUS, benign)."
* value[x] only string
* valueString 1..1

// variant_class_level – String
Extension: VariantAnnotationVariantClassLevel
Id: variant-annotation-variant-class-level
Title: "Variant class level"
Description: "Classification level for the variant."
* value[x] only string
* valueString 1..1

// variant_tier_level – String
Extension: VariantAnnotationVariantTierLevel
Id: variant-annotation-variant-tier-level
Title: "Variant tier level"
Description: "Tier level for the variant (e.g., Tier 1, Tier 2)."
* value[x] only string
* valueString 1..1

// allele_frequency – Float (decimal)
Extension: VariantAnnotationAlleleFrequency
Id: variant-annotation-allele-frequency
Title: "Allele frequency"
Description: "Allele frequency for the variant."
* value[x] only decimal
* valueDecimal 1..1

// medication – String
Extension: VariantAnnotationMedication
Id: variant-annotation-medication
Title: "Medication"
Description: "Medication(s) relevant to this variant annotation."
* value[x] only string
* valueString 1..1


// ================================================
// Variant Annotation profile (using Basic)
// ================================================

Profile: VariantAnnotation
Parent: Basic
Id: variant-annotation
Title: "Variant Annotation"
Description: "Annotation of a variant occurrence using external databases and classifications."

// ------------------------------------------------
// variant_annotation_id → Basic.identifier
//   Type: ID
// ------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Variant annotation ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/variant-annotation-id" (exactly)
* identifier.value 1..1

// ------------------------------------------------
// Basic.code required.
// Use as a simple annotation category.
// ------------------------------------------------
* code 1..1 MS
* code ^short = "Variant annotation category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/variant-annotation-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// ------------------------------------------------
// Attach Variant Annotation–specific extensions
// ------------------------------------------------
* extension contains
    VariantAnnotationVariantOccurrenceRef named variantOccurrenceId 0..1 MS and
    VariantAnnotationAnnotationDatabase named annotationDatabase 0..1 MS and
    VariantAnnotationVariantOrigin named variantOrigin 0..1 MS and
    VariantAnnotationVariantPathogeny named variantPathogeny 0..1 MS and
    VariantAnnotationVariantClassLevel named variantClassLevel 0..1 MS and
    VariantAnnotationVariantTierLevel named variantTierLevel 0..1 MS and
    VariantAnnotationAlleleFrequency named alleleFrequency 0..1 MS and
    VariantAnnotationMedication named medication 0..1 MS

// Short labels
* extension[variantOccurrenceId] ^short = "Variant occurrence ID relationship"
* extension[annotationDatabase] ^short = "Annotation database"
* extension[variantOrigin] ^short = "Variant origin"
* extension[variantPathogeny] ^short = "Variant pathogenicity"
* extension[variantClassLevel] ^short = "Variant class level"
* extension[variantTierLevel] ^short = "Variant tier level"
* extension[alleleFrequency] ^short = "Allele frequency"
* extension[medication] ^short = "Medication"


// ================================================
// Example Variant Annotation instance
// ================================================

Instance: VariantAnnotationExample1
InstanceOf: VariantAnnotation
Usage: #example
Title: "Example Variant Annotation"
Description: "Example annotation for a variant occurrence."

* id = "variant-annotation-example-1"

// variant_annotation_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/variant-annotation-id"
* identifier.value = "VA0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/variant-annotation-type#clinical "Clinical variant annotation"

// variant_occurrence_id
* extension[variantOccurrenceId].valueReference = Reference(VariantOccurrenceExample1)

// annotation_database
* extension[annotationDatabase].valueString = "ClinVar"

// variant_origin
* extension[variantOrigin].valueString = "germline"

// variant_pathogeny
* extension[variantPathogeny].valueString = "pathogenic"

// variant_class_level
* extension[variantClassLevel].valueString = "ACMG Class 5"

// variant_tier_level
* extension[variantTierLevel].valueString = "Tier 1"

// allele_frequency
* extension[alleleFrequency].valueDecimal = 0.0001

// medication
* extension[medication].valueString = "PARP inhibitor"
