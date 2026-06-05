# PROTECT-CHILD Transplant Data Implementation Guide

> **Status:** This Implementation Guide is a **draft** and may change based on ongoing work in PROTECT-CHILD.

---

## Background

PROTECT-CHILD is a European research project focused on improving long-term outcomes in paediatric solid-organ transplantation (liver and kidney). The project collects longitudinal clinical, immunological, laboratory, microbiological, biospecimen, and omics data from four partner centres:

| Centre no. | Institution | Country |
|---|---|---|
| 1 | La Paz University Hospital | Spain |
| 2 | University of Padova | Italy |
| 3 | Son Espases University Hospital, Palma | Spain |
| 4 | University Medical Centre Hamburg-Eppendorf | Germany |

Data is stored locally at each site in a **data space capsule** and federated analytics queries are executed without moving raw patient data.

---

## Scope

This IG defines FHIR R4 profiles, extensions, code systems, and value sets for the PROTECT-CHILD data model version 1.2. It covers:

- **Recipient demographics** — age, gender, primary disease diagnosis, PRA, HLA typing, ABO/Rh blood group
- **Donor demographics** — age, type (living/deceased), liver graft type, HLA/ABO/Rh
- **Transplant event** — transplant type, surgical details, intraoperative findings
- **Follow-up visits** — scheduled and clinical-event visits across a 24-month post-transplant timeline
- **Laboratory results** — 50+ analytes with LOINC-coded test catalogue
- **Vital signs** — blood pressure (including 24-h ABPM), weight, height, BMI, heart rate, SpO2
- **Immunological data** — ABO/Rh, HLA allele typing, DSA, Banff category, C4d, ANCA
- **Immunosuppression** — induction and maintenance drug regimens with dosing and levels
- **Pre-medication** — antihypertensive treatment, rituximab, antiviral prophylaxis
- **Microbiology** — EBV, CMV, BKV, Parvovirus B19, HSV, VZV, Adenovirus, and culture results
- **Clinical variables and concomitant diseases** — symptoms, comorbidities, and organ dysfunction
- **Clinical events** — post-transplant complications, rejection episodes, graft failure, mortality
- **Biospecimens** — sample tracking with linked genomic and epigenomic analysis requests

---

## FHIR Version

This IG is based on **FHIR R4 (4.0.1)**.
