# Worked Example — Kidney

A leaner record at a second site, carrying what a liver record cannot. The [liver example](worked-example.html) follows one recipient across the full visit timeline.

*These records are illustrative: they exist to show how the profiles fit together, and are built to exercise the guide rather than to be clinically representative.*

[**Bundle-ProtectChildKidneyRecipientJourneyExample**](Bundle-ProtectChildKidneyRecipientJourneyExample.html)

**REC-2-0001** is Luca, twelve years old, at the University of Padova (centre 2), in CKD stage 5 since November 2021. The transplant on **12 March 2024** is the index date. The centre number inside the identifier is what keeps him distinct from REC-1-0001 at La Paz.

## Study centre and patients

The University of Padova as an `Organization`, then the recipient **REC-2-0001** and the living related donor **DON-2-0001** — where the liver recipient's donor was deceased.

{% include pc-kidney-journey-01-study-centre-and.svg %}

## Catalogue entries

Study-wide definitions: basiliximab and tacrolimus as immunosuppressant medications, plus the methylprednisolone entry shared with the liver example.

{% include pc-kidney-journey-02-catalogue-entries.svg %}

## Recipient history — primary disease

Chronic kidney disease stage 5, as a `Condition` with the kidney in `bodySite`. It predates every visit in the record.

{% include pc-kidney-journey-03-recipient-history.svg %}

## Pre-transplant episode and transplant admission

One inpatient episode, **VIS-2-0001**, from 1 to 25 March 2024. The graft is implanted on 12 March with a standard ureteroneocystostomy, and an intra-operative ischaemic episode is recorded against the same procedure. Delayed graft function follows on day 3, treated with nine days of haemodialysis — the event a liver recipient cannot carry. Basiliximab induction is given on the day of transplant and day 4.

{% include pc-kidney-journey-04-pre-transplant-episode.svg %}

## 1-month follow-up visit

**VIS-2-0002**: blood pressure 124/78 at the 95th centile, creatinine still high at 1.6 mg/dL, a normal graft Doppler ultrasound, and maintenance tacrolimus with a trough of 6.2 ng/mL.

{% include pc-kidney-journey-05-1-month-follow.svg %}

## Clinical-event visit — rejection with BK-virus nephropathy

**VIS-2-0003**, unscheduled. Creatinine 2.4 mg/dL brings him back. BK-virus surveillance across blood, urine and graft biopsy — 42,000 copies/mL in blood, positive on both biopsy assays — shows BK-virus nephropathy. There is no antiviral: the only treatment is to reduce immunosuppression, so tacrolimus is halved to 0.05 mg/kg.

{% include pc-kidney-journey-06-clinical-event-visit.svg %}

## Clinical-event visit — acute rejection after the reduction

**VIS-2-0004**. Creatinine 3.1 mg/dL and a repeat biopsy showing acute rejection, Banff 4, C4d negative, with a class II donor-specific antibody at moderate MFI. Treatment is a three-day methylprednisolone pulse at 10 mg/kg/day.

{% include pc-kidney-journey-07-clinical-event-visit.svg %}

## Termination visit — graft failure

**VIS-2-0005**, January 2025. Creatinine 5.2 mg/dL and **graft failure** recorded as a typed clinical event; haemodialysis restarts with no end date, and he is relisted in February.

{% include pc-kidney-journey-08-termination-visit.svg %}
