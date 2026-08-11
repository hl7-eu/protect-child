# Patient Timeline

The PROTECT-CHILD follow-up schedule spans **24 months** after transplant. This page shows the visit schedule and which data is captured at each stage. Every follow-up record links to its **Visit**, and each Visit links to the **Patient** — so the timeline is the backbone that ties the whole data model together.

![PROTECT-CHILD patient timeline](patient-timeline.svg)

## Visit schedule

- **Pre-transplant (baseline)** — recipient demographics, gender, age, primary disease diagnosis and date, PRA (max/last), HLA typing, ABO/Rh, and pre-medication (antihypertensive treatment, rituximab, antiviral prophylaxis, desensitisation).
- **Transplant (day 0)** — donor information (type, age, graft, HLA/ABO/Rh), the transplant procedure and type, intraoperative details (ischaemia times, anastomoses, complications), and induction immunosuppression.
- **Scheduled follow-up — 1, 3, 6, 12 and 24 months** — vital signs (including 24-hour ABPM), clinical variables, laboratory results, immunological data, microbiology, instrumental investigations, maintenance immunosuppression with pharmacokinetic levels, concomitant medications, and biosamples.
- **Clinical-event visit** — an *unscheduled* visit recorded whenever a clinical event occurs (rejection, infection, graft failure, and so on), at any point on the timeline.
- **Termination visit** — the study end / end-of-follow-up visit.

## Data domains across the timeline

Vital signs / ABPM · laboratory · immunological data · microbiology · immunosuppression + PK · instrumental investigations · concomitant medication · clinical events · biosamples (→ genomic / epigenomic analysis).

For the full field list see the [Data Dictionary](data-dictionary.html); for how each field maps to FHIR see the [Mapping](mapping.html) pages.
