{% include pc-donor-profile.svg %}

# Donor — Logical Model → FHIR Map

Primary profile: [Donor](StructureDefinition-donor.html) (`Patient`)  
Age panel: [PatientDemographicsObservation](StructureDefinition-patient-demographics-observation.html) (`Observation`, category `survey`) — `subject = Reference(Donor)`

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| donor_id | M | `Patient.identifier.value` | |
| age_years | M | `Observation.component[age_years].valueQuantity` | UCUM `a`; in [PatientDemographicsObservation](StructureDefinition-patient-demographics-observation.html) with `subject = Reference(Donor)` |
| age_months | M | `Observation.component[age_months].valueQuantity` | UCUM `mo` |
| type | M | `Patient.deceasedBoolean` | `true` = deceased donor; `false` / absent = living donor |
| liver_type | R | `Observation.valueCodeableConcept` | [DonorLiverTypeObservation](StructureDefinition-donor-liver-type-observation.html); LOINC 74836-8; Liver only |
