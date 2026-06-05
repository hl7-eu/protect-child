{% include pc-immunological-data-profile.svg %}

# Immunological Data — Logical Model → FHIR Map

Primary profile: [ImmunologicalData](StructureDefinition-immunological-data.html) (`Observation` panel)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

All result fields map to `Observation.component` slices keyed by the codes below.

HLA allele components use per-position codes from [ImmDataComponentCS](CodeSystem-imm-data-component-cs.html) as the primary discriminating code. Implementers SHOULD also include the LOINC parent code as a second `component.code.coding` entry for cross-system interoperability (see example instance).

| DM field | Card. | FHIR path | Primary code | LOINC parent | Notes |
|---|---|---|---|---|---|
| immunological_data_id | M | `Observation.identifier.value` | | | |
| visit_id | M | `Observation.encounter` | | | [Reference(Visit)](StructureDefinition-visit.html) |
| donor_id | O | `Observation.focus` | | | [Reference(Donor)](StructureDefinition-donor.html); for donor-side HLA/ABO typing |
| blood_group | R | `Observation.component[blood_group].valueCodeableConcept` | LOINC 883-9 | | [PatientABOGroupVS](ValueSet-patient-abo-group-vs.html) |
| rh_factor | R | `Observation.component[rh_factor].valueCodeableConcept` | LOINC 10331-7 | | [PatientRhFactorVS](ValueSet-patient-rh-factor-vs.html) |
| hla_a_1 | R | `Observation.component[hla_a_1].valueString` | `ImmDataComponentCS#hla-a-1` | 13297-7 | IMGT/HLA notation e.g. `A*02:01` |
| hla_a_2 | R | `Observation.component[hla_a_2].valueString` | `ImmDataComponentCS#hla-a-2` | 13297-7 | |
| hla_b_1 | R | `Observation.component[hla_b_1].valueString` | `ImmDataComponentCS#hla-b-1` | 13298-5 | |
| hla_b_2 | R | `Observation.component[hla_b_2].valueString` | `ImmDataComponentCS#hla-b-2` | 13298-5 | |
| hla_c_1 | R | `Observation.component[hla_c_1].valueString` | `ImmDataComponentCS#hla-c-1` | 13299-3 | |
| hla_c_2 | R | `Observation.component[hla_c_2].valueString` | `ImmDataComponentCS#hla-c-2` | 13299-3 | |
| hla_drb1_1 | R | `Observation.component[hla_drb1_1].valueString` | `ImmDataComponentCS#hla-drb1-1` | 13300-9 | |
| hla_drb1_2 | R | `Observation.component[hla_drb1_2].valueString` | `ImmDataComponentCS#hla-drb1-2` | 13300-9 | |
| hla_dp_1 | R | `Observation.component[hla_dp_1].valueString` | `ImmDataComponentCS#hla-dp-1` | 13301-7 | |
| hla_dp_2 | R | `Observation.component[hla_dp_2].valueString` | `ImmDataComponentCS#hla-dp-2` | 13301-7 | |
| hla_dqb1_1 | R | `Observation.component[hla_dqb1_1].valueString` | `ImmDataComponentCS#hla-dqb1-1` | 13302-5 | |
| hla_dqb1_2 | R | `Observation.component[hla_dqb1_2].valueString` | `ImmDataComponentCS#hla-dqb1-2` | 13302-5 | |
| post_transplant_ab_anti_hla_dsa_class | R | `Observation.component[post_tx_dsa_class].valueCodeableConcept` | | [DSAClassVS](ValueSet-dsa-class-vs.html) |
| pre_transplant_anti_hla_dsa | R | `Observation.component[pre_tx_dsa].valueString` | | Free text. *(DM v1.2 sheet has a typo: `pre_trasnplant_anti_hla_dsa` — corrected here.)* |
| mfi | R | `Observation.component[mfi].valueCodeableConcept` | | [MFICategoryVS](ValueSet-mfi-category-vs.html) |
| banff_category | R | `Observation.component[banff_category].valueCodeableConcept` | | [BanffCategoryVS](ValueSet-banff-category-vs.html) |
| ihc_if_c4d | R | `Observation.component[ihc_if_c4d].valueBoolean` | | |
| if | R | `Observation.component[imm_if].valueString` | | |
| c4d | R | `Observation.component[c4d].valueString` | | |
| anca | R | `Observation.component[anca].valueBoolean` | | |
| antibody_type | R | `Observation.component[antibody_type].valueString` | | |
| anti_hla_antibodies | O | `Observation.component[anti_hla_antibodies].valueBoolean` | | |
