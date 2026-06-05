// ================================================
// BioSample – profile & terminology
// ================================================

// ================================================
// Terminology — analysis type
// genomic_sample and epigenomic_sample DM booleans are represented as
// BioSampleAnalysisRequest (ServiceRequest) resources with specimen = Reference(BioSample).
// ================================================

CodeSystem: BioSampleAnalysisTypeCS
Id: biosample-analysis-type-cs
Title: "Biological Sample Analysis Type"
Description: "Intended omics analysis type for a biological sample. Used as the ServiceRequest.code on BioSampleAnalysisRequest resources."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/biosample-analysis-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #genomic    "Genomic analysis"
* #epigenomic "Epigenomic analysis"

ValueSet: BioSampleAnalysisTypeVS
Id: biosample-analysis-type-vs
Title: "Biological Sample Analysis Type ValueSet"
Description: "Allowed analysis type codes for BioSampleAnalysisRequest.code."
* BioSampleAnalysisTypeCS#genomic
* BioSampleAnalysisTypeCS#epigenomic

// ================================================
// Extension — visit_id only
// ================================================

Extension: BioSampleVisitRef
Id: biosample-visit-ref
Title: "Visit reference"
Description: "visit_id – reference to the Visit during which this sample was collected."
* value[x] only Reference(Visit)
* valueReference 1..1
* ^context[0].type = #element
* ^context[0].expression = "Specimen"

// ================================================
// BioSample profile (Specimen)
// ================================================

Profile: BioSample
Parent: Specimen
Id: biosample
Title: "Biological Sample"
Description: "Biological sample linked to a transplant visit, aligned with the DMv1.2 bio_sample table. Patient navigable via Specimen.subject. Visit linked via extension[visit_id]. Analysis intent (genomic_sample / epigenomic_sample) is represented as BioSampleAnalysisRequest (ServiceRequest) resources with specimen = Reference(BioSample). send_ingemm_date maps to the native Specimen.receivedTime."

// bio_sample_id → Specimen.identifier (M)
* identifier 1..1 MS
* identifier ^short = "bio_sample_id – primary identifier for the biological sample"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/biosample-id" (exactly)
* identifier.value 1..1

// patient_id → Specimen.subject (M)
// Direct link to the recipient — enables Specimen?patient={id} queries without
// a two-hop traversal through the Visit extension.
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id – transplant recipient who provided this sample"

// collection_date → Specimen.collection.collectedDateTime (R)
* collection 0..1 MS
* collection ^short = "Sample collection details"
* collection.collected[x] 0..1
* collection.collected[x] only dateTime
* collection.collectedDateTime ^short = "collection_date – sample collection date"

// send_ingemm_date → Specimen.receivedTime (R)
// Native R4 field for the date/time a specimen was received at the processing facility.
* receivedTime 0..1 MS
* receivedTime ^short = "send_ingemm_date – date the sample was received at INGEMM"

// Specimen.type — free for actual specimen material (blood, tissue, urine, etc.)
// Analysis intent (genomic_sample / epigenomic_sample) is in BioSampleAnalysisRequest.
* type 0..1 MS
* type ^short = "Specimen material type (blood, tissue, urine, etc.) — NOT analysis intent"

// visit_id → extension (no native encounter reference on Specimen in R4)
* extension contains BioSampleVisitRef named visit_id 1..1 MS
* extension[visit_id] ^short = "visit_id – Visit during which this sample was collected"

// ================================================
// Example BioSample instance
// ================================================

Instance: BioSampleExample1
InstanceOf: BioSample
Usage: #example
Title: "Example Biological Sample"
Description: "Example biological sample aligned with DMv1.2. genomic_sample=true, epigenomic_sample=false."

* id = "biosample-example-1"

// bio_sample_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/biosample-id"
* identifier.value = "BS0001"

// visit_id
* extension[visit_id].valueReference = Reference(VisitExample1)

// collection_date
* collection.collectedDateTime = "2025-01-15"

// send_ingemm_date → receivedTime
* receivedTime = "2025-01-20"

// specimen material type (free-text or coded — no fixed binding)
* subject = Reference(ExamplePatientTransplant1)

// ================================================
// BioSampleAnalysisRequest profile (ServiceRequest)
// Represents genomic_sample and epigenomic_sample boolean flags as explicit
// work-order resources. One ServiceRequest per analysis type per BioSample.
// genomic_sample = true  → ServiceRequest with code = BioSampleAnalysisTypeCS#genomic
// epigenomic_sample = true → ServiceRequest with code = BioSampleAnalysisTypeCS#epigenomic
// ================================================

Profile: BioSampleAnalysisRequest
Parent: ServiceRequest
Id: biosample-analysis-request
Title: "Biological Sample Analysis Request"
Description: "A work order representing the intent to perform omics analysis (genomic or epigenomic) on a BioSample. One instance per analysis type per sample. Analysis intent (genomic_sample / epigenomic_sample) is carried here as ServiceRequest.code; Specimen.type remains free for specimen material type. specimen = Reference(BioSample)."

* status 1..1 MS
* status ^short = "Use #active for samples awaiting analysis, #completed for processed samples"

* intent 1..1 MS
* intent = #order (exactly)
* intent ^short = "Fixed to #order — each request is an analysis work order"

// Analysis type — which omics pipeline is requested
* code 1..1 MS
* code from BioSampleAnalysisTypeVS (required)
* code ^short = "genomic_sample / epigenomic_sample — analysis type (BioSampleAnalysisTypeVS)"

// Patient link
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient who provided the sample"

// Sample link
* specimen 1..1 MS
* specimen only Reference(BioSample)
* specimen ^short = "The BioSample to be analysed"

// Visit link (optional — for direct searchability)
* encounter 0..1 MS
* encounter only Reference(Visit)
* encounter ^short = "Visit at which this sample was collected (navigable via specimen → BioSample extension)"


// ================================================
// Example — genomic analysis request
// ================================================

Instance: BioSampleGenomicRequest1
InstanceOf: BioSampleAnalysisRequest
Usage: #example
Title: "Example genomic analysis request"
Description: "ServiceRequest representing genomic_sample = true for BioSampleExample1."

* status = #active
* intent = #order
* code = BioSampleAnalysisTypeCS#genomic "Genomic analysis"
* subject = Reference(ExamplePatientTransplant1)
* specimen = Reference(BioSampleExample1)
* encounter = Reference(VisitExample1)
