{% include pc-clinical-event-type-profile.svg %}

# Clinical Event Type — Logical Model → FHIR Map

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

`ClinicalEventType` is a lookup / catalogue entity. Each record defines one named type of post-transplant clinical event. Instances are referenced by `ClinicalEvent.clinical_event_type_id`.

In FHIR this catalogue is represented as a `CodeSystem` + `ValueSet` pair rather than as individual resource instances, because the vocabulary is fixed and small.

| DM field | Card. | FHIR representation | Notes |
|---|---|---|---|
| clinical_event_type_id | M | `CodeSystem-clinical-event-type-cs` concept `code` | Identifier within the code system |
| name | M | `CodeSystem-clinical-event-type-cs` concept `display` | Human-readable label for the event type |

**Code system:** [ClinicalEventTypeCS](CodeSystem-clinical-event-type-cs.html)  
**Value set:** [ClinicalEventTypeVS](ValueSet-clinical-event-type-vs.html)
