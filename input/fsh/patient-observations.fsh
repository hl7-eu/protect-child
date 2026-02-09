// patient-observations.fsh
// Observation and List artifacts used to capture recipient and donor facts as Observations,
// instead of using Patient extensions.
//
// Design:
// - Each fact is an Observation linked via Observation.subject to PatientTransplant (recipient) or Donor.
// - A List (PatientObservations) can be used to group the patient-level Observations for a case/visit.
//
Alias: $loinc = http://loinc.org
Alias: $ucum = http://unitsofmeasure.org
Alias: $obs-cat = http://terminology.hl7.org/CodeSystem/observation-category

// ------------------------------------------------------
// Terminology – ABO, Rh
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
Description: "Allowed Rh factor values for transplant recipients and donors."
* PatientRhFactorCS#positive
* PatientRhFactorCS#negative

// ------------------------------------------------------
// Terminology – PRA observation type (max vs last)
// ------------------------------------------------------

CodeSystem: PatientPRATypeCS
Id: patient-pra-type-cs
Title: "PRA Observation Type CodeSystem"
Description: "Distinguishes maximum (historical) vs most recent PRA measurements."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/patient-pra-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #max  "Maximum (historical)"
* #last "Most recent"

ValueSet: PatientPRATypeVS
Id: patient-pra-type-vs
Title: "PRA Observation Type ValueSet"
Description: "Allowed values for Observation.method when reporting maximum vs most recent PRA."
* PatientPRATypeCS#max
* PatientPRATypeCS#last

// ------------------------------------------------------
// Terminology – Donor liver type (Complete / Partial)
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
Description: "Allowed values for donor liver type (Complete, Partial)."
* DonorLiverTypeCS#complete
* DonorLiverTypeCS#partial

// ------------------------------------------------------
// ValueSet – Dialysis method (using LOINC LA answer codes)
// ------------------------------------------------------

ValueSet: DialysisTypeVS
Id: dialysis-type-vs
Title: "Dialysis method ValueSet"
Description: "Dialysis method values expressed using LOINC Answer codes (aligned with LOINC answer list LL2102-3 for 70958-4)."
* $loinc#LA9975-9 "Hemodialysis"
* $loinc#LA10059-6 "Peritoneal Dialysis"

// ------------------------------------------------------

// ------------------------------------------------------
// Observation Profiles – recipient & donor facts
// ------------------------------------------------------

// ABO blood group
Profile: PatientABOGroupObservation
Parent: Observation
Id: patient-abo-group-observation
Title: "ABO group observation"
Description: "ABO blood group as an Observation (LOINC 883-9). Reusable for both recipients and donors."

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#laboratory (exactly)

* code 1..1 MS
* code = $loinc#883-9 "ABO group [Type] in Blood" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant or Donor)

* effective[x] 0..1 MS

* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from PatientABOGroupVS (required)


// Rh blood group
Profile: PatientRhFactorObservation
Parent: Observation
Id: patient-rh-factor-observation
Title: "Rh factor observation"
Description: "Rh type as an Observation (LOINC 10331-7). Reusable for both recipients and donors."

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#laboratory (exactly)

* code 1..1 MS
* code = $loinc#10331-7 "Rh [Type] in Blood" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant or Donor)

* effective[x] 0..1 MS

* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from PatientRhFactorVS (required)


// PRA (max / last distinguished using Observation.method)
Profile: PatientPRAObservation
Parent: Observation
Id: patient-pra-observation
Title: "PRA observation"
Description: "Panel reactive antibody / cPRA as an Observation (LOINC 80737-0). Use Observation.method to mark max vs last."

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#laboratory (exactly)

* code 1..1 MS
* code = $loinc#80737-0 "Calculated panel reactive antibody - Serum" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant or Donor)

* method 1..1 MS
* method from PatientPRATypeVS (required)

* effective[x] 0..1 MS

* value[x] 1..1 MS
* value[x] only integer
* valueInteger ^minValueInteger = 0
* valueInteger ^maxValueInteger = 100


// HLA typing – Class I (A, B, C)
Profile: PatientHLATypingClassIObservation
Parent: Observation
Id: patient-hla-typing-class-i-observation
Title: "HLA Class I typing observation"
Description: "HLA Class I (A, B, C) typing as an Observation panel (LOINC 96629-1)."

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#laboratory (exactly)

* code 1..1 MS
* code = $loinc#96629-1 "HLA-A and B and C (class I) typing panel - Blood or Tissue by Low resolution" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant or Donor)

* effective[x] 0..1 MS

* component 0..* MS
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open

* component contains
    hlaA 0..1 MS and
    hlaB 0..1 MS and
    hlaC 0..1 MS

* component[hlaA].code = $loinc#78014-8 "HLA-A [Type] by Low resolution" (exactly)
* component[hlaA].value[x] 1..1
* component[hlaA].value[x] only string

* component[hlaB].code = $loinc#78015-5 "HLA-B [Type] by Low resolution" (exactly)
* component[hlaB].value[x] 1..1
* component[hlaB].value[x] only string

* component[hlaC].code = $loinc#96636-6 "HLA-C [Type] by Low resolution" (exactly)
* component[hlaC].value[x] 1..1
* component[hlaC].value[x] only string


// HLA typing – Class II (DP, DQ, DR)
Profile: PatientHLATypingClassIIObservation
Parent: Observation
Id: patient-hla-typing-class-ii-observation
Title: "HLA Class II typing observation"
Description: "HLA Class II (DP, DQ, DR) typing as an Observation panel (LOINC 96640-8)."

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#laboratory (exactly)

* code 1..1 MS
* code = $loinc#96640-8 "HLA-DP and DQ and DR (class II) typing panel - Blood or Tissue by Low resolution" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant or Donor)

* effective[x] 0..1 MS

* component 0..* MS
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open

* component contains
    hlaDPA1 0..1 MS and
    hlaDPB1 0..1 MS and
    hlaDQA1 0..1 MS and
    hlaDQB1 0..1 MS and
    hlaDRB1 0..1 MS and
    hlaDRB345 0..1 MS

* component[hlaDPA1].code = $loinc#96643-2 "HLA-DPA1 [Type] by Low resolution" (exactly)
* component[hlaDPA1].value[x] 1..1
* component[hlaDPA1].value[x] only string

* component[hlaDPB1].code = $loinc#96648-1 "HLA-DPB1 [Type] by Low resolution" (exactly)
* component[hlaDPB1].value[x] 1..1
* component[hlaDPB1].value[x] only string

* component[hlaDQA1].code = $loinc#96654-9 "HLA-DQA1 [Type] by Low resolution" (exactly)
* component[hlaDQA1].value[x] 1..1
* component[hlaDQA1].value[x] only string

* component[hlaDQB1].code = $loinc#78017-1 "HLA-DQB1 [Type] by Low resolution" (exactly)
* component[hlaDQB1].value[x] 1..1
* component[hlaDQB1].value[x] only string

* component[hlaDRB1].code = $loinc#96664-8 "HLA-DRB1 [Type] by Low resolution" (exactly)
* component[hlaDRB1].value[x] 1..1
* component[hlaDRB1].value[x] only string

* component[hlaDRB345].code = $loinc#96672-1 "HLA-DRB3 and HLA-DRB4 and HLA DRB5 [Type] by Low resolution" (exactly)
* component[hlaDRB345].value[x] 1..1
* component[hlaDRB345].value[x] only string


// Histological diagnosis date
Profile: PatientHistologicalDiagnosisDateObservation
Parent: Observation
Id: patient-histological-diagnosis-date-observation
Title: "Histological diagnosis date observation"
Description: "Date of histological diagnosis captured as an Observation date result (LOINC 77975-1)."

* status 1..1 MS
* status = #final (exactly)

* code 1..1 MS
* code = $loinc#77975-1 "Earliest date of diagnosis" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant)

* effective[x] 0..1 MS

* value[x] 1..1 MS
* value[x] only dateTime


// Liver disease diagnosis (includes diagnosis date via Observation.effectiveDateTime)
Profile: PatientLiverDiseaseDiagnosisObservation
Parent: Observation
Id: patient-liver-disease-diagnosis-observation
Title: "Liver disease diagnosis observation"
Description: "Primary liver disease diagnosis. Use effectiveDateTime as the diagnosis date and valueCodeableConcept as the diagnosis."

* status 1..1 MS
* status = #final (exactly)

* code 1..1 MS
* code = $loinc#29308-4 "Diagnosis" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant)

* bodySite 1..1 MS
* bodySite = $loinc#LA4584-4 "Liver" (exactly)

* effective[x] 1..1 MS
* effective[x] only dateTime

* value[x] 1..1 MS
* value[x] only CodeableConcept

* note 0..1 MS
* note ^short = "Optional free text (diag_liver_disease_extra)"


// Renal disease diagnosis (includes diagnosis date via Observation.effectiveDateTime)
Profile: PatientRenalDiseaseDiagnosisObservation
Parent: Observation
Id: patient-renal-disease-diagnosis-observation
Title: "Renal disease diagnosis observation"
Description: "Primary renal disease diagnosis. Use effectiveDateTime as the diagnosis date and valueCodeableConcept as the diagnosis."

* status 1..1 MS
* status = #final (exactly)

* code 1..1 MS
* code = $loinc#29308-4 "Diagnosis" (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant)

* bodySite 1..1 MS
* bodySite = $loinc#LA4591-9 "Kidney" (exactly)

* effective[x] 1..1 MS
* effective[x] only dateTime

* value[x] 1..1 MS
* value[x] only CodeableConcept

* note 0..1 MS
* note ^short = "Optional free text (diag_renal_disease_extra)"


// Donor pre-KTX dialysis type (donor-specific)
Profile: DonorPreKtxDialysisTypeObservation
Parent: Observation
Id: donor-pre-ktx-dialysis-type-observation
Title: "Donor pre-KTX dialysis type observation"
Description: "Dialysis method prior to kidney transplantation (LOINC 70958-4)."

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


// Donor liver type (donor-specific)
Profile: DonorLiverTypeObservation
Parent: Observation
Id: donor-liver-type-observation
Title: "Donor liver graft type observation"
Description: "Type of liver graft (complete vs partial) captured as an Observation (LOINC 74836-8)."

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


// ------------------------------------------------------
// Profile: PatientObservations (List)
// ------------------------------------------------------

Profile: PatientObservations
Parent: List
Id: patient-observations
Title: "Patient observations"
Description: "A curated list of patient-level observations (ABO, Rh, PRA, HLA typing, diagnoses, etc.) that reference a transplant recipient."

* status 1..1 MS
* status = #current (exactly)

* mode 1..1 MS
* mode = #working (exactly)

* subject 1..1 MS
* subject only Reference(PatientTransplant or Donor)
* subject ^short = "The transplant recipient this list applies to"

* date 0..1 MS
* date ^short = "Date the list was assembled/updated"

* entry 1..* MS
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "item"
* entry ^slicing.rules = #open

* entry contains
    abo 0..1 MS and
    rh 0..1 MS and
    pra 0..* MS and
    hlaClassI 0..1 MS and
    hlaClassII 0..1 MS and
    histDxDate 0..1 MS and
    liverDx 0..1 MS and
    renalDx 0..1 MS

* entry[abo].item 1..1
* entry[abo].item only Reference(PatientABOGroupObservation)

* entry[rh].item 1..1
* entry[rh].item only Reference(PatientRhFactorObservation)

* entry[pra].item 1..1
* entry[pra].item only Reference(PatientPRAObservation)

* entry[hlaClassI].item 1..1
* entry[hlaClassI].item only Reference(PatientHLATypingClassIObservation)

* entry[hlaClassII].item 1..1
* entry[hlaClassII].item only Reference(PatientHLATypingClassIIObservation)

* entry[histDxDate].item 1..1
* entry[histDxDate].item only Reference(PatientHistologicalDiagnosisDateObservation)

* entry[liverDx].item 1..1
* entry[liverDx].item only Reference(PatientLiverDiseaseDiagnosisObservation)

* entry[renalDx].item 1..1
* entry[renalDx].item only Reference(PatientRenalDiseaseDiagnosisObservation)


// ------------------------------------------------------
// Example Instances (recipient-level)
// ------------------------------------------------------

Instance: ExamplePatientABO1
InstanceOf: PatientABOGroupObservation
Usage: #example
Title: "Example patient ABO observation"
Description: "ABO group for the transplant recipient."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#883-9 "ABO group [Type] in Blood"
* subject = Reference(ExamplePatientTransplant1)
* effectiveDateTime = "2025-01-10"
* valueCodeableConcept = PatientABOGroupCS#A "Group A"

Instance: ExamplePatientRh1
InstanceOf: PatientRhFactorObservation
Usage: #example
Title: "Example patient Rh observation"
Description: "Rh type for the transplant recipient."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#10331-7 "Rh [Type] in Blood"
* subject = Reference(ExamplePatientTransplant1)
* effectiveDateTime = "2025-01-10"
* valueCodeableConcept = PatientRhFactorCS#positive "Rh positive"

Instance: ExamplePatientPRAMax
InstanceOf: PatientPRAObservation
Usage: #example
Title: "Example patient max PRA observation"
Description: "Maximum PRA (%)."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#80737-0 "Calculated panel reactive antibody - Serum"
* subject = Reference(ExamplePatientTransplant1)
* method = PatientPRATypeCS#max "Maximum (historical)"
* effectiveDateTime = "2024-12-20"
* valueInteger = 80


Instance: ExamplePatientPRALast
InstanceOf: PatientPRAObservation
Usage: #example
Title: "Example patient last PRA observation"
Description: "Most recent PRA (%)."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#80737-0 "Calculated panel reactive antibody - Serum"
* subject = Reference(ExamplePatientTransplant1)
* method = PatientPRATypeCS#last "Most recent"
* effectiveDateTime = "2025-01-05"
* valueInteger = 55


Instance: ExamplePatientHLAClassI1
InstanceOf: PatientHLATypingClassIObservation
Usage: #example
Title: "Example patient HLA class I typing"
Description: "Example HLA class I typing result (A, B, C)."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#96629-1 "HLA-A and B and C (class I) typing panel - Blood or Tissue by Low resolution"
* subject = Reference(ExamplePatientTransplant1)
* effectiveDateTime = "2025-01-05"
* component[hlaA].code = $loinc#78014-8 "HLA-A [Type] by Low resolution"
* component[hlaA].valueString = "A*02"
* component[hlaB].code = $loinc#78015-5 "HLA-B [Type] by Low resolution"
* component[hlaB].valueString = "B*07"
* component[hlaC].code = $loinc#96636-6 "HLA-C [Type] by Low resolution"
* component[hlaC].valueString = "C*07"

Instance: ExamplePatientHLAClassII1
InstanceOf: PatientHLATypingClassIIObservation
Usage: #example
Title: "Example patient HLA class II typing"
Description: "Example HLA class II typing result (DP, DQ, DR)."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#96640-8 "HLA-DP and DQ and DR (class II) typing panel - Blood or Tissue by Low resolution"
* subject = Reference(ExamplePatientTransplant1)
* effectiveDateTime = "2025-01-05"
* component[hlaDPA1].code = $loinc#96643-2 "HLA-DPA1 [Type] by Low resolution"
* component[hlaDPA1].valueString = "DPA1*01"
* component[hlaDPB1].code = $loinc#96648-1 "HLA-DPB1 [Type] by Low resolution"
* component[hlaDPB1].valueString = "DPB1*04"
* component[hlaDQA1].code = $loinc#96654-9 "HLA-DQA1 [Type] by Low resolution"
* component[hlaDQA1].valueString = "DQA1*05"
* component[hlaDQB1].code = $loinc#78017-1 "HLA-DQB1 [Type] by Low resolution"
* component[hlaDQB1].valueString = "DQB1*02"
* component[hlaDRB1].code = $loinc#96664-8 "HLA-DRB1 [Type] by Low resolution"
* component[hlaDRB1].valueString = "DRB1*15"

Instance: ExampleHistDxDate1
InstanceOf: PatientHistologicalDiagnosisDateObservation
Usage: #example
Title: "Example histological diagnosis date"
Description: "Example date of histological diagnosis."

* status = #final
* code = $loinc#77975-1 "Earliest date of diagnosis"
* subject = Reference(ExamplePatientTransplant1)
* valueDateTime = "2024-05-10"

Instance: ExampleLiverDx1
InstanceOf: PatientLiverDiseaseDiagnosisObservation
Usage: #example
Title: "Example liver disease diagnosis"
Description: "Example liver diagnosis and diagnosis date."

* status = #final
* code = $loinc#29308-4 "Diagnosis"
* subject = Reference(ExamplePatientTransplant1)
* bodySite = $loinc#LA4584-4 "Liver"
* effectiveDateTime = "2020-03-01"
* valueCodeableConcept = http://hl7.org/fhir/sid/icd-10#K74.60 "Unspecified cirrhosis of liver"
* note.text = "Extra details about the diagnosis (free text)."

Instance: ExampleRenalDx1
InstanceOf: PatientRenalDiseaseDiagnosisObservation
Usage: #example
Title: "Example renal disease diagnosis"
Description: "Example renal diagnosis and diagnosis date."

* status = #final
* code = $loinc#29308-4 "Diagnosis"
* subject = Reference(ExamplePatientTransplant1)
* bodySite = $loinc#LA4591-9 "Kidney"
* effectiveDateTime = "2021-09-15"
* valueCodeableConcept = http://hl7.org/fhir/sid/icd-10#N18.5 "Chronic kidney disease, stage 5"
* note.text = "Extra renal diagnosis details (free text)."


// ------------------------------------------------------
// Example Instances (donor-level)

Instance: ExampleDonorABOGroupObservation1
InstanceOf: PatientABOGroupObservation
Usage: #example
Title: "Example donor ABO observation"
Description: "ABO group for the transplant donor."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#883-9 "ABO group [Type] in Blood"
* subject = Reference(ExampleDonor1)
* effectiveDateTime = "2025-01-01"
* valueCodeableConcept = PatientABOGroupCS#O "Group O"

Instance: ExampleDonorRhFactorObservation1
InstanceOf: PatientRhFactorObservation
Usage: #example
Title: "Example donor Rh observation"
Description: "Rh type for the transplant donor."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#10331-7 "Rh [Type] in Blood"
* subject = Reference(ExampleDonor1)
* effectiveDateTime = "2025-01-01"
* valueCodeableConcept = PatientRhFactorCS#positive "Rh positive"

Instance: ExampleDonorPRAObservation1
InstanceOf: PatientPRAObservation
Usage: #example
Title: "Example donor PRA observation"
Description: "Example PRA (%) recorded for the donor (if available)."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#80737-0 "Calculated panel reactive antibody - Serum"
* subject = Reference(ExampleDonor1)
* method = PatientPRATypeCS#last "Most recent"
* effectiveDateTime = "2025-01-01"
* valueInteger = 10


Instance: ExampleDonorHLATypingClassIObservation1
InstanceOf: PatientHLATypingClassIObservation
Usage: #example
Title: "Example donor HLA class I typing"
Description: "Example HLA class I typing result (A, B, C) for the donor."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#96629-1 "HLA-A and B and C (class I) typing panel - Blood or Tissue by Low resolution"
* subject = Reference(ExampleDonor1)
* effectiveDateTime = "2025-01-01"
* component[hlaA].valueString = "A*01"
* component[hlaB].valueString = "B*08"
* component[hlaC].valueString = "C*07"

Instance: ExampleDonorHLATypingClassIIObservation1
InstanceOf: PatientHLATypingClassIIObservation
Usage: #example
Title: "Example donor HLA class II typing"
Description: "Example HLA class II typing result (DP, DQ, DR) for the donor."

* status = #final
* category = $obs-cat#laboratory
* code = $loinc#96640-8 "HLA-DP and DQ and DR (class II) typing panel - Blood or Tissue by Low resolution"
* subject = Reference(ExampleDonor1)
* effectiveDateTime = "2025-01-01"
* component[hlaDPA1].valueString = "DPA1*01"
* component[hlaDPB1].valueString = "DPB1*04"
* component[hlaDQA1].valueString = "DQA1*05"
* component[hlaDQB1].valueString = "DQB1*02"
* component[hlaDRB1].valueString = "DRB1*15"

// ------------------------------------------------------

Instance: ExampleDonorLiverType1
InstanceOf: DonorLiverTypeObservation
Usage: #example
Title: "Example donor liver graft type"
Description: "Example donor liver graft type."

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
Description: "Example donor dialysis method prior to kidney transplant."

* status = #final
* category = $obs-cat#procedure
* code = $loinc#70958-4 "Dialysis method [ESRD]"
* subject = Reference(ExampleDonor1)
* effectiveDateTime = "2024-11-15"
* valueCodeableConcept = $loinc#LA9975-9 "Hemodialysis"


// ------------------------------------------------------
// Example: PatientObservations List
// ------------------------------------------------------

Instance: ExamplePatientObservationsList1
InstanceOf: PatientObservations
Usage: #example
Title: "Example patient observations list"
Description: "An example List that links the transplant recipient to their patient-level Observations."

* status = #current
* mode = #working
* subject = Reference(ExamplePatientTransplant1)
* date = "2025-01-10"

* entry[abo].item = Reference(ExamplePatientABO1)
* entry[rh].item  = Reference(ExamplePatientRh1)
* entry[pra][0].item = Reference(ExamplePatientPRAMax)
* entry[pra][1].item = Reference(ExamplePatientPRALast)
* entry[hlaClassI].item = Reference(ExamplePatientHLAClassI1)
* entry[hlaClassII].item = Reference(ExamplePatientHLAClassII1)
* entry[histDxDate].item = Reference(ExampleHistDxDate1)
* entry[liverDx].item = Reference(ExampleLiverDx1)
* entry[renalDx].item = Reference(ExampleRenalDx1)


// ------------------------------------------------------
// Donor observations list (List)
// ------------------------------------------------------

Instance: ExampleDonorObservationsList1
InstanceOf: PatientObservations
Usage: #example
Title: "Example donor observations list"
Description: "An example List that links the donor to donor-level Observations."

* status = #current
* mode = #working
* subject = Reference(ExampleDonor1)
* date = "2024-02-02T12:00:00+01:00"

* entry[abo].item = Reference(ExampleDonorABOGroupObservation1)
* entry[rh].item = Reference(ExampleDonorRhFactorObservation1)
* entry[pra][0].item = Reference(ExampleDonorPRAObservation1)
* entry[hlaClassI].item = Reference(ExampleDonorHLATypingClassIObservation1)
* entry[hlaClassII].item = Reference(ExampleDonorHLATypingClassIIObservation1)
