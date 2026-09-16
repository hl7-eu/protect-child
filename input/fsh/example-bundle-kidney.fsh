// example-bundle-kidney.fsh
// Kidney worked example — REC-2-0001 at centre 2 (Padova).
// Carries what a liver record cannot: kidney transplant type and ureteral
// anastomosis, delayed graft function, BKVAN, rejection, graft failure.

Alias: $obs-cat  = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $cond-cat = http://terminology.hl7.org/CodeSystem/condition-category
Alias: $clin-st  = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $loinc    = http://loinc.org
Alias: $snomed   = http://snomed.info/sct
Alias: $ucum     = http://unitsofmeasure.org
Alias: $pcid     = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id
Alias: $vtype    = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/visit-type-cs

// ---------------- Recipient and donor ----------------

Instance: KidneyRecipient1
InstanceOf: PatientTransplant
Usage: #example
Title: "Kidney example — recipient REC-2-0001"
Description: "Paediatric kidney transplant recipient at the University of Padova (centre 2)."
* identifier[0].system = $pcid
* identifier[0].value = "REC-2-0001"
* gender = #male
* managingOrganization = Reference(PCCenter2Padova)

Instance: KidneyDonor1
InstanceOf: Donor
Usage: #example
Title: "Kidney example — living related donor DON-2-0001"
Description: "Living related donor for recipient REC-2-0001. Contrast with the deceased donor in the liver example."
* identifier[0].system = $pcid
* identifier[0].value = "DON-2-0001"
* deceasedBoolean = false
* gender = #female
* birthDate = "1988-04-11"

Instance: KidneyRecipientDiagnosis1
InstanceOf: PatientPrimaryDiseaseDiagnosis
Usage: #example
Title: "Kidney example — primary renal disease"
Description: "Primary disease leading to transplantation: chronic kidney disease stage 5. The affected organ is carried in Condition.bodySite."
* clinicalStatus = $clin-st#active
* code = http://hl7.org/fhir/sid/icd-10#N18.5 "Chronic kidney disease, stage 5"
* bodySite = $snomed#64033007 "Kidney structure"
* subject = Reference(KidneyRecipient1)
* onsetDateTime = "2021-11-04"

Instance: KidneyRecipientAge1
InstanceOf: PatientDemographicsObservation
Usage: #example
Title: "Kidney example — recipient age at transplant"
Description: "Age of recipient REC-2-0001 at transplantation."
* status = #final
* category = $obs-cat#survey
* code = PatientObservationsPanelCS#patient-demographics-panel "Patient demographics panel (age)"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* effectiveDateTime = "2024-03-12"
* component[age_years].valueQuantity.value = 12
* component[age_years].valueQuantity.system = $ucum
* component[age_years].valueQuantity.code = #a
* component[age_years].valueQuantity.unit = "years"
* component[age_months].valueQuantity.value = 144
* component[age_months].valueQuantity.system = $ucum
* component[age_months].valueQuantity.code = #mo
* component[age_months].valueQuantity.unit = "months"

// ---------------- Visits ----------------

Instance: KidneyVisitPreTx1
InstanceOf: Visit
Usage: #example
Title: "Kidney example — pre-transplant visit and transplant admission"
Description: "Baseline work-up through the transplant admission and early post-operative period for recipient REC-2-0001."
* identifier[0].system = $pcid
* identifier[0].value = "VIS-2-0001"
* subject = Reference(KidneyRecipient1)
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#IMP "inpatient encounter"
* period.start = "2024-03-01"
* period.end = "2024-03-25"
* type[0].coding[0].system = $vtype
* type[0].coding[0].code = #pre-transplant
* type[0].coding[0].display = "Pre-transplant visit"

Instance: KidneyVisitMonth1
InstanceOf: Visit
Usage: #example
Title: "Kidney example — 1-month follow-up visit"
Description: "First scheduled follow-up visit after transplantation."
* identifier[0].system = $pcid
* identifier[0].value = "VIS-2-0002"
* subject = Reference(KidneyRecipient1)
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* period.start = "2024-04-12"
* period.end = "2024-04-12"
* type[0].coding[0].system = $vtype
* type[0].coding[0].code = #month-1
* type[0].coding[0].display = "1 month visit"

Instance: KidneyVisitRejection1
InstanceOf: Visit
Usage: #example
Title: "Kidney example — clinical-event visit for BK-virus nephropathy"
Description: "Unscheduled visit at which BK-virus nephropathy was diagnosed on graft biopsy."
* identifier[0].system = $pcid
* identifier[0].value = "VIS-2-0003"
* subject = Reference(KidneyRecipient1)
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* period.start = "2024-06-20"
* period.end = "2024-06-20"
* type[0].coding[0].system = $vtype
* type[0].coding[0].code = #clinical-event
* type[0].coding[0].display = "Clinical Event visit"

Instance: KidneyVisitRejection2
InstanceOf: Visit
Usage: #example
Title: "Kidney example — clinical-event visit for the rejection episode"
Description: "Acute rejection on a repeat biopsy, three months after BKVAN. The two are separated in time on purpose — BKVAN mimics rejection histologically and the treatments are opposed. See the worked-example page."

* identifier[0].system = $pcid
* identifier[0].value = "VIS-2-0004"
* subject = Reference(KidneyRecipient1)
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* period.start = "2024-09-10"
* period.end = "2024-09-10"
* type[0].coding[0].system = $vtype
* type[0].coding[0].code = #clinical-event
* type[0].coding[0].display = "Clinical Event visit"

Instance: KidneyVisitTermination1
InstanceOf: Visit
Usage: #example
Title: "Kidney example — termination visit"
Description: "End-of-follow-up visit at which graft failure was recorded, dialysis restarted and the recipient relisted."

* identifier[0].system = $pcid
* identifier[0].value = "VIS-2-0005"
* subject = Reference(KidneyRecipient1)
* status = #finished
* class = http://terminology.hl7.org/CodeSystem/v3-ActCode#AMB "ambulatory"
* period.start = "2025-01-20"
* period.end = "2025-01-20"
* type[0].coding[0].system = $vtype
* type[0].coding[0].code = #termination
* type[0].coding[0].display = "Termination visit"

// ---------------- Transplant ----------------

Instance: KidneyTransplant1
InstanceOf: Transplant
Usage: #example
Title: "Kidney example — the transplant"
Description: "Living-donor kidney transplantation for recipient REC-2-0001. TransplantTypeCS codes one organ per transplant record."
* identifier[0].system = $pcid
* identifier[0].value = "TXP-2-0001"
* subject = Reference(KidneyRecipient1)
* extension[donor_id].valueReference = Reference(KidneyDonor1)
* code = TransplantTypeCS#kidney "Kidney transplant"
* performedDateTime = "2024-03-12T09:30:00+01:00"
* encounter = Reference(KidneyVisitPreTx1)
* status = #completed
* complicationDetail = Reference(KidneyIntraopComplication1)

Instance: KidneyAnastomosis1
InstanceOf: TransplantAnastomosis
Usage: #example
Title: "Kidney example — ureteral anastomosis"
Description: "Standard ureteroneocystostomy performed as part of the transplant, linked to it via Procedure.partOf. The liver example carries a biliary anastomosis in the same slot."
* status = #completed
* code = UreteralAnastomosisTypeCS#standard "Standard"
* subject = Reference(KidneyRecipient1)
* encounter = Reference(KidneyVisitPreTx1)
* performedDateTime = "2024-03-12"
* partOf = Reference(KidneyTransplant1)

Instance: KidneyIntraopComplication1
InstanceOf: IntraoperativeComplication
Usage: #example
Title: "Kidney example — intra-operative complication"
Description: "Intraoperative ischaemia of the graft kidney, referenced from the transplant Procedure via complicationDetail."
* clinicalStatus = $clin-st#active
* category = $cond-cat#encounter-diagnosis
* code = IntraoperativeComplicationCS#kidney-ischemia "Kidney ischemia"
* subject = Reference(KidneyRecipient1)
* encounter = Reference(KidneyVisitPreTx1)
* onsetDateTime = "2024-03-12"

// ---------------- Early post-operative course ----------------

Instance: KidneyEventDgf1
InstanceOf: ClinicalEvent
Usage: #example
Title: "Kidney example — delayed kidney graft function"
Description: "Delayed graft function in the first week after transplantation, requiring haemodialysis. This is the kidney-specific clinical event the liver example cannot carry."
* identifier.system = $pcid
* identifier.value = "CLE-2-0001"
* clinicalStatus = $clin-st#active
* code = ClinicalEventTypeCS#delayed-kidney-graft-function "Delayed Kidney Graft Function"
* subject = Reference(KidneyRecipient1)
* encounter = Reference(KidneyVisitPreTx1)
* onsetDateTime = "2024-03-15"

Instance: KidneyDialysis1
InstanceOf: ClinicalEventProcedure
Usage: #example
Title: "Kidney example — haemodialysis for delayed graft function"
Description: "Renal replacement therapy given for the delayed graft function episode, linked to it via reasonReference."
* status = #completed
* code = ClinicalEventProcedureTypeCS#hemodialysis "Hemodialysis"
* subject = Reference(KidneyRecipient1)
* reasonReference = Reference(KidneyEventDgf1)
* performedPeriod.start = "2024-03-15"
* performedPeriod.end = "2024-03-24"

// ---------------- 1-month follow-up ----------------

Instance: KidneyVitalSign1
InstanceOf: VitalSign
Usage: #example
Title: "Kidney example — vital signs at the 1-month visit"
Description: "Blood pressure and heart rate at the first scheduled follow-up."
* identifier.system = $pcid
* identifier.value = "VIT-2-0001"
* status = #final
* category = $obs-cat#vital-signs
* code = VitalSignLocalCS#vital-signs-panel "Vital signs panel"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* encounter = Reference(KidneyVisitMonth1)
* effectiveDateTime = "2024-04-12"
* component[systolic_bp].valueQuantity.value = 124
* component[systolic_bp].valueQuantity.system = $ucum
* component[systolic_bp].valueQuantity.code = #mm[Hg]
* component[systolic_bp].valueQuantity.unit = "mmHg"
* component[diastolic_bp].valueQuantity.value = 78
* component[diastolic_bp].valueQuantity.system = $ucum
* component[diastolic_bp].valueQuantity.code = #mm[Hg]
* component[diastolic_bp].valueQuantity.unit = "mmHg"
// 124/78 is about the 95th centile for a 12-year-old boy — stage 1 hypertension.
* component[sbp_percentile].valueInteger = 95
* component[dbp_percentile].valueInteger = 88

Instance: KidneyCreatinineMonth1
InstanceOf: LabResultObservation
Usage: #example
Title: "Kidney example — creatinine at the 1-month visit"
Description: "Serum creatinine at the first scheduled follow-up, still above range as the graft recovers."
* id = "kidney-lab-creatinine-month-1"
* identifier.system = $pcid
* identifier.value = "LBR-2-0001"
* status = #final
* category.coding.system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category.coding.code = #laboratory
* category.coding.display = "Laboratory"
* code = $loinc#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* encounter = Reference(KidneyVisitMonth1)
* effectiveDateTime = "2024-04-12T08:40:00+02:00"
* valueQuantity.value = 1.6
* valueQuantity.code = #"mg/dL"
* valueQuantity.unit = "mg/dL"
* valueQuantity.system = "http://unitsofmeasure.org"
* interpretation[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"
* interpretation[0].coding[0].code = #H
* interpretation[0].coding[0].display = "High"

Instance: KidneyInvestigation1
InstanceOf: PatientInstrumentalInvestigation
Usage: #example
Title: "Kidney example — graft Doppler ultrasound"
Description: "Doppler ultrasound of the transplanted kidney at the 1-month visit."
* identifier.system = $pcid
* identifier.value = "IIV-2-0001"
* status = #final
* code = InstrumentalInvestigationNameCS#4167052 "Kidney doppler ultrasound"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* encounter = Reference(KidneyVisitMonth1)
* effectiveDateTime = "2024-04-12"
* valueCodeableConcept = PatientInstrumentalInvestigationResultCS#normal "Normal"

// ---------------- BK virus surveillance and nephropathy ----------------

Instance: KidneyMicrobiology1
InstanceOf: Microbiology
Usage: #example
Title: "Kidney example — BK virus surveillance panel"
Description: "BK-virus surveillance in blood, urine and graft biopsy — the kidney-specific analytes of the microbiology panel, which a liver record does not carry."
* identifier.system = $pcid
* identifier.value = "MIC-2-0001"
* status = #final
* code = MicrobiologyCS#microbiology-panel "Microbiology studies panel"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* encounter = Reference(KidneyVisitRejection1)
* effectiveDateTime = "2024-06-20"
// pc-micro-1: the BKV kidney-biopsy components require the transplant type to be stated
* extension[tx_type].valueCodeableConcept = TransplantTypeCS#kidney "Kidney transplant"
* component[bloodBkvDna].code = MicrobiologyCS#blood-bkv-dna
* component[bloodBkvDna].valueBoolean = true
* component[bloodBkvDnaCopies].code = MicrobiologyCS#blood-bkv-dna-copies
* component[bloodBkvDnaCopies].valueQuantity.value = 42000
* component[bloodBkvDnaCopies].valueQuantity.system = $ucum
* component[bloodBkvDnaCopies].valueQuantity.code = #{copies}/mL
* component[bloodBkvDnaCopies].valueQuantity.unit = "copies/mL"
* component[urineBkvDna].code = MicrobiologyCS#urine-bkv-dna
* component[urineBkvDna].valueBoolean = true
* component[bkvDnaKidneyBiopsy].code = MicrobiologyCS#bkv-dna-kidney-biopsy
* component[bkvDnaKidneyBiopsy].valueBoolean = true
* component[bkvFishKidneyBiopsy].code = MicrobiologyCS#bkv-fish-kidney-biopsy
* component[bkvFishKidneyBiopsy].valueBoolean = true

Instance: KidneyMicrobiologyDiagnosis1
InstanceOf: MicrobiologyDiagnosis
Usage: #example
Title: "Kidney example — BK virus nephropathy"
Description: "Histological evidence of BK-virus-associated nephropathy on the graft biopsy."
* category = $cond-cat#encounter-diagnosis
* code = MicrobiologyCS#evidence-bkvan "Histological evidence of BKVAN"
* subject = Reference(KidneyRecipient1)
* encounter = Reference(KidneyVisitRejection1)
* onsetDateTime = "2024-06-20"

Instance: KidneyEventBkv1
InstanceOf: ClinicalEvent
Usage: #example
Title: "Kidney example — BK virus infection"
Description: "BK-virus infection with biopsy-proven nephropathy — the typed event the microbiology panel and histology support."

* identifier.system = $pcid
* identifier.value = "CLE-2-0003"
* clinicalStatus = $clin-st#active
* code = ClinicalEventTypeCS#bk-virus-infection "BK Virus Infection"
* subject = Reference(KidneyRecipient1)
* encounter = Reference(KidneyVisitRejection1)
* onsetDateTime = "2024-06-20"

// ---------------- Rejection episode ----------------

Instance: KidneyEventRejection1
InstanceOf: ClinicalEvent
Usage: #example
Title: "Kidney example — acute kidney rejection episode"
Description: "Acute rejection on repeat biopsy, following the immunosuppression reduction that BKVAN required — a recognised route into rejection."
* identifier.system = $pcid
* identifier.value = "CLE-2-0002"
* clinicalStatus = $clin-st#active
* code = ClinicalEventTypeCS#kidney-rejection-episode "Kidney Rejection Episode"
* subject = Reference(KidneyRecipient1)
* encounter = Reference(KidneyVisitRejection2)
* onsetDateTime = "2024-09-10"

Instance: KidneyImmunologyBiopsy1
InstanceOf: ImmunologicalData
Usage: #example
Title: "Kidney example — biopsy immunology panel"
Description: "Banff category, C4d and DSA from the repeat biopsy. A class II DSA alongside a C4d-negative Banff 4 picture — antibody present, but not antibody-mediated rejection, hence a steroid pulse."
* identifier.system = $pcid
* identifier.value = "IMD-2-0001"
* status = #final
* category = $obs-cat#laboratory
* code = ImmunologicalDataPanelCS#immunological-data-panel "Immunological data panel"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* encounter = Reference(KidneyVisitRejection2)
* effectiveDateTime = "2024-09-10"
* component[banff_category].code = ImmDataComponentCS#banff-category "Banff rejection category"
* component[banff_category].valueCodeableConcept = BanffCategoryCS#4 "Banff 4 – T cell-mediated rejection"
* component[ihc_if_c4d].code = ImmDataComponentCS#ihc-if-c4d "IHC/IF C4d result"
* component[ihc_if_c4d].valueBoolean = false
* component[post_tx_dsa_class].code = ImmDataComponentCS#post-tx-dsa-class "Post-transplant anti-HLA DSA class"
* component[post_tx_dsa_class].valueCodeableConcept = DSAClassCS#class-ii "Class II"
* component[mfi].code = ImmDataComponentCS#mfi-category "MFI category"
* component[mfi].valueCodeableConcept = MFICategoryCS#MR "MR (moderate, 2k–4k)"

// ---------------- Immunosuppression ----------------

Instance: KidneyImmPatMaintenance1
InstanceOf: ImmPat
Usage: #example
Title: "Kidney example — maintenance immunosuppression"
Description: "Maintenance tacrolimus, started on the day of transplant alongside induction — a CNI does not wait for discharge."
* identifier.system = $pcid
* identifier.value = "IMP-2-0001"
* status = #active
* subject = Reference(KidneyRecipient1)
* medicationReference = Reference(ImmunosuppressantTacrolimus1)
* context = Reference(KidneyVisitPreTx1)
* category = ImmPatPhaseCS#maintenance "Maintenance"
* effectivePeriod.start = "2024-03-12"
* effectivePeriod.end = "2024-06-20"
* dosage.text = "Divided twice daily."
* dosage.doseAndRate.doseQuantity.value = 0.1
* dosage.doseAndRate.doseQuantity.system = "http://unitsofmeasure.org"
* dosage.doseAndRate.doseQuantity.code = #mg.kg-1
* dosage.doseAndRate.doseQuantity.unit = "mg/kg"

Instance: KidneyImmPatPk1
InstanceOf: ImmPatPKObservation
Usage: #example
Title: "Kidney example — tacrolimus trough level"
Description: "Pre-dose (C0) tacrolimus level at the 1-month visit, linked to the maintenance record via Observation.partOf."
* partOf = Reference(KidneyImmPatMaintenance1)
* status = #final
* category = $obs-cat#laboratory
* code = ImmPatPKTypeCS#pre-dose-level "Pre-dose drug level (trough / C0)"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* effectiveDateTime = "2024-04-12"
* valueQuantity.value = 6.2
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #ng.mL-1
* valueQuantity.unit = "ng/mL"

Instance: KidneyImmPatInduction1
InstanceOf: ImmPat
Usage: #example
Title: "Kidney example — antibody induction"
Description: "Basiliximab induction, 20 mg on the day of transplant and day 4 — the standard paediatric regimen."

* identifier.system = $pcid
* identifier.value = "IMP-2-0002"
* status = #completed
* subject = Reference(KidneyRecipient1)
* medicationReference = Reference(ImmunosuppressantBasiliximab1)
* context = Reference(KidneyVisitPreTx1)
* category = ImmPatPhaseCS#induction "Induction"
* effectivePeriod.start = "2024-03-12"
* effectivePeriod.end = "2024-03-16"
* dosage.doseAndRate.doseQuantity.value = 20
* dosage.doseAndRate.doseQuantity.system = "http://unitsofmeasure.org"
* dosage.doseAndRate.doseQuantity.code = #mg
* dosage.doseAndRate.doseQuantity.unit = "mg"

Instance: KidneyCreatinineRejection1
InstanceOf: LabResultObservation
Usage: #example
Title: "Kidney example — creatinine at the rejection episode"
Description: "Creatinine risen from 1.6 to 2.4 mg/dL — what brings him in and prompts the graft biopsy."

* id = "kidney-lab-creatinine-rejection-1"
* identifier.system = $pcid
* identifier.value = "LBR-2-0002"
* status = #final
* category.coding.system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category.coding.code = #laboratory
* category.coding.display = "Laboratory"
* code = $loinc#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* encounter = Reference(KidneyVisitRejection1)
* effectiveDateTime = "2024-06-20T08:20:00+02:00"
* valueQuantity.value = 2.4
* valueQuantity.code = #"mg/dL"
* valueQuantity.unit = "mg/dL"
* valueQuantity.system = "http://unitsofmeasure.org"
* interpretation[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"
* interpretation[0].coding[0].code = #H
* interpretation[0].coding[0].display = "High"


// ---------------- Immunosuppression reduction, rejection treatment, outcome ----------------

Instance: KidneyImmPatReduced1
InstanceOf: ImmPat
Usage: #example
Title: "Kidney example — tacrolimus reduced for BK-virus nephropathy"
Description: "Tacrolimus halved once BKVAN was proven — the only established treatment, and the step that exposes the graft to the rejection three months later."

* identifier.system = $pcid
* identifier.value = "IMP-2-0003"
* status = #active
* subject = Reference(KidneyRecipient1)
* medicationReference = Reference(ImmunosuppressantTacrolimus1)
* context = Reference(KidneyVisitRejection1)
* category = ImmPatPhaseCS#maintenance "Maintenance"
* effectivePeriod.start = "2024-06-20"
* dosage.text = "Halved in response to biopsy-proven BK-virus nephropathy. Divided twice daily."
* dosage.doseAndRate.doseQuantity.value = 0.05
* dosage.doseAndRate.doseQuantity.system = "http://unitsofmeasure.org"
* dosage.doseAndRate.doseQuantity.code = #mg.kg-1
* dosage.doseAndRate.doseQuantity.unit = "mg/kg"

Instance: KidneyImmPatRejectionTreatment1
InstanceOf: ImmPat
Usage: #example
Title: "Kidney example — steroid pulse for the rejection episode"
Description: "Methylprednisolone pulse, 10 mg/kg/day × 3 days, for the Banff 4 rejection. Recorded as #maintenance — the DM has no rejection-treatment phase."

* identifier.system = $pcid
* identifier.value = "IMP-2-0004"
* status = #completed
* subject = Reference(KidneyRecipient1)
* medicationReference = Reference(ImmunosuppressantExample1)
* context = Reference(KidneyVisitRejection2)
* category = ImmPatPhaseCS#maintenance "Maintenance"
* effectivePeriod.start = "2024-09-10"
* effectivePeriod.end = "2024-09-12"
* dosage.text = "Rejection treatment: intravenous methylprednisolone pulse, once daily for three consecutive days, for the rejection episode recorded at this visit. Not maintenance therapy — the DM phase list has no value for rejection treatment."
* dosage.doseAndRate.doseQuantity.value = 10
* dosage.doseAndRate.doseQuantity.system = "http://unitsofmeasure.org"
* dosage.doseAndRate.doseQuantity.code = #mg.kg-1
* dosage.doseAndRate.doseQuantity.unit = "mg/kg"

Instance: KidneyCreatinineRejection2
InstanceOf: LabResultObservation
Usage: #example
Title: "Kidney example — creatinine at the rejection episode"
Description: "Creatinine risen from 2.4 to 3.1 mg/dL — what triggers the repeat biopsy."

* id = "kidney-lab-creatinine-rejection-2"
* identifier.system = $pcid
* identifier.value = "LBR-2-0003"
* status = #final
* category.coding.system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category.coding.code = #laboratory
* category.coding.display = "Laboratory"
* code = $loinc#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* encounter = Reference(KidneyVisitRejection2)
* effectiveDateTime = "2024-09-10T08:30:00+02:00"
* valueQuantity.value = 3.1
* valueQuantity.code = #"mg/dL"
* valueQuantity.unit = "mg/dL"
* valueQuantity.system = "http://unitsofmeasure.org"
* interpretation[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"
* interpretation[0].coding[0].code = #H
* interpretation[0].coding[0].display = "High"

// ---------------- Outcome ----------------

Instance: KidneyEventGraftFailure1
InstanceOf: ClinicalEvent
Usage: #example
Title: "Kidney example — graft failure"
Description: "Graft loss ten months after transplantation, after BKVAN and a rejection that did not fully respond. The study outcome — without it, a failed graft is indistinguishable from loss to follow-up."

* identifier.system = $pcid
* identifier.value = "CLE-2-0004"
* clinicalStatus = $clin-st#active
* code = ClinicalEventTypeCS#graft-failure "Graft Failure"
* subject = Reference(KidneyRecipient1)
* encounter = Reference(KidneyVisitTermination1)
* onsetDateTime = "2025-01-20"

Instance: KidneyDialysisChronic1
InstanceOf: ClinicalEventProcedure
Usage: #example
Title: "Kidney example — return to haemodialysis"
Description: "Haemodialysis restarted on graft failure. Still running: the profile pins status to #completed, so ongoing therapy is shown by an open performedPeriod, not by status."

* status = #completed
* code = ClinicalEventProcedureTypeCS#hemodialysis "Hemodialysis"
* subject = Reference(KidneyRecipient1)
* reasonReference = Reference(KidneyEventGraftFailure1)
* performedPeriod.start = "2025-01-20"

Instance: KidneyRelisting1
InstanceOf: ClinicalEventProcedure
Usage: #example
Title: "Kidney example — relisted for retransplantation"
Description: "Placement back on the transplant waiting list after graft failure (DMv1.2 clinical_event.date_entry_transplant_list)."

* status = #completed
* code = ClinicalEventProcedureTypeCS#transplant-listing "Listed for retransplant"
* subject = Reference(KidneyRecipient1)
* reasonReference = Reference(KidneyEventGraftFailure1)
* performedDateTime = "2025-02-10"

Instance: KidneyCreatinineTermination1
InstanceOf: LabResultObservation
Usage: #example
Title: "Kidney example — creatinine at graft failure"
Description: "Serum creatinine at the termination visit."

* id = "kidney-lab-creatinine-termination-1"
* identifier.system = $pcid
* identifier.value = "LBR-2-0004"
* status = #final
* category.coding.system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category.coding.code = #laboratory
* category.coding.display = "Laboratory"
* code = $loinc#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"
* subject = Reference(KidneyRecipient1)
* performer = Reference(PCCenter2Padova)
* encounter = Reference(KidneyVisitTermination1)
* effectiveDateTime = "2025-01-20T09:00:00+01:00"
* valueQuantity.value = 5.2
* valueQuantity.code = #"mg/dL"
* valueQuantity.unit = "mg/dL"
* valueQuantity.system = "http://unitsofmeasure.org"
* interpretation[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"
* interpretation[0].coding[0].code = #H
* interpretation[0].coding[0].display = "High"

// ==============================================================
// The Bundle
// ==============================================================

Instance: ProtectChildKidneyRecipientJourneyExample
InstanceOf: Bundle
Usage: #example
Title: "Worked Example (kidney) — recipient REC-2-0001"
Description: "A paediatric kidney transplant recipient (REC-2-0001, Padova) from the pre-transplant work-up through the living-donor transplant, delayed graft function, follow-up, and a rejection episode with BK-virus nephropathy — assembled as one collection Bundle in which every internal reference resolves."

* type = #collection
* timestamp = "2024-07-01T10:00:00+02:00"

// ---- Study centre and patients ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Organization/PCCenter2Padova"
* entry[=].resource = PCCenter2Padova
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Patient/KidneyRecipient1"
* entry[=].resource = KidneyRecipient1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Patient/KidneyDonor1"
* entry[=].resource = KidneyDonor1

// ---- Catalogue entries (study-wide, no date of their own) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Medication/ImmunosuppressantBasiliximab1"
* entry[=].resource = ImmunosuppressantBasiliximab1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Medication/ImmunosuppressantTacrolimus1"
* entry[=].resource = ImmunosuppressantTacrolimus1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Medication/ImmunosuppressantExample1"
* entry[=].resource = ImmunosuppressantExample1

// ---- Recipient history — primary disease ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/KidneyRecipientDiagnosis1"
* entry[=].resource = KidneyRecipientDiagnosis1

// ---- Pre-transplant episode and transplant admission (2024-03-01 .. 2024-03-25) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/KidneyVisitPreTx1"
* entry[=].resource = KidneyVisitPreTx1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/KidneyRecipientAge1"
* entry[=].resource = KidneyRecipientAge1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Procedure/KidneyTransplant1"
* entry[=].resource = KidneyTransplant1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Procedure/KidneyAnastomosis1"
* entry[=].resource = KidneyAnastomosis1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/KidneyIntraopComplication1"
* entry[=].resource = KidneyIntraopComplication1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/KidneyEventDgf1"
* entry[=].resource = KidneyEventDgf1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Procedure/KidneyDialysis1"
* entry[=].resource = KidneyDialysis1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/KidneyImmPatInduction1"
* entry[=].resource = KidneyImmPatInduction1

// ---- 1-month follow-up visit (2024-04-12) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/KidneyVisitMonth1"
* entry[=].resource = KidneyVisitMonth1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/KidneyVitalSign1"
* entry[=].resource = KidneyVitalSign1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/kidney-lab-creatinine-month-1"
* entry[=].resource = KidneyCreatinineMonth1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/KidneyInvestigation1"
* entry[=].resource = KidneyInvestigation1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/KidneyImmPatMaintenance1"
* entry[=].resource = KidneyImmPatMaintenance1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/KidneyImmPatPk1"
* entry[=].resource = KidneyImmPatPk1

// ---- Clinical-event visit — rejection with BK-virus nephropathy (2024-06-20) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/KidneyVisitRejection1"
* entry[=].resource = KidneyVisitRejection1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/KidneyMicrobiology1"
* entry[=].resource = KidneyMicrobiology1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/KidneyMicrobiologyDiagnosis1"
* entry[=].resource = KidneyMicrobiologyDiagnosis1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/kidney-lab-creatinine-rejection-1"
* entry[=].resource = KidneyCreatinineRejection1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/KidneyEventBkv1"
* entry[=].resource = KidneyEventBkv1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/KidneyImmPatReduced1"
* entry[=].resource = KidneyImmPatReduced1

// ---- Clinical-event visit — acute rejection after the reduction (2024-09-10) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/KidneyVisitRejection2"
* entry[=].resource = KidneyVisitRejection2
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/KidneyEventRejection1"
* entry[=].resource = KidneyEventRejection1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/KidneyImmunologyBiopsy1"
* entry[=].resource = KidneyImmunologyBiopsy1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/kidney-lab-creatinine-rejection-2"
* entry[=].resource = KidneyCreatinineRejection2
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/MedicationStatement/KidneyImmPatRejectionTreatment1"
* entry[=].resource = KidneyImmPatRejectionTreatment1

// ---- Termination visit — graft failure (2025-01-20) ----
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Encounter/KidneyVisitTermination1"
* entry[=].resource = KidneyVisitTermination1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Condition/KidneyEventGraftFailure1"
* entry[=].resource = KidneyEventGraftFailure1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Observation/kidney-lab-creatinine-termination-1"
* entry[=].resource = KidneyCreatinineTermination1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Procedure/KidneyDialysisChronic1"
* entry[=].resource = KidneyDialysisChronic1
* entry[+].fullUrl = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/Procedure/KidneyRelisting1"
* entry[=].resource = KidneyRelisting1
