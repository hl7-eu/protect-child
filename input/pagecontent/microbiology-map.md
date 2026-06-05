{% include pc-microbiology-profile.svg %}

# Microbiology — Logical Model → FHIR Map

Primary profile: [Microbiology](StructureDefinition-microbiology.html) (`Observation` panel)

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

All result fields map to `Observation.component` slices coded by [MicrobiologyCS](CodeSystem-microbiology-cs.html). Boolean components use `valueBoolean` (true = Positive / detected); quantitative (viral load) components use `valueQuantity` (UCUM `{copies}/mL`); coded components use `valueCodeableConcept`; free-text fields use `valueString`.

| DM field | Card. | FHIR path | Notes |
|---|---|---|---|
| microbiology_id | M | `Observation.identifier.value` | |
| visit_id | M | `Observation.encounter` | [Reference(Visit)](StructureDefinition-visit.html) |
| donor_id | O | `Observation.focus` | [Reference(Donor)](StructureDefinition-donor.html); for donor-derived / pre-transplant serology |
| ebv_dna | R | `Observation.component[ebvDna].valueBoolean` | `MicrobiologyCS#ebv-dna`; true = Positive |
| ebv_dna_copies | R | `Observation.component[ebvDnaCopies].valueQuantity` | `MicrobiologyCS#ebv-dna-copies`; UCUM `{copies}/mL` |
| ebv_igm_anti_ea | R | `Observation.component[ebvIgmAntiEa].valueBoolean` | `MicrobiologyCS#ebv-igm-anti-ea` |
| ebv_igm_anti_vca | R | `Observation.component[ebvIgmAntiVca].valueBoolean` | `MicrobiologyCS#ebv-igm-anti-vca` |
| ebv_igg_anti_vca | R | `Observation.component[ebvIggAntiVca].valueBoolean` | `MicrobiologyCS#ebv-igg-anti-vca` |
| ebv_igg_ebna | R | `Observation.component[ebvIggEbna].valueBoolean` | `MicrobiologyCS#ebv-igg-ebna` |
| cmv_dna | R | `Observation.component[cmvDna].valueBoolean` | `MicrobiologyCS#cmv-dna` |
| cmv_dna_copies | R | `Observation.component[cmvDnaCopies].valueQuantity` | `MicrobiologyCS#cmv-dna-copies`; UCUM `{copies}/mL` |
| cmv_igm | R | `Observation.component[cmvIgm].valueBoolean` | `MicrobiologyCS#cmv-igm` |
| cmv_igg | R | `Observation.component[cmvIgg].valueBoolean` | `MicrobiologyCS#cmv-igg` |
| parvovirus_b19_dna | R | `Observation.component[parvoB19Dna].valueBoolean` | `MicrobiologyCS#parvovirus-b19-dna` |
| parvovirus_b19_dna_copies | R | `Observation.component[parvoB19DnaCopies].valueQuantity` | `MicrobiologyCS#parvovirus-b19-dna-copies`; UCUM `{copies}/mL` |
| parvovirus_b19_igg | R | `Observation.component[parvoB19Igg].valueBoolean` | `MicrobiologyCS#parvovirus-b19-igg` |
| parvovirus_b19_igm | R | `Observation.component[parvoB19Igm].valueBoolean` | `MicrobiologyCS#parvovirus-b19-igm` |
| hsv_igg | R | `Observation.component[hsvIgg].valueBoolean` | `MicrobiologyCS#hsv-igg` |
| hsv_igm | R | `Observation.component[hsvIgm].valueBoolean` | `MicrobiologyCS#hsv-igm` |
| adenovirus_igg | R | `Observation.component[adenovirusIgg].valueBoolean` | `MicrobiologyCS#adenovirus-igg` |
| adenovirus_igm | R | `Observation.component[adenovirusIgm].valueBoolean` | `MicrobiologyCS#adenovirus-igm` |
| blood_adenovirus_dna | R | `Observation.component[bloodAdenovirusDna].valueBoolean` | `MicrobiologyCS#blood-adenovirus-dna` |
| blood_adenovirus_dna_copies | R | `Observation.component[bloodAdenovirusDnaCopies].valueQuantity` | `MicrobiologyCS#blood-adenovirus-dna-copies`; UCUM `{copies}/mL` |
| vzv_igg | R | `Observation.component[vzvIgg].valueBoolean` | `MicrobiologyCS#vzv-igg` |
| vzv_igm | R | `Observation.component[vzvIgm].valueBoolean` | `MicrobiologyCS#vzv-igm` |
| blood_bkv_dna | R | `Observation.component[bloodBkvDna].valueBoolean` | `MicrobiologyCS#blood-bkv-dna` |
| blood_bkv_dna_copies | R | `Observation.component[bloodBkvDnaCopies].valueQuantity` | `MicrobiologyCS#blood-bkv-dna-copies`; UCUM `{copies}/mL` |
| urine_bkv_dna | R | `Observation.component[urineBkvDna].valueBoolean` | `MicrobiologyCS#urine-bkv-dna` |
| bkv_dna_kidney_biopsy | R | `Observation.component[bkvDnaKidneyBiopsy].valueBoolean` | `MicrobiologyCS#bkv-dna-kidney-biopsy`; Kidney only |
| bkv_fish_kidney_biopsy | R | `Observation.component[bkvFishKidneyBiopsy].valueBoolean` | `MicrobiologyCS#bkv-fish-kidney-biopsy`; Kidney only |
| blood_colture | R | `Observation.component[bloodColture].valueBoolean` | `MicrobiologyCS#blood-colture`; Kidney only |
| urine_colture | R | `Observation.component[urineColture].valueBoolean` | `MicrobiologyCS#urine-colture`; Kidney only |
| other_positivity | R | `Observation.component[otherPositivity].valueString` | `MicrobiologyCS#other-positivity`; free text; Kidney only |
| ebv_hepatitis_liver | R | `Observation.component[ebvHepatitisLiver].valueBoolean` | `MicrobiologyCS#ebv-hepatitis-liver`; Liver only |
| evidence_bkvan | R | `Observation.component[evidenceBkvan].valueCodeableConcept` | `MicrobiologyCS#evidence-bkvan`; No / Yes / Unknown |
