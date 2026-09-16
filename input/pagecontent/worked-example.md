# Worked Example — Liver

One complete PROTECT-CHILD record, end to end. The [Model Maps](mapping.html) show each entity alone and the [Crosswalk](dm-fhir-omop-map.html) lines up the three representations field by field; this page shows how the resources **link together** for one patient.



*These records are illustrative: they exist to show how the profiles fit together, and are built to exercise the guide rather than to be clinically representative.*

[**Bundle-ProtectChildRecipientJourneyExample**](Bundle-ProtectChildRecipientJourneyExample.html)

**REC-1-0001** is Mila, nine years old, at La Paz University Hospital (centre 1), cirrhotic since March 2020. The transplant on **15 August 2023** is the index date every other record is positioned against.

## Study centre and patients

The La Paz University Hospital  as an `Organization`, then the two people: the recipient  **REC-1-0001** and the deceased donor **DON-1-0001**. 

{% include pc-recipient-journey-01-study-centre-and.svg %}

## Catalogue entries

Study-wide definitions: the two immunosuppressant medications, the lab test and the instrumental investigation. 

{% include pc-recipient-journey-02-catalogue-entries.svg %}

## Recipient history — primary disease

The cirrhosis that brings her to transplant, as a `Condition` with the organ in `bodySite`. It predates every visit in the record.

{% include pc-recipient-journey-03-recipient-history.svg %}

## Pre-transplant episode and transplant admission

One inpatient episode, **VIS-1-0001**, spanning work-up, surgery and the early post-operative period. Peak PRA is 80%, so rituximab is given while she is waitlisted — not donor-directed, since no organ has been offered — and full HLA typing follows with a negative pre-transplant DSA screen. The transplant itself, a split graft, is one linked set with its duct-to-duct biliary anastomosis and an intra-operative bleed; induction immunosuppression starts the same day. On day 5 she has acute kidney injury, a typed clinical event treated with sixteen days of dialysis.

{% include pc-recipient-journey-04-pre-transplant-episode.svg %}

## 1-month follow-up visit

**VIS-1-0002**: vitals, three analytes, a biospecimen for genomic analysis, and maintenance tacrolimus with its trough. EBV DNA at 2,450 copies/mL prompts a liver biopsy — EBER-positive nuclei, no bile duct damage or endothelialitis, so EBV hepatitis rather than rejection — and tacrolimus is cut 0.1 → 0.06 mg/kg in response. Hypertension appears here, on tacrolimus and steroids, and amlodipine starts the same day.

{% include pc-recipient-journey-05-1-month-follow.svg %}

## Clinical-event visit — acute rejection episode

**VIS-1-0003**, unscheduled. The bloods bring her in: ALT 86 → 210 U/L, bilirubin 3.8 mg/dL, GGT 180. The biopsy shows C4d in the portal microvasculature with a de novo class I DSA. Treatment is a three-day methylprednisolone pulse at 10 mg/kg/day.

{% include pc-recipient-journey-06-clinical-event-visit.svg %}

## 6-month follow-up visit

**VIS-1-0004**: abdominal imaging, and the amlodipine reviewed — still running since September.

{% include pc-recipient-journey-07-6-month-follow.svg %}

## 12-month follow-up visit

**VIS-1-0005**: vitals with 24-hour ABPM, and the three analytes repeated — creatinine 1.2 → 0.8 mg/dL, albumin 3.4 → 4.2 g/dL, ALT 86 → 31 U/L. Albumin and ALT track the graft; the creatinine tracks renal recovery from the early injury, and at 0.8 is still flagged high for a nine-year-old.


{% include pc-recipient-journey-08-12-month-follow.svg %}

