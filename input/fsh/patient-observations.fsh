// patient-observations.fsh
// Patient and donor fact observations.
//
// Profiles defined here:
//   PatientDemographicsObservation — age_years, age_months (category: survey)
//   PatientImmunologyObservation  — max_pra, last_pra, date_histological_diag (category: laboratory)
//   PatientLiverDiseaseDiagnosis / PatientRenalDiseaseDiagnosis — Condition resources
//   DonorPreKtxDialysisTypeObservation / DonorLiverTypeObservation — donor-specific Observations
//
// ABO/Rh CodeSystems and ValueSets are defined here and reused by immunological-data.fsh.

Alias: $loinc    = http://loinc.org
Alias: $ucum     = http://unitsofmeasure.org
Alias: $obs-cat  = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $snomed   = http://snomed.info/sct

// ------------------------------------------------------
// Terminology – ABO, Rh (also used by ImmunologicalData)
// ------------------------------------------------------

CodeSystem: PatientABOGroupCS
Id: patient-abo-group-cs
Title: "ABO Group CodeSystem"
Description: "ABO blood groups for transplant recipients and donors."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/patient-abo-group"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #A  "Group A"
* #B  "Group B"
* #AB "Group AB"
* #O  "Group O"

ValueSet: PatientABOGroupVS
Id: patient-abo-group-vs
Title: "ABO Group ValueSet"
Description: "ABO blood groups for transplant recipients and donors."
* PatientABOGroupCS#A
* PatientABOGroupCS#B
* PatientABOGroupCS#AB
* PatientABOGroupCS#O

CodeSystem: PatientRhFactorCS
Id: patient-rh-factor-cs
Title: "Rh Factor CodeSystem"
Description: "Rh factor for transplant recipients and donors."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/patient-rh-factor"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #positive "Rh positive"
* #negative "Rh negative"

ValueSet: PatientRhFactorVS
Id: patient-rh-factor-vs
Title: "Rh Factor ValueSet"
* PatientRhFactorCS#positive
* PatientRhFactorCS#negative

// ------------------------------------------------------
// Terminology – PRA component codes (max vs last)
// ------------------------------------------------------

CodeSystem: PatientPRATypeCS
Id: patient-pra-type-cs
Title: "PRA Type CodeSystem"
Description: "Distinguishes maximum (historical) vs most recent PRA measurements. Used as component codes in PatientImmunologyObservation."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/patient-pra-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #max  "Maximum PRA (historical)"
* #last "Most recent PRA"

ValueSet: PatientPRATypeVS
Id: patient-pra-type-vs
Title: "PRA Type ValueSet"
* PatientPRATypeCS#max
* PatientPRATypeCS#last

// ------------------------------------------------------
// Terminology – Donor liver type
// ------------------------------------------------------

CodeSystem: DonorLiverTypeCS
Id: donor-liver-type-cs
Title: "Donor Liver Type CodeSystem"
Description: "Type of liver donation (complete vs partial)."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/donor-liver-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #complete "Complete liver graft"
* #partial  "Partial liver graft"

ValueSet: DonorLiverTypeVS
Id: donor-liver-type-vs
Title: "Donor Liver Type ValueSet"
* DonorLiverTypeCS#complete
* DonorLiverTypeCS#partial

// ------------------------------------------------------
// Terminology – Dialysis method (donor pre-KTX)
// ------------------------------------------------------

ValueSet: DialysisTypeVS
Id: dialysis-type-vs
Title: "Dialysis method ValueSet"
Description: "Dialysis method values using LOINC answer codes."
* $loinc#LA9975-9  "Hemodialysis"
* $loinc#LA10059-6 "Peritoneal Dialysis"

// ------------------------------------------------------
// Terminology – panel codes (demographics and immunology panels)
// ------------------------------------------------------

CodeSystem: PatientObservationsPanelCS
Id: patient-observations-panel-cs
Title: "Patient Observations Panel CodeSystem"
Description: "Local codes for PROTECT-CHILD patient observation panels."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/patient-observations-panel"
* ^content = #complete
* ^caseSensitive = true
* ^experimental = true
* #patient-demographics-panel "Patient demographics panel (age)"
* #patient-immunology-panel   "Patient pre-transplant immunology panel (PRA, histological date)"

// ================================================
// Profile: PatientDemographicsObservation
// Age at transplant — category survey; one instance per patient or donor.
// ================================================

Profile: PatientDemographicsObservation
Parent: Observation
Id: patient-demographics-observation
Title: "Patient Demographics Observation"
Description: "Panel Observation for patient or donor age at transplant (age_years, age_months). Category is #survey to distinguish from laboratory results. One instance per patient or donor. Subject accepts PatientTransplant or Donor."

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#survey (exactly)
* category ^short = "survey — demographic measurement, not a lab result"

* code 1..1 MS
* code = PatientObservationsPanelCS#patient-demographics-panel "Patient demographics panel (age)" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant or Donor)
* subject ^short = "Transplant recipient or donor"

* effective[x] 0..1 MS

// ── Component slicing ──────────────────────────────────────────────────────

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component MS

// age_years — LOINC 30525-0
* component contains age_years 0..1 MS
* component[age_years].code = $loinc#30525-0 "Age" (exactly)
* component[age_years].value[x] only Quantity
* component[age_years].valueQuantity.system = $ucum
* component[age_years].valueQuantity.code = #a
* component[age_years] ^short = "age_years — patient age in years (UCUM a)"

// age_months — LOINC 63900-5
* component contains age_months 0..1 MS
* component[age_months].code = $loinc#63900-5 "Current age Months" (exactly)
* component[age_months].value[x] only Quantity
* component[age_months].valueQuantity.system = $ucum
* component[age_months].valueQuantity.code = #mo
* component[age_months] ^short = "age_months — patient age in months (UCUM mo); paediatric precision"

// ================================================
// Profile: PatientImmunologyObservation
// Pre-transplant PRA + histological date — category laboratory.
// One instance per patient (not used for donors).
// ================================================

Profile: PatientImmunologyObservation
Parent: Observation
Id: patient-immunology-observation
Title: "Patient Pre-transplant Immunology Observation"
Description: "Panel Observation for pre-transplant immunological scalar facts: maximum PRA, most recent PRA, and histological diagnosis date. Category is #laboratory. One instance per transplant recipient. ABO/Rh and HLA typing are in ImmunologicalData."

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#laboratory (exactly)
* category ^short = "laboratory — immunological measurements"

* code 1..1 MS
* code = PatientObservationsPanelCS#patient-immunology-panel "Patient pre-transplant immunology panel (PRA, histological date)" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

* effective[x] 0..1 MS

// ── Component slicing ──────────────────────────────────────────────────────

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component MS

// max_pra — PatientPRATypeCS#max
* component contains max_pra 0..1 MS
* component[max_pra].code = PatientPRATypeCS#max "Maximum PRA (historical)" (exactly)
* component[max_pra].value[x] only integer
* component[max_pra] ^short = "max_pra — maximum historical pre-transplant PRA/cPRA (0–100 %)"

// last_pra — PatientPRATypeCS#last
* component contains last_pra 0..1 MS
* component[last_pra].code = PatientPRATypeCS#last "Most recent PRA" (exactly)
* component[last_pra].value[x] only integer
* component[last_pra] ^short = "last_pra — most recent pre-transplant PRA/cPRA (0–100 %)"

// date_histological_diag — LOINC 77975-1
* component contains date_histological_diag 0..1 MS
* component[date_histological_diag].code = $loinc#77975-1 "Earliest date of diagnosis" (exactly)
* component[date_histological_diag].value[x] only dateTime
* component[date_histological_diag] ^short = "date_histological_diag — date histology confirmed the primary disease"

// ================================================
// Profile: PatientLiverDiseaseDiagnosis — Condition
// Primary liver disease leading to transplantation.
// ================================================

Profile: PatientLiverDiseaseDiagnosis
Parent: Condition
Id: patient-liver-disease-diagnosis
Title: "Patient Liver Disease Diagnosis"
Description: "Primary liver disease diagnosis that led to transplantation, aligned with DMv1.2 diag_primary_disease and date_diag_primary_disease. date_diag_primary_disease maps to Condition.onsetDateTime."

* clinicalStatus 1..1 MS
* clinicalStatus ^short = "Clinical status of the diagnosis at time of transplant"

// diag_primary_disease → Condition.code (any coding system; ICD-10 recommended)
* code 1..1 MS
* code ^short = "diag_primary_disease — primary liver disease diagnosis code"

* bodySite 1..1 MS
* bodySite = $snomed#10200004 "Liver structure" (exactly)
* bodySite ^short = "Liver — distinguishes this from the renal diagnosis profile"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// date_diag_primary_disease → Condition.onsetDateTime
* onset[x] 1..1 MS
* onset[x] only dateTime
* onsetDateTime ^short = "date_diag_primary_disease — date the primary liver disease was first diagnosed"

// diag_liver_disease_extra → Condition.note (free text)
* note 0..1 MS
* note ^short = "diag_liver_disease_extra — free-text supplement to the coded diagnosis"

// ================================================
// Profile: PatientRenalDiseaseDiagnosis — Condition
// Primary renal disease leading to transplantation.
// ================================================

Profile: PatientRenalDiseaseDiagnosis
Parent: Condition
Id: patient-renal-disease-diagnosis
Title: "Patient Renal Disease Diagnosis"
Description: "Primary renal disease diagnosis that led to transplantation, aligned with DMv1.2 diag_primary_disease and date_diag_primary_disease. date_diag_primary_disease maps to Condition.onsetDateTime."

* clinicalStatus 1..1 MS
* clinicalStatus ^short = "Clinical status of the diagnosis at time of transplant"

// diag_primary_disease → Condition.code
* code 1..1 MS
* code ^short = "diag_primary_disease — primary renal disease diagnosis code"

* bodySite 1..1 MS
* bodySite = $snomed#64033007 "Kidney structure" (exactly)
* bodySite ^short = "Kidney — distinguishes this from the liver diagnosis profile"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// date_diag_primary_disease → Condition.onsetDateTime
* onset[x] 1..1 MS
* onset[x] only dateTime
* onsetDateTime ^short = "date_diag_primary_disease — date the primary renal disease was first diagnosed"

// diag_renal_disease_extra → Condition.note (free text)
* note 0..1 MS
* note ^short = "diag_renal_disease_extra — free-text supplement to the coded diagnosis"

// ================================================
// Organ invariants for donor-specific observations
// ================================================

Invariant: pc-donor-1
Description: "Donor liver graft type is only applicable for liver or combined transplants."
Severity: #error
Expression: "extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').exists() implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'liver' or code = 'combined').exists()"

Invariant: pc-donor-2
Description: "Donor pre-KTX dialysis type is only applicable for kidney or combined transplants."
Severity: #error
Expression: "extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').exists() implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'kidney' or code = 'combined').exists()"

// ================================================
// Profile: DonorPreKtxDialysisTypeObservation (donor-specific)
// ================================================

Profile: DonorPreKtxDialysisTypeObservation
Parent: Observation
Id: donor-pre-ktx-dialysis-type-observation
Title: "Donor pre-KTX dialysis type observation"
Description: "Dialysis method prior to kidney transplantation (LOINC 70958-4). Only applicable for kidney or combined transplants — invariant pc-donor-2 enforces this when tx_type extension is present."

* obeys pc-donor-2
* extension contains TransplantTypeExt named tx_type 0..1 MS
* extension[tx_type] ^short = "Transplant type context — should be kidney or combined"

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#procedure (exactly)

* code 1..1 MS
* code = $loinc#70958-4 "Dialysis method [ESRD]" (exactly)

* subject 1..1 MS
* subject only Reference(Donor)

* effective[x] 0..1 MS

* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from DialysisTypeVS (required)

// ================================================
// Profile: DonorLiverTypeObservation (donor-specific)
// ================================================

Profile: DonorLiverTypeObservation
Parent: Observation
Id: donor-liver-type-observation
Title: "Donor liver graft type observation"
Description: "Type of liver graft (complete vs partial) captured as an Observation (LOINC 74836-8). Only applicable for liver or combined transplants — invariant pc-donor-1 enforces this when tx_type extension is present."

* obeys pc-donor-1
* extension contains TransplantTypeExt named tx_type 0..1 MS
* extension[tx_type] ^short = "Transplant type context — should be liver or combined"

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#procedure (exactly)

* code 1..1 MS
* code = $loinc#74836-8 "Transplant type [Anatomy]" (exactly)

* subject 1..1 MS
* subject only Reference(Donor)

* effective[x] 0..1 MS

* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from DonorLiverTypeVS (required)

// ================================================
// Examples
// ================================================

Instance: ExamplePatientAgeObservation1
InstanceOf: PatientDemographicsObservation
Usage: #example
Title: "Example patient age observation"
Description: "Age at transplant for the recipient (PatientDemographicsObservation)."

* status = #final
* category = $obs-cat#survey
* code = PatientObservationsPanelCS#patient-demographics-panel "Patient demographics panel (age)"
* subject = Reference(ExamplePatientTransplant1)
* effectiveDateTime = "2025-01-10"

* component[age_years].valueQuantity.value = 9
* component[age_years].valueQuantity.system = $ucum
* component[age_years].valueQuantity.code = #a
* component[age_years].valueQuantity.unit = "years"

* component[age_months].valueQuantity.value = 108
* component[age_months].valueQuantity.system = $ucum
* component[age_months].valueQuantity.code = #mo
* component[age_months].valueQuantity.unit = "months"

Instance: ExamplePatientImmunologyObservation1
InstanceOf: PatientImmunologyObservation
Usage: #example
Title: "Example patient pre-transplant immunology observation"
Description: "PRA and histological diagnosis date for the recipient (PatientImmunologyObservation)."

* status = #final
* category = $obs-cat#laboratory
* code = PatientObservationsPanelCS#patient-immunology-panel "Patient pre-transplant immunology panel (PRA, histological date)"
* subject = Reference(ExamplePatientTransplant1)
* effectiveDateTime = "2025-01-10"

* component[max_pra].valueInteger = 80
* component[last_pra].valueInteger = 55
* component[date_histological_diag].valueDateTime = "2024-05-10"

Instance: ExamplePatientLiverDiagnosis1
InstanceOf: PatientLiverDiseaseDiagnosis
Usage: #example
Title: "Example patient liver disease diagnosis"
Description: "Primary liver disease diagnosis leading to transplantation."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* code = http://hl7.org/fhir/sid/icd-10#K74.60 "Unspecified cirrhosis of liver"
* bodySite = $snomed#10200004 "Liver structure"
* subject = Reference(ExamplePatientTransplant1)
* onsetDateTime = "2020-03-01"
* note.text = "Extra details about the diagnosis (free text)."

Instance: ExamplePatientRenalDiagnosis1
InstanceOf: PatientRenalDiseaseDiagnosis
Usage: #example
Title: "Example patient renal disease diagnosis"
Description: "Primary renal disease diagnosis leading to transplantation."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* code = http://hl7.org/fhir/sid/icd-10#N18.5 "Chronic kidney disease, stage 5"
* bodySite = $snomed#64033007 "Kidney structure"
* subject = Reference(ExamplePatientTransplant1)
* onsetDateTime = "2021-09-15"
* note.text = "Extra renal diagnosis details (free text)."

Instance: ExampleDonorAgeObservation1
InstanceOf: PatientDemographicsObservation
Usage: #example
Title: "Example donor age observation"
Description: "Age at donation for the transplant donor (PatientDemographicsObservation; subject = Reference(Donor))."

* status = #final
* category = $obs-cat#survey
* code = PatientObservationsPanelCS#patient-demographics-panel "Patient demographics panel (age)"
* subject = Reference(ExampleDonor1)
* effectiveDateTime = "2025-01-01"

* component[age_years].valueQuantity.value = 25
* component[age_years].valueQuantity.system = $ucum
* component[age_years].valueQuantity.code = #a
* component[age_years].valueQuantity.unit = "years"

* component[age_months].valueQuantity.value = 300
* component[age_months].valueQuantity.system = $ucum
* component[age_months].valueQuantity.code = #mo
* component[age_months].valueQuantity.unit = "months"

Instance: ExampleDonorLiverType1
InstanceOf: DonorLiverTypeObservation
Usage: #example
Title: "Example donor liver graft type"
Description: "Complete liver graft from a deceased donor."

* status = #final
* category = $obs-cat#procedure
* code = $loinc#74836-8 "Transplant type [Anatomy]"
* subject = Reference(ExampleDonor1)
* effectiveDateTime = "2025-01-01"
* valueCodeableConcept = DonorLiverTypeCS#complete "Complete liver graft"

Instance: ExampleDonorDialysisType1
InstanceOf: DonorPreKtxDialysisTypeObservation
Usage: #example
Title: "Example donor pre-KTX dialysis type"
Description: "Hemodialysis prior to kidney transplant."

* status = #final
* category = $obs-cat#procedure
* code = $loinc#70958-4 "Dialysis method [ESRD]"
* subject = Reference(ExampleDonor1)
* effectiveDateTime = "2024-11-15"
* valueCodeableConcept = $loinc#LA9975-9 "Hemodialysis"
