# Logical Model → FHIR Mapping Overview

This section maps each entity in the PROTECT-CHILD data model to the FHIR profiles defined in this IG.

**Cardinality key** — M = Mandatory (1..1) · R = Recommended (0..1) · O = Optional (0..1)

---

## Information Flow

The diagram below shows how the data model entities relate to each other and which FHIR R4 base resource each entity maps to. Solid arrows indicate mandatory references; dashed arrows indicate optional or calculated links.

{% include pc-entity-fhir-map.svg %}

**Key relationships:**

- **Patient** is the anchor. Each patient has one or more **Visits**, which in turn anchor all per-visit clinical data.
- **Donor** links to **Transplant** (the surgical event) and optionally to **Immunological Data** (for donor-side HLA/ABO typing) and **Microbiology** (for donor-derived results).
- **Visit** acts as the central hub: every clinical, laboratory, medication, specimen, and outcome record carries a `visit_id` foreign key that resolves to an `Encounter` reference in FHIR.
- **Transplant** is a `Procedure` that captures the surgical event. Intraoperative details (ischemia times, complications, etc.) are components of a single companion `TransplantDetails` Observation linked via `Observation.partOf`.

---

## Entity Index

| Entity | FHIR base resource | Map page |
|---|---|---|
| Patient | `Patient` + `Observation` (panel) + `Condition` | [Patient map](patient-map.html) |
| Donor | `Patient` | [Donor map](donor-map.html) |
| Visit | `Encounter` | [Visit map](visit-map.html) |
| Transplant | `Procedure` + `Observation` (panel) | [Transplant map](transplant-map.html) |
| Immunological Data | `Observation` (panel) | [Immunological Data map](immunological-data-map.html) |
| Vital Sign | `Observation` (panel) | [Vital Sign map](vital-sign-map.html) |
| BioSample | `Specimen` | [BioSample map](biosample-map.html) |
| Pre-Medication | `MedicationStatement` | [Pre-Medication map](pre-medication-map.html) |
| Clinical Variable | `Observation` | [Clinical Variable map](clinical-variable-map.html) |
| Concomitant Medication | `MedicationStatement` | [Concomitant Medication map](concomitant-medication-map.html) |
| Microbiology | `Observation` (panel) | [Microbiology map](microbiology-map.html) |
| Instrumental Investigation | `Observation` | [Instrumental Investigation map](instrumental-investigation-map.html) |
| Immunosuppressant / ImmPat | `Medication` + `MedicationStatement` | [Immunosuppressant map](immunosuppressant-map.html) |
| Lab Test / Lab Result | `ObservationDefinition` + `Observation` | [Laboratory map](lab-map.html) |
| Clinical Event Type | `CodeSystem` + `ValueSet` | [Clinical Event Type map](clinical-event-type-map.html) |
| Clinical Event | `Condition` | [Clinical Event map](clinical-event-map.html) |
