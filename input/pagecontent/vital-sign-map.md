{% include pc-vital-sign-profile.svg %}

# Vital Sign — Logical Model → FHIR Map

Primary profile: [VitalSign](StructureDefinition-vital-sign.html) (`Observation` panel, `category = vital-signs`)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

All measurement fields map to `Observation.component` slices.

| DM field | Card. | FHIR path | LOINC | Unit |
|---|---|---|---|---|
| vital_sign_id | M | `Observation.identifier.value` | | |
| visit_id | M | `Observation.encounter` | | |
| date | M | `Observation.effectiveDateTime` | | |
| systolic_blood_pressure | R | `Observation.component[systolic_bp].valueQuantity` | 8480-6 | mm[Hg] |
| diastolic_blood_pressure | R | `Observation.component[diastolic_bp].valueQuantity` | 8462-4 | mm[Hg] |
| heart_rate | R | `Observation.component[heart_rate].valueQuantity` | 8867-4 | /min |
| oxygen_saturation | R | `Observation.component[oxygen_saturation].valueQuantity` | 59408-5 | % |
| temperature | R | `Observation.component[temperature].valueQuantity` | 8310-5 | Cel |
| bmi | R | `Observation.component[bmi].valueQuantity` | 39156-5 | kg/m2 |
| sbp_percentile | R | `Observation.component[sbp_percentile].valueInteger` | 59574-4 | |
| dbp_percentile | R | `Observation.component[dbp_percentile].valueInteger` | 59575-1 | |
| mean_sbp_24 | R | `Observation.component[mean_sbp_24].valueQuantity` | 8490-5 | mm[Hg] |
| mean_dbp_24 | R | `Observation.component[mean_dbp_24].valueQuantity` | 8472-3 | mm[Hg] |
| mean_sbp_day | R | `Observation.component[mean_sbp_day].valueQuantity` | 8484-8 | mm[Hg] |
| mean_dbp_day | R | `Observation.component[mean_dbp_day].valueQuantity` | 8466-5 | mm[Hg] |
| mean_sbp_night | R | `Observation.component[mean_sbp_night].valueQuantity` | 8489-7 | mm[Hg] |
| mean_dbp_night | R | `Observation.component[mean_dbp_night].valueQuantity` | 8471-5 | mm[Hg] |
| sbp_load | R | `Observation.component[sbp_load].valueQuantity` | `VitalSignLocalCS#sbp-load` | % |
| dbp_load | R | `Observation.component[dbp_load].valueQuantity` | `VitalSignLocalCS#dbp-load` | % |
| sbp_dip | R | `Observation.component[sbp_dip].valueQuantity` | `VitalSignLocalCS#sbp-dip` | % |
| dbp_dip | R | `Observation.component[dbp_dip].valueQuantity` | `VitalSignLocalCS#dbp-dip` | % |

> ABPM fields (`mean_sbp_24`, `mean_dbp_24`, `mean_sbp_day`, `mean_dbp_day`, `mean_sbp_night`, `mean_dbp_night`, `sbp_load`, `dbp_load`, `sbp_dip`, `dbp_dip`) are only populated when a 24-hour ambulatory blood pressure monitor was used.
