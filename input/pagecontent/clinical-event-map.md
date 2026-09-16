{% include pc-clinical-event-profile.svg %}

# Clinical Event — Logical Model → FHIR Map

Primary profile: [ClinicalEvent](StructureDefinition-clinical-event.html) (`Condition`)  
Flag observations: [ClinicalEventFlagObservation](StructureDefinition-clinical-event-flag-observation.html) (`Observation`) — one per true *non-diagnosis* boolean flag (concomitant_medications, treatment_adherence); `focus = Reference(ClinicalEvent)`

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
| event_number | R | *(calculated; not stored)* |  |
| cause_death | O | `Condition.note[cause_death].text` |  |
| specify_kidney_rejection_episode | O | `Condition.note[specify_kidney_rejection_episode].text` |  **Kidney only** |
| previous_urological_intervention | O | `Condition.note[previous_urological_intervention].text` |  **Kidney only** |
| underlying_prothrombotic_disorders | O | `Condition.note[underlying_prothrombotic_disorders].text` |  |
| kidney_biopsy | O | `Condition.note[kidney_biopsy].text` |  **Kidney only** |
| vascular_complication_type | O | `Condition.evidence.code` | [VascularComplicationTypeVS](ValueSet-vascular-complication-type-vs.html) — coded value on the ClinicalEvent itself |
| dgf | O | `Condition.code` | First-class [ClinicalEvent](StructureDefinition-clinical-event.html); `ClinicalEventTypeCS#delayed-kidney-graft-function`; **Kidney only** |
| episodes_aki_after_ltx | O | `Condition.code` | First-class [ClinicalEvent](StructureDefinition-clinical-event.html); `ClinicalEventTypeCS#episodes-aki-after-ltx`; **Liver only** |
| histologic_evidence_cni_toxicity | O | `Condition.code` | First-class [ClinicalEvent](StructureDefinition-clinical-event.html); `ClinicalEventTypeCS#histologic-evidence-cni-toxicity` |
| hypoxic_ischemic_event_pltx | O | `Condition.code` | First-class [ClinicalEvent](StructureDefinition-clinical-event.html); `ClinicalEventTypeCS#hypoxic-ischemic-event-pltx`; **Liver only** |
| concomitant_medications | O | `ClinicalEventFlagObservation.code` | `ClinicalEventEvidenceCS#concomitant-medications` |
| treatment_adherence | O | `ClinicalEventFlagObservation.code` | `ClinicalEventEvidenceCS#treatment-adherence` |

## Linked Procedures

Sub-events that carry a coded type and a date are represented as [ClinicalEventProcedure](StructureDefinition-clinical-event-procedure.html) (`Procedure`) resources linked to the parent `ClinicalEvent` via `Procedure.reasonReference`.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| dialysis_type | O | `Procedure.code` | `ClinicalEventProcedureTypeCS#hemodialysis` or `#peritoneal-dialysis` |
| dialysis_start_date | O | `Procedure.performedPeriod.start` | |
| dialysis_end_date | O | `Procedure.performedPeriod.end` | |
| retransplantation | O | `Procedure.code` | `ClinicalEventProcedureTypeCS#retransplantation` — presence means true, absence means false |
| retransplantation_date | O | `Procedure.performedDateTime` | Date on the retransplantation Procedure |
| date_entry_transplant_list | O | `Procedure.performedDateTime` | `ClinicalEventProcedureTypeCS#transplant-listing` |
