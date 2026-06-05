## Example use-case: paediatric liver transplant journey (PROTECT-CHILD)

Mila (7) is registered as a transplant candidate ([Patient](StructureDefinition-pc-patient-lm.html)). During evaluation and waiting-list follow-up ([Visit](StructureDefinition-pc-visit-lm.html)), clinicians capture vitals and growth ([VitalSign](StructureDefinition-pc-vital-sign-lm.html), [ClinicalVariable](StructureDefinition-pc-clinical-variable-lm.html)), record lab tests and results ([LabTest](StructureDefinition-pc-lab-test-lm.html), [LabResult](StructureDefinition-pc-lab-result-lm.html)), document imaging and functional studies ([InstrumentalInvestigation](StructureDefinition-pc-instrumental-investigation-lm.html)), and monitor infectious serology ([Microbiology](StructureDefinition-pc-microbiology-lm.html)). Intercurrent episodes (e.g. cholangitis) are logged as clinical events ([ClinicalEventType](StructureDefinition-pc-clinical-event-type-lm.html), [ClinicalEvent](StructureDefinition-pc-clinical-event-lm.html)), alongside concomitant medications ([ConcomitantMedication](StructureDefinition-pc-concomitant-medication-lm.html)) and pre-transplant medications including desensitisation ([PreMedication](StructureDefinition-pc-pre-medication-lm.html)).

When a suitable organ becomes available ([Donor](StructureDefinition-pc-donor-lm.html)), the transplant procedure and operative details are recorded ([Transplant](StructureDefinition-pc-transplant-lm.html)). Post-operatively, induction and maintenance immunosuppression — including drug-level monitoring — are captured in a single unified record ([ImmPat](StructureDefinition-pc-imm-pat-lm.html)) referencing the immunosuppressant catalogue ([Immunosuppressant](StructureDefinition-pc-immunosuppressant-lm.html)). Post-transplant complications such as rejection, delayed graft function, and AKI episodes are represented as typed clinical events ([ClinicalEvent](StructureDefinition-pc-clinical-event-lm.html)). Blood group, Rh factor, HLA typing, DSA, and Banff grading are captured at each relevant visit ([ImmunologicalData](StructureDefinition-pc-immunological-data-lm.html)). Biosamples collected for biobanking are tracked as well ([BioSample](StructureDefinition-pc-bio-sample-lm.html)).

## Full list

- [BioSample](StructureDefinition-pc-bio-sample-lm.html)
- [ClinicalEvent](StructureDefinition-pc-clinical-event-lm.html)
- [ClinicalEventType](StructureDefinition-pc-clinical-event-type-lm.html)
- [ClinicalVariable](StructureDefinition-pc-clinical-variable-lm.html)
- [ConcomitantMedication](StructureDefinition-pc-concomitant-medication-lm.html)
- [Donor](StructureDefinition-pc-donor-lm.html)
- [ImmPat](StructureDefinition-pc-imm-pat-lm.html)
- [ImmunologicalData](StructureDefinition-pc-immunological-data-lm.html)
- [Immunosuppressant](StructureDefinition-pc-immunosuppressant-lm.html)
- [InstrumentalInvestigation](StructureDefinition-pc-instrumental-investigation-lm.html)
- [LabResult](StructureDefinition-pc-lab-result-lm.html)
- [LabTest](StructureDefinition-pc-lab-test-lm.html)
- [Microbiology](StructureDefinition-pc-microbiology-lm.html)
- [Patient](StructureDefinition-pc-patient-lm.html)
- [PreMedication](StructureDefinition-pc-pre-medication-lm.html)
- [Transplant](StructureDefinition-pc-transplant-lm.html)
- [Visit](StructureDefinition-pc-visit-lm.html)
- [VitalSign](StructureDefinition-pc-vital-sign-lm.html)
