## Example use-case: paediatric liver transplant journey (PROTECT-CHILD)

Mila (7) is registered as a transplant candidate ([Patient](StructureDefinition-pcPatientLm.html)). During evaluation and waiting-list follow-up ([Visit](StructureDefinition-pcVisitLm.html)), clinicians capture vitals and growth ([VitalSign](StructureDefinition-pcVitalSignLm.html), [ClinicalVariable](StructureDefinition-pcClinicalVariableLm.html)), record lab tests and results ([LabTest](StructureDefinition-pcLabTestLm.html), [LabResult](StructureDefinition-pcLabResultLm.html)), document imaging and functional studies ([InstrumentalInvestigation](StructureDefinition-pcInstrumentalInvestigationLm.html)), and monitor infectious serology ([Microbiology](StructureDefinition-pcMicrobiologyLm.html)). Intercurrent episodes (e.g. cholangitis) are logged as clinical events ([ClinicalEventType](StructureDefinition-pcClinicalEventTypeLm.html), [ClinicalEvent](StructureDefinition-pcClinicalEventLm.html)), alongside concomitant medications ([ConcomitantMedication](StructureDefinition-pcConcomitantMedicationLm.html)) and pre-transplant medications including desensitisation ([PreMedication](StructureDefinition-pcPreMedicationLm.html)).

When a suitable organ becomes available ([Donor](StructureDefinition-pcDonorLm.html)), the transplant procedure and operative details are recorded ([Transplant](StructureDefinition-pcTransplantLm.html)). Post-operatively, induction and maintenance immunosuppression — including drug-level monitoring — are captured in a single unified record ([ImmPat](StructureDefinition-pcImmPatLm.html)) referencing the immunosuppressant catalogue ([Immunosuppressant](StructureDefinition-pcImmunosuppressantLm.html)). Post-transplant complications such as rejection, delayed graft function, and AKI episodes are represented as typed clinical events ([ClinicalEvent](StructureDefinition-pcClinicalEventLm.html)). Blood group, Rh factor, HLA typing, DSA, and Banff grading are captured at each relevant visit ([ImmunologicalData](StructureDefinition-pcImmunologicalDataLm.html)). Biosamples collected for biobanking are tracked as well ([BioSample](StructureDefinition-pcBioSampleLm.html)).

## Full list

- [BioSample](StructureDefinition-pcBioSampleLm.html)
- [ClinicalEvent](StructureDefinition-pcClinicalEventLm.html)
- [ClinicalEventType](StructureDefinition-pcClinicalEventTypeLm.html)
- [ClinicalVariable](StructureDefinition-pcClinicalVariableLm.html)
- [ConcomitantMedication](StructureDefinition-pcConcomitantMedicationLm.html)
- [Donor](StructureDefinition-pcDonorLm.html)
- [ImmPat](StructureDefinition-pcImmPatLm.html)
- [ImmunologicalData](StructureDefinition-pcImmunologicalDataLm.html)
- [Immunosuppressant](StructureDefinition-pcImmunosuppressantLm.html)
- [InstrumentalInvestigation](StructureDefinition-pcInstrumentalInvestigationLm.html)
- [LabResult](StructureDefinition-pcLabResultLm.html)
- [LabTest](StructureDefinition-pcLabTestLm.html)
- [Microbiology](StructureDefinition-pcMicrobiologyLm.html)
- [Patient](StructureDefinition-pcPatientLm.html)
- [PreMedication](StructureDefinition-pcPreMedicationLm.html)
- [Transplant](StructureDefinition-pcTransplantLm.html)
- [Visit](StructureDefinition-pcVisitLm.html)
- [VitalSign](StructureDefinition-pcVitalSignLm.html)
