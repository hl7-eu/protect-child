# PROTECT-CHILD Pediatric Transplant Data Implementation Guide

This Implementation Guide is the shared "data language" for the PROTECT-CHILD project. It takes the project's common data model for children who receive a **liver or kidney transplant** and expresses it as standard [HL7 FHIR R4](http://hl7.org/fhir/R4/) definitions, so that four European hospitals can record the same clinical, laboratory, immunological, microbiological, and genomic information in the same way — and answer research questions across all of them **without moving any patient's raw data**.

> **Status:** This Implementation Guide is a **draft** and evolves with ongoing work in PROTECT-CHILD.

---

## About PROTECT-CHILD

[PROTECT-CHILD](https://protect-child.eu/) is a Horizon Europe project working to **improve long-term outcomes in paediatric solid-organ (liver and kidney) transplantation** by integrating **clinical and genomic data** through secure, privacy-preserving technology.

Its architecture aligns with the **European Health Data Space (EHDS)**, using interoperable standards (**FHIR** and **OMOP**), federated analytics, and EHDS "data space capsules" so that data stays local to each hospital while still supporting collaborative, cross-border research. The project runs a pilot across **200 paediatric transplants** and is part of the TransplantChild European Reference Network.

This IG is the FHIR expression of that data model. For the project vision, consortium, and pilots, see [protect-child.eu](https://protect-child.eu/).

---

## What this guide contains

| Section | What you'll find |
| --- | --- |
| [Logical Models](logical-models.html) | The PROTECT-CHILD data model (one logical model per table), plus a worked patient use-case. |
| [Logical Model &rarr; FHIR Mapping](mapping.html) | How each data-model entity and field maps to FHIR R4 resources, with cardinalities. |
| [Data Model (ERD)](data-model-erd.html) | The entity-relationship diagram of the data model (v1.2). |
| [Artifacts](artifacts.html) | All profiles, extensions, code systems, value sets, and examples. |

**New here?** Start with the use-case story on the [Logical Models](logical-models.html) page, then use the [Mapping](mapping.html) page to see how each field becomes FHIR.

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

## Scope

This IG defines FHIR R4 profiles, extensions, code systems, and value sets for **PROTECT-CHILD data model v1.2**. It covers:

- **Recipient demographics** — age, gender, primary disease diagnosis, PRA, HLA typing, ABO/Rh blood group
- **Donor demographics** — age, type (living/deceased), liver graft type, HLA/ABO/Rh
- **Transplant event** — transplant type, surgical details, intraoperative findings
- **Follow-up visits** — scheduled and clinical-event visits across a 24-month post-transplant timeline
- **Laboratory results** — analytes with a LOINC-coded test catalogue
- **Vital signs** — blood pressure (including 24-h ABPM), weight, height, BMI, heart rate, SpO2
- **Immunological data** — ABO/Rh, HLA allele typing, DSA, Banff category, C4d, ANCA
- **Immunosuppression** — induction and maintenance drug regimens with dosing and levels
- **Pre-medication** — antihypertensive treatment, rituximab, antiviral prophylaxis
- **Microbiology** — EBV, CMV, BKV, Parvovirus B19, HSV, VZV, Adenovirus, and culture results
- **Clinical variables and concomitant diseases** — symptoms, comorbidities, and organ dysfunction
- **Clinical events** — post-transplant complications, rejection episodes, graft failure, mortality
- **Biospecimens** — sample tracking with linked genomic and epigenomic analysis requests

---

## Standards & FHIR version

This IG is based on **FHIR R4 (4.0.1)** and depends on the HL7 Europe base package. It is designed to sit alongside the project's OMOP representation within the EHDS-aligned, federated data ecosystem.

---

## Funding & attribution

PROTECT-CHILD has received funding from the European Union's Horizon Europe research and innovation programme under grant agreement Nº 101137423, and from the Swiss State Secretariat for Education, Research and Innovation (SERI). IG © 2025 [Protect Child](https://protect-child.eu/).
