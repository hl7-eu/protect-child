// patient-observations.fsh
// Patient and donor fact observations.
//
// Profiles defined here:
//   PatientDemographicsObservation — age_years, age_months (category: survey)
//   PatientImmunologyObservation  — max_pra, last_pra, date_histological_diag (category: laboratory)
//   PatientPrimaryDiseaseDiagnosis — Condition resource (organ in bodySite)
//   DonorLiverTypeObservation — donor-specific Observation
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
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #A  "Group A" "ABO blood group A."
* #B  "Group B" "ABO blood group B."
* #AB "Group AB" "ABO blood group AB."
* #O  "Group O" "ABO blood group O."

ValueSet: PatientABOGroupVS
Id: patient-abo-group-vs
Title: "ABO Group ValueSet"
Description: "ABO blood groups for transplant recipients and donors."
* ^experimental = true
* PatientABOGroupCS#A
* PatientABOGroupCS#B
* PatientABOGroupCS#AB
* PatientABOGroupCS#O

CodeSystem: PatientRhFactorCS
Id: patient-rh-factor-cs
Title: "Rh Factor CodeSystem"
Description: "Rh factor for transplant recipients and donors."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #positive "Rh positive" "Rhesus (Rh) D antigen positive."
* #negative "Rh negative" "Rhesus (Rh) D antigen negative."

ValueSet: PatientRhFactorVS
Id: patient-rh-factor-vs
Title: "Rh Factor ValueSet"
Description: "Rhesus (Rh) blood group factor: positive or negative."
* ^experimental = true
* PatientRhFactorCS#positive
* PatientRhFactorCS#negative

// ------------------------------------------------------
// Terminology – PRA component codes (max vs last)
// ------------------------------------------------------

CodeSystem: PatientPRATypeCS
Id: patient-pra-type-cs
Title: "PRA Type CodeSystem"
Description: "Distinguishes maximum (historical) vs most recent PRA measurements. Used as component codes in PatientImmunologyObservation."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #max  "Maximum PRA (historical)" "Maximum historical panel-reactive antibody (PRA/cPRA) value."
* #last "Most recent PRA" "Most recent panel-reactive antibody (PRA/cPRA) value."
CodeSystem: DonorLiverTypeCS
Id: donor-liver-type-cs
Title: "Donor Liver Type CodeSystem"
Description: "Type of liver donation (whole vs split), per donor.liver_type."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #whole "Whole liver graft" "Whole (entire) liver graft."
* #split "Split liver graft" "Split (partial / reduced-size) liver graft."

ValueSet: DonorLiverTypeVS
Id: donor-liver-type-vs
Title: "Donor Liver Type ValueSet"
Description: "Type of donor liver graft (donor.liver_type: Whole or Split)."
* ^experimental = true
* DonorLiverTypeCS#whole
* DonorLiverTypeCS#split

// ------------------------------------------------------
// Terminology – panel codes (demographics and immunology panels)
// ------------------------------------------------------

CodeSystem: PatientObservationsPanelCS
Id: patient-observations-panel-cs
Title: "Patient Observations Panel CodeSystem"
Description: "Local codes for PROTECT-CHILD patient observation panels and components."
* ^content = #complete
* ^caseSensitive = true
* ^experimental = true
* #patient-demographics-panel "Patient demographics panel (age)" "Panel grouping patient demographic observations (age)."
* #patient-immunology-panel   "Patient pre-transplant immunology panel (PRA, histological date)" "Panel grouping pre-transplant immunology observations (PRA, histological diagnosis date)."
* #age-months                 "Patient age in months" "Patient age expressed in months."

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
* category = $obs-cat#survey
* category ^short = "survey — demographic measurement, not a lab result"

* code 1..1 MS
* code = PatientObservationsPanelCS#patient-demographics-panel "Patient demographics panel (age)"

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
* component[age_years].code = $loinc#30525-0 "Age"
* component[age_years].value[x] only Quantity
* component[age_years].valueQuantity.system = $ucum
* component[age_years].valueQuantity.code = #a
* component[age_years] ^short = "age_years — patient age in years (UCUM a)"

// age_months — local code (no LOINC for age expressed in months)
* component contains age_months 0..1 MS
* component[age_months].code = PatientObservationsPanelCS#age-months "Patient age in months"
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
* category = $obs-cat#laboratory
* category ^short = "laboratory — immunological measurements"

* code 1..1 MS
* code = PatientObservationsPanelCS#patient-immunology-panel "Patient pre-transplant immunology panel (PRA, histological date)"

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
* component[max_pra].code = PatientPRATypeCS#max "Maximum PRA (historical)"
* component[max_pra].value[x] only integer
* component[max_pra] ^short = "max_pra — maximum historical pre-transplant PRA/cPRA (0–100 %)"

// last_pra — PatientPRATypeCS#last
* component contains last_pra 0..1 MS
* component[last_pra].code = PatientPRATypeCS#last "Most recent PRA"
* component[last_pra].value[x] only integer
* component[last_pra] ^short = "last_pra — most recent pre-transplant PRA/cPRA (0–100 %)"

// date_histological_diag — LOINC 77975-1
* component contains date_histological_diag 0..1 MS
* component[date_histological_diag].code = $loinc#77975-1 "Earliest date of diagnosis"
* component[date_histological_diag].value[x] only dateTime
* component[date_histological_diag] ^short = "date_histological_diag — date histology confirmed the primary disease"

// ================================================
// Profile: PatientPrimaryDiseaseDiagnosis — Condition
// Primary disease (liver or renal) leading to transplantation.
// The affected organ is carried in Condition.bodySite.
// ================================================

Profile: PatientPrimaryDiseaseDiagnosis
Parent: Condition
Id: patient-primary-disease-diagnosis
Title: "Patient Primary Disease Diagnosis"
Description: "Primary disease that led to transplantation (diag_primary_disease, date_diag_primary_disease). A single profile for both liver and renal primary disease; the affected organ is given in Condition.bodySite. date_diag_primary_disease maps to Condition.onsetDateTime."

* clinicalStatus 1..1 MS
* clinicalStatus ^short = "Clinical status of the diagnosis at time of transplant"

// diag_primary_disease → Condition.code (any coding system; ICD-10 recommended)
* code 1..1 MS
* code ^short = "diag_primary_disease — primary disease diagnosis code"

// Affected organ — liver or kidney
* bodySite 1..1 MS
* bodySite ^short = "Affected organ — Liver structure (SNOMED 10200004) or Kidney structure (64033007)"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// date_diag_primary_disease → Condition.onsetDateTime
* onset[x] 1..1 MS
* onset[x] only dateTime
* onsetDateTime ^short = "date_diag_primary_disease — date the primary disease was first diagnosed"

// diag_liver_disease_extra / diag_renal_disease_extra → Condition.note (free text)
* note 0..1 MS
* note ^short = "diag_*_disease_extra — free-text supplement to the coded diagnosis"

// ================================================
// Organ invariants for donor-specific observations
// ================================================

Invariant: pc-donor-1
Description: "Donor liver graft type is only applicable for liver or combined transplants: the transplant-type context SHALL be liver or combined."
Severity: #error
Expression: "extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'liver' or code = 'combined').exists()"

// ================================================
// Profile: DonorLiverTypeObservation (donor-specific)
// ================================================

Profile: DonorLiverTypeObservation
Parent: Observation
Id: donor-liver-type-observation
Title: "Donor liver graft type observation"
Description: "Type of liver graft (complete vs partial) captured as an Observation. Only applicable for liver or combined transplants — invariant pc-donor-1 enforces this when tx_type extension is present."

* obeys pc-donor-1
* extension contains TransplantTypeExt named tx_type 1..1 MS
* extension[tx_type] ^short = "Transplant type context — should be liver or combined"

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#procedure

* code 1..1 MS
* code = $loinc#74836-8 "Transplant type [Anatomy]"

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
* performer = Reference(PCCenter1LaPaz)
* effectiveDateTime = "2023-08-15"

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
* performer = Reference(PCCenter1LaPaz)
* encounter = Reference(VisitPreTxExample1)
* effectiveDateTime = "2023-08-01"

* component[max_pra].valueInteger = 80
* component[last_pra].valueInteger = 55
* component[date_histological_diag].valueDateTime = "2020-03-15"

Instance: ExamplePatientLiverDiagnosis1
InstanceOf: PatientPrimaryDiseaseDiagnosis
Usage: #example
Title: "Example patient liver disease diagnosis"
Description: "Primary liver disease diagnosis leading to transplantation."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* code = http://hl7.org/fhir/sid/icd-10#K74.6 "Other and unspecified cirrhosis of liver"
* bodySite = $snomed#10200004 "Liver structure"
* subject = Reference(ExamplePatientTransplant1)
* onsetDateTime = "2020-03-01"
* note.text = "Extra details about the diagnosis (free text)."

Instance: ExamplePatientRenalDiagnosis1
InstanceOf: PatientPrimaryDiseaseDiagnosis
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
* performer = Reference(PCCenter1LaPaz)
* effectiveDateTime = "2023-08-15"

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
Description: "Partial (reduced-size) liver graft — a whole adult liver would be large-for-size for a 32.5 kg recipient."

* status = #final
* category = $obs-cat#procedure
* code = $loinc#74836-8 "Transplant type [Anatomy]"
* subject = Reference(ExampleDonor1)
* extension[tx_type].valueCodeableConcept = TransplantTypeCS#liver "Liver transplant"
* performer = Reference(PCCenter1LaPaz)
* effectiveDateTime = "2023-08-15"
* valueCodeableConcept = DonorLiverTypeCS#split "Split liver graft"