{% include pc-transplant-profile.svg %}

# Transplant — Logical Model → FHIR Map

Primary profile: [Transplant](StructureDefinition-transplant.html) (`Procedure`)  
Detail panel: [TransplantDetails](StructureDefinition-transplant-details.html) (`Observation`) — one instance per transplant, linked via `Observation.partOf = Reference(Transplant)`

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| transplant_id | M | `Procedure.identifier.value` | |
| visit_id | M | `Procedure.encounter` | `Transplant.encounter = Reference(Visit)`; search `Procedure?encounter={visit-id}` |
| donor_id | M | `Procedure.extension[donor_id]` | [TransplantDonorRef](StructureDefinition-transplant-donor-ref.html) |
| tx_type | M | `Procedure.code` | [TransplantTypeVS](ValueSet-transplant-type-vs.html) |
| date_tx | M | `Procedure.performedDateTime` | |
| time_diag_to_tx | M | `Observation.component[time_diag_to_tx].valueQuantity` | Quantity (mo); calculated field |
| d_r_weight_ratio | R | `Observation.component[d_r_weight_ratio].valueQuantity` | Dimensionless ratio |
| vessel_mismatch_d_r | R | `Observation.component[vessel_mismatch_d_r].valueBoolean` | |
| cold_ischemia_time | R | `Observation.component[cold_ischemia_time].valueQuantity` | Quantity (min) |
| warm_ischemia_time | R | `Observation.component[warm_ischemia_time].valueQuantity` | Quantity (min) |
| vascular_anomalies | R | `Observation.component[vascular_anomalies].valueString` | Free text |
| type_surgical_biliary_anastomosis | R | `Observation.component[type_surgical_biliary_anastomosis].valueCodeableConcept` | [BiliaryAnastomosisTypeVS](ValueSet-biliary-anastomosis-type-vs.html); Liver only |
| intraoperative_complications | R | `Observation.component[intraoperative_complications].valueCodeableConcept` | [IntraoperativeComplicationVS](ValueSet-intraoperative-complication-vs.html); repeat component per complication |
| intraoperative_complications_other | R | `Observation.component[intraoperative_complications_other].valueString` | Free text; **Liver only** |
| type_ureteral_graft_anastomosis | O | `Observation.component[type_ureteral_graft_anastomosis].valueCodeableConcept` | [UreteralAnastomosisTypeVS](ValueSet-ureteral-anastomosis-type-vs.html); **Kidney only** *(DM v1.2 marks this field as Both; the IG treats it as Kidney only because ureteral anastomosis is not applicable to liver transplantation. This divergence is intentional and should be resolved in a future DM revision.)* |
| other_type_ureteral_graft_anastomosis | O | `Observation.component[other_type_ureteral_graft_anastomosis].valueString` | Free text; **Kidney only** *(same rationale as above)* |
