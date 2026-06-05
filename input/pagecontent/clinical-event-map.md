{% include pc-clinical-event-profile.svg %}

# Clinical Event — Logical Model → FHIR Map

Primary profile: [ClinicalEvent](StructureDefinition-clinical-event.html) (`Condition`)  
Flag observations: [ClinicalEventFlagObservation](StructureDefinition-clinical-event-flag-observation.html) (`Observation`) — one per true boolean flag; `focus = Reference(ClinicalEvent)`

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

Clinical events represent post-transplant complications, rejection episodes, graft failure, re-transplantation, and mortality. The 26-value event type vocabulary is defined in [ClinicalEventTypeCS](CodeSystem-clinical-event-type-cs.html) / [ClinicalEventTypeVS](ValueSet-clinical-event-type-vs.html).

Event lifecycle (start vs. end) is captured via native `Condition` status and onset/abatement:

- **START** → `Condition.onsetDateTime` + `Condition.clinicalStatus = #active`
- **END** → `Condition.abatementDateTime` + `Condition.clinicalStatus = #resolved`

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| clinical_event_id | M | `Condition.identifier.value` | |
| clinical_event_type_id | M | `Condition.code` | [ClinicalEventTypeVS](ValueSet-clinical-event-type-vs.html) |
| visit_id | M | `Condition.encounter` | |
| event_phase = START | R | `Condition.onsetDateTime` | Sets `clinicalStatus = #active` |
| event_phase = END | R | `Condition.abatementDateTime` | Sets `clinicalStatus = #resolved` |
| event_number | R | *(calculated; not stored)* | Auto-incremental per patient — not persisted in FHIR |
| cause_death | O | `Condition.note[cause_death].text` | `authorString = "cause_death"` |
| specify_kidney_rejection_episode | O | `Condition.note[specify_kidney_rejection_episode].text` | `authorString = "specify_kidney_rejection_episode"`; **Kidney only** |
| previous_urological_intervention | O | `Condition.note[previous_urological_intervention].text` | `authorString = "previous_urological_intervention"`; **Kidney only** |
| underlying_prothrombotic_disorders | O | `Condition.note[underlying_prothrombotic_disorders].text` | `authorString = "underlying_prothrombotic_disorders"` |
| kidney_biopsy | O | `Condition.note[kidney_biopsy].text` | `authorString = "kidney_biopsy"`; **Kidney only** |
| vascular_complication_type | O | `Condition.evidence.code` | [VascularComplicationTypeVS](ValueSet-vascular-complication-type-vs.html) — coded value on the ClinicalEvent itself |
| dgf | O | `ClinicalEventFlagObservation.code` | `ClinicalEventEvidenceCS#dgf`; presence = true, absence = false; **Kidney only** |
| episodes_aki_after_ltx | O | `ClinicalEventFlagObservation.code` | `ClinicalEventEvidenceCS#episodes-aki-after-ltx`; **Liver only** |
| histologic_evidence_cni_toxicity | O | `ClinicalEventFlagObservation.code` | `ClinicalEventEvidenceCS#histologic-evidence-cni-tox` |
| hypoxic_ischemic_event_pltx | O | `ClinicalEventFlagObservation.code` | `ClinicalEventEvidenceCS#hypoxic-ischemic-pltx`; **Liver only** |
| concomitant_medications | O | `ClinicalEventFlagObservation.code` | `ClinicalEventEvidenceCS#concomitant-medications` |
| treatment_adherence | O | `ClinicalEventFlagObservation.code` | `ClinicalEventEvidenceCS#treatment-adherence` |

### Linked Procedures

Sub-events that carry a coded type and a date are represented as [ClinicalEventProcedure](StructureDefinition-clinical-event-procedure.html) (`Procedure`) resources linked to the parent `ClinicalEvent` via `Procedure.reasonReference`. Query: `Procedure?reason-reference={clinical-event-id}&code={type}`.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| dialysis_type | O | `Procedure.code` | `ClinicalEventProcedureTypeCS#hemodialysis` or `#peritoneal-dialysis` |
| dialysis_start_date | O | `Procedure.performedPeriod.start` | |
| dialysis_end_date | O | `Procedure.performedPeriod.end` | |
| retransplantation | O | `Procedure.code` | `ClinicalEventProcedureTypeCS#retransplantation` — presence means true, absence means false |
| retransplantation_date | O | `Procedure.performedDateTime` | Date on the retransplantation Procedure |
| date_entry_transplant_list | O | `Procedure.performedDateTime` | `ClinicalEventProcedureTypeCS#transplant-listing` |
