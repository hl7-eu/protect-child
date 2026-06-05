{% include pc-biosample-profile.svg %}

# BioSample — Logical Model → FHIR Map

Primary profile: [BioSample](StructureDefinition-biosample.html) (`Specimen`)  
Analysis requests: [BioSampleAnalysisRequest](StructureDefinition-biosample-analysis-request.html) (`ServiceRequest`) — one per analysis type per sample

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| bio_sample_id | M | `Specimen.identifier.value` | |
| patient_id | M | `Specimen.subject` | Direct [Reference(PatientTransplant)](StructureDefinition-patient-transplant.html) — enables `Specimen?patient={id}` queries directly. *(Not a DM field; derived from `visit.patient_id` to support direct FHIR queries on Specimen.)* |
| visit_id | M | `Specimen.extension[visit_id]` | [BioSampleVisitRef](StructureDefinition-biosample-visit-ref.html); extension required — R4 `Specimen` has no native encounter element. |
| collection_date | R | `Specimen.collection.collectedDateTime` | |
| send_ingemm_date | R | `Specimen.receivedTime` | Native R4 field for the date/time a specimen is received at the processing facility (INGEMM). |
| genomic_sample | R | `ServiceRequest.code` = `BioSampleAnalysisTypeCS#genomic` | [BioSampleAnalysisRequest](StructureDefinition-biosample-analysis-request.html) with `specimen = Reference(BioSample)`; omit ServiceRequest when false |
| epigenomic_sample | R | `ServiceRequest.code` = `BioSampleAnalysisTypeCS#epigenomic` | [BioSampleAnalysisRequest](StructureDefinition-biosample-analysis-request.html) with `specimen = Reference(BioSample)`; omit ServiceRequest when false |

> Raw genomic and epigenomic data (variant calls, methylation arrays) are out of scope for this IG. `BioSampleAnalysisRequest` provides a semantically correct work-order link from the clinical record to biobanked samples. `Specimen.type` is left free for actual specimen material coding (blood, tissue, etc.).
