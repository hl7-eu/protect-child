// ================================================
// ImmunologicalData — immunological_data table
// Observation panel
// ================================================

Alias: $loinc   = http://loinc.org
Alias: $obs-cat = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $snomed  = http://snomed.info/sct

// ------------------------------------------------
// Terminology
// NOTE: ABO and Rh CodeSystems/ValueSets are defined canonically in
// patient-observations.fsh (PatientABOGroupCS / PatientRhFactorCS).
// Those are reused here via PatientABOGroupVS and PatientRhFactorVS.
// ------------------------------------------------

// Panel code — local code for the composite immunological data panel
// (a single LOINC code is not appropriate for this multi-domain panel)
CodeSystem: ImmunologicalDataPanelCS
Id: immunological-data-panel-cs
Title: "Immunological Data Panel CodeSystem"
Description: "Local code for the PROTECT-CHILD composite immunological data panel, which covers ABO/Rh typing, HLA allele typing, DSA, Banff category, C4d, and ANCA."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunological-data-panel"
* ^content = #complete
* ^caseSensitive = true
* ^experimental = true
* #immunological-data-panel "Immunological data panel"

// post_transplant_ab_anti_hla_dsa_class
CodeSystem: DSAClassCS
Id: dsa-class-cs
Title: "DSA HLA Class CodeSystem"
Description: "Post-transplant donor-specific antibody HLA class."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/dsa-class"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #class-i  "Class I"
* #class-ii "Class II"

ValueSet: DSAClassVS
Id: dsa-class-vs
Title: "DSA HLA Class ValueSet"
* DSAClassCS#class-i
* DSAClassCS#class-ii

// mfi (Mean Fluorescence Intensity category)
CodeSystem: MFICategoryCS
Id: mfi-category-cs
Title: "MFI Category CodeSystem"
Description: "Mean fluorescence intensity category for DSA."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/mfi-category"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #WR  "WR (500–2k)"
* #MR  "MR (2k–4k)"
* #SR  "SR (>4k)"

ValueSet: MFICategoryVS
Id: mfi-category-vs
Title: "MFI Category ValueSet"
* MFICategoryCS#WR
* MFICategoryCS#MR
* MFICategoryCS#SR

// banff_category
// Codes based on the Banff classification for allograft pathology (Solez et al.)
CodeSystem: BanffCategoryCS
Id: banff-category-cs
Title: "Banff Category CodeSystem"
Description: "Banff working classification of kidney/liver allograft pathology categories (Solez et al.). See https://www.banfffoundation.org/ for the full classification."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/banff-category"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #1 "Banff 1 – Normal"
* #2 "Banff 2 – Antibody-mediated changes"
* #3 "Banff 3 – Borderline changes"
* #4 "Banff 4 – T cell-mediated rejection"
* #5 "Banff 5 – Interstitial fibrosis and tubular atrophy"

ValueSet: BanffCategoryVS
Id: banff-category-vs
Title: "Banff Category ValueSet"
* BanffCategoryCS#1
* BanffCategoryCS#2
* BanffCategoryCS#3
* BanffCategoryCS#4
* BanffCategoryCS#5

// Component codes for all immunological data panel slices.
// HLA allele pairs share the same LOINC parent code (e.g. 13297-7 for HLA-A),
// so per-position local codes are required for reliable pattern-discriminator slicing.
// Each local code also carries the LOINC parent as a secondary coding in examples/instances.
CodeSystem: ImmDataComponentCS
Id: imm-data-component-cs
Title: "Immunological Data Component Codes"
Description: "Local component codes for immunological data panel slices. HLA allele positions use per-position codes (hla-a-1, hla-a-2, …) so that pattern-discriminator slicing can distinguish allele 1 from allele 2. Non-HLA codes cover DSA, Banff, C4d, ANCA, and related fields."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/imm-data-component"
* ^content = #complete
* ^caseSensitive = true
* ^experimental = true
// HLA allele position codes (LOINC parent noted in display for traceability)
* #hla-a-1       "HLA-A allele 1 (LOINC 13297-7)"
* #hla-a-2       "HLA-A allele 2 (LOINC 13297-7)"
* #hla-b-1       "HLA-B allele 1 (LOINC 13298-5)"
* #hla-b-2       "HLA-B allele 2 (LOINC 13298-5)"
* #hla-c-1       "HLA-C allele 1 (LOINC 13299-3)"
* #hla-c-2       "HLA-C allele 2 (LOINC 13299-3)"
* #hla-drb1-1    "HLA-DRB1 allele 1 (LOINC 13300-9)"
* #hla-drb1-2    "HLA-DRB1 allele 2 (LOINC 13300-9)"
* #hla-dp-1      "HLA-DP allele 1 (LOINC 13301-7)"
* #hla-dp-2      "HLA-DP allele 2 (LOINC 13301-7)"
* #hla-dqb1-1    "HLA-DQB1 allele 1 (LOINC 13302-5)"
* #hla-dqb1-2    "HLA-DQB1 allele 2 (LOINC 13302-5)"
// Non-HLA component codes
* #pre-tx-dsa          "Pre-transplant anti-HLA DSA"
* #mfi-category        "MFI category"
* #banff-category      "Banff rejection category"
* #ihc-if-c4d          "IHC/IF C4d result"
* #if-result           "Immunofluorescence result"
* #c4d-result          "C4d result detail"
* #anca                "ANCA result"
* #antibody-type       "Antibody type specification"
* #anti-hla-antibodies "Presence of anti-HLA antibodies"

// donor_id is carried via Observation.focus (Reference(Donor)).
// Observation.focus accepts any resource type, making a custom extension unnecessary.
// This aligns with the Microbiology profile which uses the same pattern.

// ================================================
// Profile: ImmunologicalData — Observation panel
// ================================================

Profile: ImmunologicalData
Parent: Observation
Id: immunological-data
Title: "Immunological Data"
Description: "Immunological data panel for a transplant patient at a given visit, aligned with the DMv1.2 immunological_data table. Covers ABO/Rh blood typing, HLA allele typing (IMGT/HLA notation), DSA, Banff category, C4d, ANCA, and related fields.

Conformance: Systems producing this resource SHALL populate identifier, status, category, code, subject, encounter, and at least one component. Systems consuming this resource SHALL be able to process all defined components."

// immunological_data_id → Observation.identifier (M)
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunological-data-id" (exactly)
* identifier.value 1..1
* identifier ^short = "immunological_data_id"

* status 1..1 MS
// status is not fixed to #final to support preliminary/amended states during data import
* status ^short = "Status of the observation (final, preliminary, amended, etc.)"

* category 1..1 MS
* category = $obs-cat#laboratory (exactly)

// Panel code — local code (not a single LOINC, as this is a multi-domain panel)
* code 1..1 MS
* code = ImmunologicalDataPanelCS#immunological-data-panel "Immunological data panel" (exactly)
* code ^short = "Immunological data panel code"

// subject: PatientTransplant (required — patient navigated via visit)
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient this data belongs to"

// visit_id → Observation.encounter (M)
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — Visit at which immunological data was collected"

// donor_id → Observation.focus (0..1, optional) — consistent with Microbiology profile
* focus 0..1 MS
* focus only Reference(Donor)
* focus ^short = "donor_id — optional reference to the Donor (for donor-side HLA/ABO typing)"

* effective[x] 0..1 MS

// ------------------------------------------------
// Component slices
// ------------------------------------------------

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component MS

// blood_group — reuses canonical ABO ValueSet from patient-observations.fsh
* component contains blood_group 0..1 MS
* component[blood_group].code = $loinc#883-9 "ABO group [Type] in Blood" (exactly)
* component[blood_group].value[x] only CodeableConcept
* component[blood_group].valueCodeableConcept from PatientABOGroupVS (required)
* component[blood_group] ^short = "blood_group — ABO blood group"

// rh_factor — reuses canonical Rh ValueSet from patient-observations.fsh
* component contains rh_factor 0..1 MS
* component[rh_factor].code = $loinc#10331-7 "Rh [Type] in Blood" (exactly)
* component[rh_factor].value[x] only CodeableConcept
* component[rh_factor].valueCodeableConcept from PatientRhFactorVS (required)
* component[rh_factor] ^short = "rh_factor — Rh blood group"

// HLA allele typing — string, IMGT/HLA notation (e.g. "A*02:01").
// Each allele position gets a unique local code from ImmDataComponentCS so that the
// pattern discriminator can distinguish allele 1 from allele 2 at the same locus.
// Implementers SHOULD also include the LOINC parent as a second coding in component.code
// for cross-system interoperability (see example instance below).

// HLA-A allele 1
* component contains hla_a_1 0..1 MS
* component[hla_a_1].code = ImmDataComponentCS#hla-a-1 "HLA-A allele 1 (LOINC 13297-7)" (exactly)
* component[hla_a_1].value[x] only string
* component[hla_a_1] ^short = "hla_a_1 — HLA-A allele 1 (IMGT/HLA notation, e.g. 'A*02:01')"

// HLA-A allele 2
* component contains hla_a_2 0..1 MS
* component[hla_a_2].code = ImmDataComponentCS#hla-a-2 "HLA-A allele 2 (LOINC 13297-7)" (exactly)
* component[hla_a_2].value[x] only string
* component[hla_a_2] ^short = "hla_a_2 — HLA-A allele 2 (IMGT/HLA notation)"

// HLA-B allele 1
* component contains hla_b_1 0..1 MS
* component[hla_b_1].code = ImmDataComponentCS#hla-b-1 "HLA-B allele 1 (LOINC 13298-5)" (exactly)
* component[hla_b_1].value[x] only string
* component[hla_b_1] ^short = "hla_b_1 — HLA-B allele 1 (IMGT/HLA notation)"

// HLA-B allele 2
* component contains hla_b_2 0..1 MS
* component[hla_b_2].code = ImmDataComponentCS#hla-b-2 "HLA-B allele 2 (LOINC 13298-5)" (exactly)
* component[hla_b_2].value[x] only string
* component[hla_b_2] ^short = "hla_b_2 — HLA-B allele 2 (IMGT/HLA notation)"

// HLA-C allele 1
* component contains hla_c_1 0..1 MS
* component[hla_c_1].code = ImmDataComponentCS#hla-c-1 "HLA-C allele 1 (LOINC 13299-3)" (exactly)
* component[hla_c_1].value[x] only string
* component[hla_c_1] ^short = "hla_c_1 — HLA-C allele 1 (IMGT/HLA notation)"

// HLA-C allele 2
* component contains hla_c_2 0..1 MS
* component[hla_c_2].code = ImmDataComponentCS#hla-c-2 "HLA-C allele 2 (LOINC 13299-3)" (exactly)
* component[hla_c_2].value[x] only string
* component[hla_c_2] ^short = "hla_c_2 — HLA-C allele 2 (IMGT/HLA notation)"

// HLA-DRB1 allele 1
* component contains hla_drb1_1 0..1 MS
* component[hla_drb1_1].code = ImmDataComponentCS#hla-drb1-1 "HLA-DRB1 allele 1 (LOINC 13300-9)" (exactly)
* component[hla_drb1_1].value[x] only string
* component[hla_drb1_1] ^short = "hla_drb1_1 — HLA-DRB1 allele 1 (IMGT/HLA notation)"

// HLA-DRB1 allele 2
* component contains hla_drb1_2 0..1 MS
* component[hla_drb1_2].code = ImmDataComponentCS#hla-drb1-2 "HLA-DRB1 allele 2 (LOINC 13300-9)" (exactly)
* component[hla_drb1_2].value[x] only string
* component[hla_drb1_2] ^short = "hla_drb1_2 — HLA-DRB1 allele 2 (IMGT/HLA notation)"

// HLA-DP allele 1
* component contains hla_dp_1 0..1 MS
* component[hla_dp_1].code = ImmDataComponentCS#hla-dp-1 "HLA-DP allele 1 (LOINC 13301-7)" (exactly)
* component[hla_dp_1].value[x] only string
* component[hla_dp_1] ^short = "hla_dp_1 — HLA-DP allele 1 (IMGT/HLA notation)"

// HLA-DP allele 2
* component contains hla_dp_2 0..1 MS
* component[hla_dp_2].code = ImmDataComponentCS#hla-dp-2 "HLA-DP allele 2 (LOINC 13301-7)" (exactly)
* component[hla_dp_2].value[x] only string
* component[hla_dp_2] ^short = "hla_dp_2 — HLA-DP allele 2 (IMGT/HLA notation)"

// HLA-DQB1 allele 1
* component contains hla_dqb1_1 0..1 MS
* component[hla_dqb1_1].code = ImmDataComponentCS#hla-dqb1-1 "HLA-DQB1 allele 1 (LOINC 13302-5)" (exactly)
* component[hla_dqb1_1].value[x] only string
* component[hla_dqb1_1] ^short = "hla_dqb1_1 — HLA-DQB1 allele 1 (IMGT/HLA notation)"

// HLA-DQB1 allele 2
* component contains hla_dqb1_2 0..1 MS
* component[hla_dqb1_2].code = ImmDataComponentCS#hla-dqb1-2 "HLA-DQB1 allele 2 (LOINC 13302-5)" (exactly)
* component[hla_dqb1_2].value[x] only string
* component[hla_dqb1_2] ^short = "hla_dqb1_2 — HLA-DQB1 allele 2 (IMGT/HLA notation)"

// post_transplant_ab_anti_hla_dsa_class
* component contains post_tx_dsa_class 0..1 MS
* component[post_tx_dsa_class].code = $loinc#95299-2 "HLA antibody [Identifier] in Serum or Plasma" (exactly)
* component[post_tx_dsa_class].value[x] only CodeableConcept
* component[post_tx_dsa_class].valueCodeableConcept from DSAClassVS (required)
* component[post_tx_dsa_class] ^short = "post_transplant_ab_anti_hla_dsa_class — DSA class (I / II)"

// pre_transplant_anti_hla_dsa (free text)
* component contains pre_tx_dsa 0..1 MS
* component[pre_tx_dsa].code = ImmDataComponentCS#pre-tx-dsa "Pre-transplant anti-HLA DSA" (exactly)
* component[pre_tx_dsa].value[x] only string
* component[pre_tx_dsa] ^short = "pre_transplant_anti_hla_dsa — free-text pre-transplant DSA description"

// mfi
* component contains mfi 0..1 MS
* component[mfi].code = ImmDataComponentCS#mfi-category "MFI category" (exactly)
* component[mfi].value[x] only CodeableConcept
* component[mfi].valueCodeableConcept from MFICategoryVS (required)
* component[mfi] ^short = "mfi — MFI category (WR / MR / SR)"

// banff_category
* component contains banff_category 0..1 MS
* component[banff_category].code = ImmDataComponentCS#banff-category "Banff rejection category" (exactly)
* component[banff_category].value[x] only CodeableConcept
* component[banff_category].valueCodeableConcept from BanffCategoryVS (required)
* component[banff_category] ^short = "banff_category — Banff rejection grade"

// ihc_if_c4d (Boolean — Negative / Positive)
* component contains ihc_if_c4d 0..1 MS
* component[ihc_if_c4d].code = ImmDataComponentCS#ihc-if-c4d "IHC/IF C4d result" (exactly)
* component[ihc_if_c4d].value[x] only boolean
* component[ihc_if_c4d] ^short = "ihc_if_c4d — C4d result (true = Positive)"

// if (free text)
* component contains imm_if 0..1 MS
* component[imm_if].code = ImmDataComponentCS#if-result "Immunofluorescence result" (exactly)
* component[imm_if].value[x] only string
* component[imm_if] ^short = "if — immunofluorescence result (free text)"

// c4d (free text)
* component contains c4d 0..1 MS
* component[c4d].code = ImmDataComponentCS#c4d-result "C4d result detail" (exactly)
* component[c4d].value[x] only string
* component[c4d] ^short = "c4d — C4d result detail (free text)"

// anca (Boolean)
* component contains anca 0..1 MS
* component[anca].code = ImmDataComponentCS#anca "ANCA result" (exactly)
* component[anca].value[x] only boolean
* component[anca] ^short = "anca — ANCA result (true = Positive)"

// antibody_type (free text)
* component contains antibody_type 0..1 MS
* component[antibody_type].code = ImmDataComponentCS#antibody-type "Antibody type specification" (exactly)
* component[antibody_type].value[x] only string
* component[antibody_type] ^short = "antibody_type — antibody type specification (free text)"

// anti_hla_antibodies (Boolean, Optional)
* component contains anti_hla_antibodies 0..1 MS
* component[anti_hla_antibodies].code = ImmDataComponentCS#anti-hla-antibodies "Presence of anti-HLA antibodies" (exactly)
* component[anti_hla_antibodies].value[x] only boolean
* component[anti_hla_antibodies] ^short = "anti_hla_antibodies — presence of anti-HLA antibodies"


// ================================================
// Example
// ================================================

Instance: ImmunologicalDataExample1
InstanceOf: ImmunologicalData
Usage: #example
Title: "Example Immunological Data"
Description: "Example immunological data panel for a liver transplant recipient at 1-month visit."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunological-data-id"
* identifier.value = "IMMDATA-001"
* status = #final
* category = $obs-cat#laboratory
* code = ImmunologicalDataPanelCS#immunological-data-panel "Immunological data panel"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitExample1)

// blood_group — using canonical PatientABOGroupCS from patient-observations.fsh
* component[blood_group].code = $loinc#883-9 "ABO group [Type] in Blood"
* component[blood_group].valueCodeableConcept = PatientABOGroupCS#A "Group A"

// rh_factor — using canonical PatientRhFactorCS from patient-observations.fsh
* component[rh_factor].code = $loinc#10331-7 "Rh [Type] in Blood"
* component[rh_factor].valueCodeableConcept = PatientRhFactorCS#positive "Rh positive"

// HLA-A — local discriminating code + LOINC parent as second coding
* component[hla_a_1].code.coding[0] = ImmDataComponentCS#hla-a-1 "HLA-A allele 1 (LOINC 13297-7)"
* component[hla_a_1].code.coding[1] = $loinc#13297-7 "HLA-A [Type]"
* component[hla_a_1].valueString = "A*02:01"
* component[hla_a_2].code.coding[0] = ImmDataComponentCS#hla-a-2 "HLA-A allele 2 (LOINC 13297-7)"
* component[hla_a_2].code.coding[1] = $loinc#13297-7 "HLA-A [Type]"
* component[hla_a_2].valueString = "A*24:02"

// post-tx DSA class
* component[post_tx_dsa_class].code = $loinc#95299-2 "HLA antibody [Identifier] in Serum or Plasma"
* component[post_tx_dsa_class].valueCodeableConcept = DSAClassCS#class-i "Class I"

// Banff category
* component[banff_category].code = ImmDataComponentCS#banff-category "Banff rejection category"
* component[banff_category].valueCodeableConcept = BanffCategoryCS#2 "Banff 2 – Antibody-mediated changes"
