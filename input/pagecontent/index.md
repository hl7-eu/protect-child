# PROTECT-CHILD Pediatric Transplant Data Implementation Guide

This Implementation Guide, for the PROTECT-CHILD project, takes the project's common data model for children who receive a **liver or kidney transplant** and expresses it as standard [HL7 FHIR R4](http://hl7.org/fhir/R4/) definitions, so that four European hospitals can record the same clinical, laboratory, immunological, microbiological, and genomic information in the same way.

> **Status:** This Implementation Guide is a **draft** and evolves with ongoing work in PROTECT-CHILD.

---

## About PROTECT-CHILD

[PROTECT-CHILD](https://protect-child.eu/) is a Horizon Europe project working to **improve long-term outcomes in paediatric solid-organ (liver and kidney) transplantation** by integrating **clinical and genomic data** through secure, privacy-preserving technology.

Its architecture aligns with the **European Health Data Space (EHDS)**, using interoperable standards (**FHIR** and **OMOP**), federated analytics, and EHDS "data space capsules" so that data stays local to each hospital while still supporting collaborative, cross-border research. The project runs a pilot across **200 paediatric transplants** and is part of the TransplantChild European Reference Network.

---

## What this guide contains

| Section | What you'll find |
| --- | --- |
| [Logical Models](logical-models.html) | The PROTECT-CHILD data model (one logical model per table). |
| [Logical Model &rarr; FHIR Mapping](mapping.html) | How each data-model entity and field maps to FHIR R4 resources. |
| [DM &rarr; FHIR &rarr; OMOP Crosswalk](dm-fhir-omop-map.html) | A single consolidated table joining each data-model variable to its FHIR element and its OMOP CDM concept (table, field, and standardized code). |
| [Data Model (ERD)](data-model-erd.html) | The entity-relationship diagram of the data model (v1.2). |
| [Data Dictionary](data-dictionary.html) | Every data-model variable, table by table, with type, cardinality and organ scope. |
| [Worked Example — Liver](worked-example.html) | One recipient's record end to end, section by section, showing how the resources link together. |
| [Worked Example — Kidney](kidney-worked-example.html) | A second recipient at a second centre, carrying what a liver record cannot. |
| [Artifacts](artifacts.html) | All profiles, extensions, code systems, value sets, and examples. |

---

## Participating centres

Data is stored locally at each site in a **data space capsule**; federated analytics queries run without moving raw patient data.

| Centre no. | Institution | Country |
|---|---|---|
| 1 | La Paz University Hospital | Spain |
| 2 | University of Padova | Italy |
| 3 | Son Espases University Hospital, Palma | Spain |
| 4 | University Medical Centre Hamburg-Eppendorf | Germany |

---

## Funding & attribution

PROTECT-CHILD has received funding from the European Union's Horizon Europe research and innovation programme under grant agreement Nº 101137423, and from the Swiss State Secretariat for Education, Research and Innovation (SERI). IG © 2025 [Protect Child](https://protect-child.eu/).
