

## Example use-case: paediatric liver transplant journey (PROTECT-CHILD)

Mila (7) is registered as a transplant candidate ([Patient](StructureDefinition-pc-patient-lm.html)). During evaluation and waiting-list follow-up visits ([Visit](StructureDefinition-pc-visit-lm.html)), clinicians capture vitals and growth ([PcClinicalVariable](StructureDefinition-pc-clinical-variable-lm.html)), order and record lab tests/results ([LabTest](StructureDefinition-pc-lab-test-lm.html), [LabResult](StructureDefinition-pc-lab-result-lm.html)), document imaging and other investigations ([PatInstInv](StructureDefinition-pc-pat-inst-inv-lm.html)), and record infection screening/monitoring relevant to transplant ([Microbiology](StructureDefinition-pc-microbiology-lm.html)). Any intercurrent episodes (e.g., cholangitis) and their treatments are logged ([ConcomitantEpisode](StructureDefinition-pc-concomitant-episode-lm.html), [ConcomitantMedication](StructureDefinition-pc-concomitant-medication-lm.html)), alongside her regular pre-transplant medications ([PreMedication](StructureDefinition-pc-pre-medication-lm.html)).
When a suitable donor organ becomes available ([Donor](StructureDefinition-pc-donor-lm.html)), the transplant procedure and key graft/operative details are recorded ([Transplant](StructureDefinition-pc-transplant-lm.html)). Post-operatively, induction and maintenance immunosuppression (and drug monitoring) are captured ([ImmIndPat](StructureDefinition-pc-imm-ind-pat-lm.html), [ImmMainPat](StructureDefinition-pc-imm-main-pat-lm.html)), and complications (e.g., Delayed Graft Function) are recorded as typed post-transplant events ([PostEventType](StructureDefinition-pc-post-event-type-lm.html), [PostEvent](StructureDefinition-pc-post-event-lm.html)). At longer-term follow-up (e.g., 1 year), Mila’s status is summarised as outcomes ([OutcomeType](StructureDefinition-pc-outcome-type-lm.html), [Outcome](StructureDefinition-pc-outcome-lm.html)).










<div style="max-width: 100%; overflow-x: auto; border: 1px solid #eee; padding: 0.5rem;">
  <div style="max-width: 1200px; margin: 0 auto;">
    {% include protect-child-model-overview.svg %}
  </div>
</div>

<style>
  /* Make any inline SVG inside this page scale to container */
  svg { max-width: 100% !important; height: auto !important; }
</style>

### Full list


- [BioSample](StructureDefinition-pc-bio-sample-lm.html)
- [ClinicalVariable](StructureDefinition-pc-clinical-variable-lm.html)
- [ConcomitantDisease](StructureDefinition-pc-concomitant-disease-lm.html)
- [ConcomitantEpisode](StructureDefinition-pc-concomitant-episode-lm.html)
- [ConcomitantMedication](StructureDefinition-pc-concomitant-medication-lm.html)
- [Donor](StructureDefinition-pc-donor-lm.html)
- [EpigenomeStudy](StructureDefinition-pc-epigenome-study-lm.html)
- [GenomicTest](StructureDefinition-pc-genomic-test-lm.html)
- [ImmIndPat](StructureDefinition-pc-imm-ind-pat-lm.html)
- [ImmMainPat](StructureDefinition-pc-imm-main-pat-lm.html)
- [Immunosuppressant](StructureDefinition-pc-immunosuppressant-lm.html)
- [InstrumentalInvestigation](StructureDefinition-pc-instrumental-investigation-lm.html)
- [LabResult](StructureDefinition-pc-lab-result-lm.html)
- [LabTest](StructureDefinition-pc-lab-test-lm.html)
- [MarkImmFunc](StructureDefinition-pc-mark-imm-func-lm.html)
- [MethylomicStudy](StructureDefinition-pc-methylomic-study-lm.html)
- [Microbiology](StructureDefinition-pc-microbiology-lm.html)
- [Outcome](StructureDefinition-pc-outcome-lm.html)
- [OutcomeType](StructureDefinition-pc-outcome-type-lm.html)
- [Patient](StructureDefinition-pc-patient-lm.html)
- [PatInstInv](StructureDefinition-pc-pat-inst-inv-lm.html)
- [PostEvent](StructureDefinition-pc-post-event-lm.html)
- [PostEventType](StructureDefinition-pc-post-event-type-lm.html)
- [PreMedication](StructureDefinition-pc-pre-medication-lm.html)
- [ReferenceGenome](StructureDefinition-pc-reference-genome-lm.html)
- [TargetRegion](StructureDefinition-pc-target-region-lm.html)
- [Transplant](StructureDefinition-pc-transplant-lm.html)
- [Unit](StructureDefinition-pc-unit-lm.html)
- [VariantAnnotation](StructureDefinition-pc-variant-annotation-lm.html)
- [VariantOccurrence](StructureDefinition-pc-variant-occurrence-lm.html)
- [Visit](StructureDefinition-pc-visit-lm.html)
