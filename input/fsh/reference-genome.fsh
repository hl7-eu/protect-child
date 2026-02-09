// ================================================
// Reference Genome – profile, terminology & extension
// ================================================

// ================================================
// Terminology – build_name (GRCh38 / GRCh37)
// ================================================

CodeSystem: ReferenceGenomeBuildCS
Id: reference-genome-build-cs
Title: "Reference Genome Build CodeSystem"
Description: "Reference genome build names."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/reference-genome-build"
* ^content = #complete
* #GRCh38 "GRCh38"
* #GRCh37 "GRCh37"

ValueSet: ReferenceGenomeBuildVS
Id: reference-genome-build-vs
Title: "Reference Genome Build ValueSet"
Description: "Allowed reference genome build names (GRCh38, GRCh37)."
* ReferenceGenomeBuildCS#GRCh38
* ReferenceGenomeBuildCS#GRCh37

// ================================================
// fasta_path extension
// ================================================

Extension: ReferenceGenomeFastaPath
Id: reference-genome-fasta-path
Title: "Reference genome FASTA path"
Description: "Filesystem or URI path of the reference genome FASTA file."
* value[x] only string
* valueString 1..1

// ================================================
// Reference Genome profile (using Basic)
// ================================================

Profile: ReferenceGenome
Parent: Basic
Id: reference-genome
Title: "Reference Genome"
Description: "Reference genome definition used by genomic tests, including build_name and FASTA path."

// reference_genome_id → Basic.identifier (M)
* identifier 1..1 MS
* identifier ^short = "reference_genome_id – identifier for the reference genome"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/reference-genome-id" (exactly)
* identifier.value 1..1

// build_name → Basic.code (M, GRCh38 / GRCh37)
* code 1..1 MS
* code ^short = "build_name – reference genome build name"
* code ^binding.strength = #required
* code ^binding.valueSet = Canonical(ReferenceGenomeBuildVS)

// Attach FASTA path extension
* extension contains ReferenceGenomeFastaPath named fasta_path 0..1 MS
* extension[fasta_path] ^short = "fasta_path – filesystem or URI of the reference genome FASTA"

// ================================================
// Example Reference Genome instance
// ================================================

Instance: ReferenceGenomeExampleGRCh38
InstanceOf: ReferenceGenome
Usage: #example
Title: "Example Reference Genome GRCh38"
Description: "Example GRCh38 reference genome used for genomic tests."

* id = "reference-genome-grch38"

// reference_genome_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/reference-genome-id"
* identifier.value = "RG0001"

// build_name
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/reference-genome-build#GRCh38 "GRCh38"

// fasta_path
* extension[fasta_path].valueString = "/data/genomes/GRCh38/GRCh38.fa"
