{% include pc-transplant-profile.svg %}

# Transplant — Logical Model → FHIR Map

Primary profile: [Transplant](StructureDefinition-transplant.html) (`Procedure`)  
Detail panel: [TransplantDetails](StructureDefinition-transplant-details.html) (`Observation`) — one instance per transplant, linked via `Observation.partOf = Reference(Transplant)`  
Complications: [IntraoperativeComplication](StructureDefinition-intraoperative-complication.html) (`Condition`) — one per complication, linked via `Transplant.complicationDetail`  
Anastomoses: [TransplantAnastomosis](StructureDefinition-transplant-anastomosis.html) (`Procedure`) — one per anastomosis, linked via `Procedure.partOf = Reference(Transplant)`

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
| type_surgical_biliary_anastomosis | R | `Procedure.code` | [TransplantAnastomosis](StructureDefinition-transplant-anastomosis.html) (`Procedure`) linked via `Procedure.partOf`; [BiliaryAnastomosisTypeVS](ValueSet-biliary-anastomosis-type-vs.html); Liver only |
| intraoperative_complications | R | `Condition.code` | Each complication is an [IntraoperativeComplication](StructureDefinition-intraoperative-complication.html) (`Condition`, encounter-diagnosis) linked from `Transplant.complicationDetail`; [IntraoperativeComplicationVS](ValueSet-intraoperative-complication-vs.html) |
| intraoperative_complications_other | R | `Condition.note` | Free-text complication carried on the [IntraoperativeComplication](StructureDefinition-intraoperative-complication.html) Condition; **Liver only** |
| type_ureteral_graft_anastomosis | O | `Procedure.code` | [TransplantAnastomosis](StructureDefinition-transplant-anastomosis.html) (`Procedure`) linked via `Procedure.partOf`; [UreteralAnastomosisTypeVS](ValueSet-ureteral-anastomosis-type-vs.html); **Kidney only** *(DM v1.2 marks this field as Both; the IG treats it as Kidney only because ureteral anastomosis is not applicable to liver transplantation. This divergence should be resolved in a future DM revision.)* |
| other_type_ureteral_graft_anastomosis | O | `Procedure.code.text` | Free-text anastomosis type on the [TransplantAnastomosis](StructureDefinition-transplant-anastomosis.html) Procedure; **Kidney only** *(same rationale as above)* |
