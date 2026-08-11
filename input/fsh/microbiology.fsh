// ================================================
// Microbiology — microbiology table
// Observation with components
// ================================================

// ================================================
// Reusable extension — transplant type context
// Added to Microbiology, ClinicalEventFlagObservation, and DonorLiverTypeObservation
// to carry the patient's transplant type so organ-specific invariants can be
// evaluated within each resource without cross-resource resolve().
// ================================================

Extension: TransplantTypeExt
Id: transplant-type-ext
Title: "Transplant type context"
Description: "Records the transplant type (liver / kidney / combined) on resources that carry organ-specific data fields, enabling organ-specific FHIRPath invariants within a single resource."
* ^context[0].type = #element
* ^context[0].expression = "Observation"
* ^context[1].type = #element
* ^context[1].expression = "Condition"
* value[x] only CodeableConcept
* valueCodeableConcept from TransplantTypeVS (required)
* valueCodeableConcept ^short = "Transplant type: liver, kidney, or combined"

// ================================================
// Organ-specific invariants for Microbiology
//
// Kidney-only components: bkv-dna-kidney-biopsy, bkv-fish-kidney-biopsy,
//                         blood-colture, urine-colture, other-positivity
// Liver-only components:  ebv-hepatitis-liver
// ================================================

Invariant: pc-micro-1
Description: "BKV kidney biopsy components are only applicable for kidney or combined transplants."
Severity: #error
Expression: "(component.where(code.coding.code = 'bkv-dna-kidney-biopsy' and value.ofType(boolean) = true).exists() or component.where(code.coding.code = 'bkv-fish-kidney-biopsy' and value.ofType(boolean) = true).exists()) implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'kidney' or code = 'combined').exists()"

Invariant: pc-micro-2
Description: "Blood culture and urine culture are only applicable for kidney or combined transplants."
Severity: #error
Expression: "(component.where(code.coding.code = 'blood-colture' and value.ofType(boolean) = true).exists() or component.where(code.coding.code = 'urine-colture' and value.ofType(boolean) = true).exists()) implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'kidney' or code = 'combined').exists()"

Invariant: pc-micro-3
Description: "EBV hepatitis on liver is only applicable for liver or combined transplants."
Severity: #error
Expression: "component.where(code.coding.code = 'ebv-hepatitis-liver' and value.ofType(boolean) = true).exists() implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'liver' or code = 'combined').exists()"

Invariant: pc-micro-4
Description: "Evidence of BKVAN is only applicable for kidney or combined transplants."
Severity: #error
Expression: "component.where(code.coding.code = 'evidence-bkvan').exists() implies extension.where(url = 'https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/StructureDefinition/transplant-type-ext').value.ofType(CodeableConcept).coding.where(code = 'kidney' or code = 'combined').exists()"


// ================================================
// Terminology — component codes
// ================================================

CodeSystem: MicrobiologyCS
Id: microbiology-cs
Title: "Microbiology component codes"
Description: "Local codes for microbiology panel Observation components."
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true

* #microbiology-panel       "Microbiology studies panel" "Panel grouping microbiology and virology results for a visit."
* #ebv-dna                  "EBV-DNA (quantitative)" "Epstein-Barr virus DNA detected/quantified by PCR."
* #ebv-igm-anti-ea          "EBV IgM anti-EA" "EBV IgM antibody to early antigen (EA)."
* #ebv-igm-anti-vca         "EBV IgM anti-VCA" "EBV IgM antibody to viral capsid antigen (VCA)."
* #ebv-igg-anti-vca         "EBV IgG anti-VCA" "EBV IgG antibody to viral capsid antigen (VCA)."
* #ebv-igg-ebna             "EBV IgG EBNA" "EBV IgG antibody to Epstein-Barr nuclear antigen (EBNA)."
* #cmv-dna                  "CMV-DNA" "Cytomegalovirus DNA detected/quantified by PCR."
* #cmv-igm                  "CMV IgM" "Cytomegalovirus IgM antibody."
* #cmv-igg                  "CMV IgG" "Cytomegalovirus IgG antibody."
* #parvovirus-b19-dna       "Parvovirus B19 DNA" "Parvovirus B19 DNA detected by PCR."
* #parvovirus-b19-igg       "Parvovirus B19 IgG" "Parvovirus B19 IgG antibody."
* #parvovirus-b19-igm       "Parvovirus B19 IgM" "Parvovirus B19 IgM antibody."
* #hsv-igg                  "HSV IgG" "Herpes simplex virus IgG antibody."
* #hsv-igm                  "HSV IgM" "Herpes simplex virus IgM antibody."
* #adenovirus-igg           "Adenovirus IgG" "Adenovirus IgG antibody."
* #adenovirus-igm           "Adenovirus IgM" "Adenovirus IgM antibody."
* #vzv-igg                  "VZV IgG" "Varicella-zoster virus IgG antibody."
* #vzv-igm                  "VZV IgM" "Varicella-zoster virus IgM antibody."
* #blood-bkv-dna            "Blood BKV-DNA" "BK polyomavirus DNA in blood by PCR."
* #urine-bkv-dna            "Urine BKV-DNA" "BK polyomavirus DNA in urine by PCR."
* #bkv-dna-kidney-biopsy    "BKV-DNA on kidney biopsy" "BK polyomavirus DNA detected in kidney biopsy tissue."
* #bkv-fish-kidney-biopsy   "BKV FISH on kidney biopsy" "BK polyomavirus detected by FISH in kidney biopsy tissue."
* #ebv-dna-copies             "EBV-DNA copies/ml" "Quantitative EBV DNA viral load (copies/mL)."
* #cmv-dna-copies             "CMV-DNA copies/ml" "Quantitative CMV DNA viral load (copies/mL)."
* #parvovirus-b19-dna-copies  "Parvovirus B19 DNA copies/ml" "Quantitative parvovirus B19 DNA viral load (copies/mL)."
* #blood-adenovirus-dna       "Blood Adenovirus DNA" "Adenovirus DNA in blood by PCR."
* #blood-adenovirus-dna-copies "Blood Adenovirus DNA copies/ml" "Quantitative blood adenovirus DNA viral load (copies/mL)."
* #blood-bkv-dna-copies       "Blood BKV-DNA copies/ml" "Quantitative blood BK virus DNA viral load (copies/mL)."
* #blood-colture               "Blood culture" "Blood culture for microbial growth."
* #urine-colture               "Urine culture" "Urine culture for microbial growth."
* #other-positivity            "Other positivity" "Other microbiological positivity not otherwise specified."
* #ebv-hepatitis-liver         "EBV Hepatitis on liver" "EBV-associated hepatitis involving the liver allograft."
* #evidence-bkvan              "Histological evidence of BKVAN" "Histological evidence of BK virus-associated nephropathy (BKVAN)."


// ================================================
// Microbiology profile — Observation (component-based)
// ================================================

Profile: Microbiology
Parent: Observation
Id: microbiology
Title: "Microbiology"
Description: "Microbiology panel for transplant recipients and/or donors. Component slices cover virology (EBV, CMV, Parvovirus B19, HSV, Adenovirus, VZV, BKV) plus organ-specific findings. The transplant type (extension[tx-type]) is required when organ-specific components are populated; invariants pc-micro-1 through pc-micro-4 enforce applicability."

// Apply organ-specific invariants
* obeys pc-micro-1
* obeys pc-micro-2
* obeys pc-micro-3
* obeys pc-micro-4

// tx_type context — required when organ-specific components are populated
* extension contains TransplantTypeExt named tx_type 0..1 MS
* extension[tx_type] ^short = "Transplant type context (liver / kidney / combined) — required when organ-specific components are present"

// microbiology_id → Observation.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/microbiology-id" (exactly)
* identifier.value 1..1
* identifier ^short = "microbiology_id"

// Panel code
* code 1..1 MS
* code = MicrobiologyCS#microbiology-panel "Microbiology studies panel"

* status 1..1 MS
* status = #final (exactly)

// patient_id → Observation.subject
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id — transplant recipient"

// donor_id → Observation.focus (pre-transplant donor serology)
* focus 0..1 MS
* focus only Reference(Donor)
* focus ^short = "donor_id — donor associated with this microbiology record (pre-transplant serology)"

// visit_id → Observation.encounter
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — visit at which these results were recorded"

// No top-level value; all results in components
* value[x] 0..0


// ── Component slicing ──────────────────────────────────────

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open

* component contains
    ebvDna                 0..1 MS and
    ebvDnaCopies           0..1 MS and
    ebvIgmAntiEa           0..1 MS and
    ebvIgmAntiVca          0..1 MS and
    ebvIggAntiVca          0..1 MS and
    ebvIggEbna             0..1 MS and
    cmvDna                 0..1 MS and
    cmvDnaCopies           0..1 MS and
    cmvIgm                 0..1 MS and
    cmvIgg                 0..1 MS and
    parvoB19Dna            0..1 MS and
    parvoB19DnaCopies      0..1 MS and
    parvoB19Igg            0..1 MS and
    parvoB19Igm            0..1 MS and
    hsvIgg                 0..1 MS and
    hsvIgm                 0..1 MS and
    adenovirusIgg          0..1 MS and
    adenovirusIgm          0..1 MS and
    bloodAdenovirusDna     0..1 MS and
    bloodAdenovirusDnaCopies 0..1 MS and
    vzvIgg                 0..1 MS and
    vzvIgm                 0..1 MS and
    bloodBkvDna            0..1 MS and
    bloodBkvDnaCopies      0..1 MS and
    urineBkvDna            0..1 MS and
    bkvDnaKidneyBiopsy     0..1 MS and
    bkvFishKidneyBiopsy    0..1 MS and
    bloodColture           0..1 MS and
    urineColture           0..1 MS and
    otherPositivity        0..1 MS and
    ebvHepatitisLiver      0..1 MS and
    evidenceBkvan          0..1 MS

// EBV-DNA — Positive/Negative (boolean)
* component[ebvDna].code = MicrobiologyCS#ebv-dna
* component[ebvDna].value[x] only boolean
* component[ebvDna] ^short = "ebv_dna — EBV-DNA result (true = Positive)"

* component[ebvDnaCopies].code = MicrobiologyCS#ebv-dna-copies
* component[ebvDnaCopies].value[x] only Quantity
* component[ebvDnaCopies].valueQuantity.system = "http://unitsofmeasure.org"
* component[ebvDnaCopies].valueQuantity.code = #{copies}/mL
* component[ebvDnaCopies] ^short = "ebv_dna_copies — EBV-DNA copies/ml"

// All Boolean serology / detection components (true = Positive, false = Negative)
* component[ebvIgmAntiEa].code = MicrobiologyCS#ebv-igm-anti-ea
* component[ebvIgmAntiEa].value[x] only boolean
* component[ebvIgmAntiEa] ^short = "ebv_igm_anti_ea — EBV IgM anti-EA"

* component[ebvIgmAntiVca].code = MicrobiologyCS#ebv-igm-anti-vca
* component[ebvIgmAntiVca].value[x] only boolean
* component[ebvIgmAntiVca] ^short = "ebv_igm_anti_vca — EBV IgM anti-VCA"

* component[ebvIggAntiVca].code = MicrobiologyCS#ebv-igg-anti-vca
* component[ebvIggAntiVca].value[x] only boolean
* component[ebvIggAntiVca] ^short = "ebv_igg_anti_vca — EBV IgG anti-VCA"

* component[ebvIggEbna].code = MicrobiologyCS#ebv-igg-ebna
* component[ebvIggEbna].value[x] only boolean
* component[ebvIggEbna] ^short = "ebv_igg_ebna — EBV IgG EBNA"

* component[cmvDna].code = MicrobiologyCS#cmv-dna
* component[cmvDna].value[x] only boolean
* component[cmvDna] ^short = "cmv_dna — CMV-DNA (Positive/Negative)"

* component[cmvDnaCopies].code = MicrobiologyCS#cmv-dna-copies
* component[cmvDnaCopies].value[x] only Quantity
* component[cmvDnaCopies].valueQuantity.system = "http://unitsofmeasure.org"
* component[cmvDnaCopies].valueQuantity.code = #{copies}/mL
* component[cmvDnaCopies] ^short = "cmv_dna_copies — CMV-DNA copies/ml"

* component[cmvIgm].code = MicrobiologyCS#cmv-igm
* component[cmvIgm].value[x] only boolean
* component[cmvIgm] ^short = "cmv_igm — CMV IgM"

* component[cmvIgg].code = MicrobiologyCS#cmv-igg
* component[cmvIgg].value[x] only boolean
* component[cmvIgg] ^short = "cmv_igg — CMV IgG"

* component[parvoB19Dna].code = MicrobiologyCS#parvovirus-b19-dna
* component[parvoB19Dna].value[x] only boolean
* component[parvoB19Dna] ^short = "parvovirus_b19_dna — Parvovirus B19 DNA"

* component[parvoB19DnaCopies].code = MicrobiologyCS#parvovirus-b19-dna-copies
* component[parvoB19DnaCopies].value[x] only Quantity
* component[parvoB19DnaCopies].valueQuantity.system = "http://unitsofmeasure.org"
* component[parvoB19DnaCopies].valueQuantity.code = #{copies}/mL
* component[parvoB19DnaCopies] ^short = "parvovirus_b19_dna_copies — Parvovirus B19 DNA copies/ml"

* component[parvoB19Igg].code = MicrobiologyCS#parvovirus-b19-igg
* component[parvoB19Igg].value[x] only boolean
* component[parvoB19Igg] ^short = "parvovirus_b19_dna_igg — Parvovirus B19 IgG"

* component[parvoB19Igm].code = MicrobiologyCS#parvovirus-b19-igm
* component[parvoB19Igm].value[x] only boolean
* component[parvoB19Igm] ^short = "parvovirus_b19_dna_igm — Parvovirus B19 IgM"

* component[hsvIgg].code = MicrobiologyCS#hsv-igg
* component[hsvIgg].value[x] only boolean
* component[hsvIgg] ^short = "hsv_igg — HSV IgG"

* component[hsvIgm].code = MicrobiologyCS#hsv-igm
* component[hsvIgm].value[x] only boolean
* component[hsvIgm] ^short = "hsv_igm — HSV IgM"

* component[adenovirusIgg].code = MicrobiologyCS#adenovirus-igg
* component[adenovirusIgg].value[x] only boolean
* component[adenovirusIgg] ^short = "adenovirus_igg — Adenovirus IgG"

* component[adenovirusIgm].code = MicrobiologyCS#adenovirus-igm
* component[adenovirusIgm].value[x] only boolean
* component[adenovirusIgm] ^short = "adenovirus_igm — Adenovirus IgM"

* component[bloodAdenovirusDna].code = MicrobiologyCS#blood-adenovirus-dna
* component[bloodAdenovirusDna].value[x] only boolean
* component[bloodAdenovirusDna] ^short = "blood_adenovirus_dna — Adenovirus DNA in blood (Positive/Negative)"

* component[bloodAdenovirusDnaCopies].code = MicrobiologyCS#blood-adenovirus-dna-copies
* component[bloodAdenovirusDnaCopies].value[x] only Quantity
* component[bloodAdenovirusDnaCopies].valueQuantity.system = "http://unitsofmeasure.org"
* component[bloodAdenovirusDnaCopies].valueQuantity.code = #{copies}/mL
* component[bloodAdenovirusDnaCopies] ^short = "blood_adenovirus_dna_copies — Blood Adenovirus DNA copies/ml"

* component[vzvIgg].code = MicrobiologyCS#vzv-igg
* component[vzvIgg].value[x] only boolean
* component[vzvIgg] ^short = "vzv_igg — VZV IgG"

* component[vzvIgm].code = MicrobiologyCS#vzv-igm
* component[vzvIgm].value[x] only boolean
* component[vzvIgm] ^short = "vzv_igm — VZV IgM"

* component[bloodBkvDna].code = MicrobiologyCS#blood-bkv-dna
* component[bloodBkvDna].value[x] only boolean
* component[bloodBkvDna] ^short = "blood_bkv_dna — BKV-DNA in blood (Positive/Negative)"

* component[bloodBkvDnaCopies].code = MicrobiologyCS#blood-bkv-dna-copies
* component[bloodBkvDnaCopies].value[x] only Quantity
* component[bloodBkvDnaCopies].valueQuantity.system = "http://unitsofmeasure.org"
* component[bloodBkvDnaCopies].valueQuantity.code = #{copies}/mL
* component[bloodBkvDnaCopies] ^short = "blood_bkv_dna_copies — Blood BKV-DNA copies/ml"

* component[urineBkvDna].code = MicrobiologyCS#urine-bkv-dna
* component[urineBkvDna].value[x] only boolean
* component[urineBkvDna] ^short = "urine_bkv_dna — BKV-DNA in urine"

* component[bkvDnaKidneyBiopsy].code = MicrobiologyCS#bkv-dna-kidney-biopsy
* component[bkvDnaKidneyBiopsy].value[x] only boolean
* component[bkvDnaKidneyBiopsy] ^short = "bkv_dna_kidney_biopsy — BKV-DNA on kidney biopsy"

* component[bkvFishKidneyBiopsy].code = MicrobiologyCS#bkv-fish-kidney-biopsy
* component[bkvFishKidneyBiopsy].value[x] only boolean
* component[bkvFishKidneyBiopsy] ^short = "bkv_fish_kidney_biopsy — BKV FISH on kidney biopsy"

* component[bloodColture].code = MicrobiologyCS#blood-colture
* component[bloodColture].value[x] only boolean
* component[bloodColture] ^short = "blood_colture — blood culture (true = Positive; Kidney)"

* component[urineColture].code = MicrobiologyCS#urine-colture
* component[urineColture].value[x] only boolean
* component[urineColture] ^short = "urine_colture — urine culture (true = Positive; Kidney)"

* component[otherPositivity].code = MicrobiologyCS#other-positivity
* component[otherPositivity].value[x] only string
* component[otherPositivity] ^short = "other_positivity — other microbiological finding (free text; Kidney)"

* component[ebvHepatitisLiver].code = MicrobiologyCS#ebv-hepatitis-liver
* component[ebvHepatitisLiver].value[x] only boolean
* component[ebvHepatitisLiver] ^short = "ebv_hepatitis_liver — EBV hepatitis on liver biopsy (Liver)"

* component[evidenceBkvan].code = MicrobiologyCS#evidence-bkvan
* component[evidenceBkvan].value[x] only CodeableConcept
* component[evidenceBkvan] ^short = "evidence_bkvan — histological evidence of BKVAN (No/Yes/Unknown)"


// ================================================
// Example
// ================================================

Instance: MicrobiologyExample1
InstanceOf: Microbiology
Usage: #example
Title: "Example Microbiology record"
Description: "Example microbiology panel for a liver transplant recipient."

* id = "microbiology-example-1"
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/microbiology-id"
* identifier.value = "M0001"
* status = #final
* code = MicrobiologyCS#microbiology-panel "Microbiology studies panel"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitExample1)
// Donor serology example (uncomment if recording pre-transplant donor results):
// * focus = Reference(ExampleDonor1)

// EBV
* component[ebvDna].code = MicrobiologyCS#ebv-dna
* component[ebvDna].valueBoolean = true

* component[ebvDnaCopies].code = MicrobiologyCS#ebv-dna-copies
* component[ebvDnaCopies].valueQuantity.value = 2450.0
* component[ebvDnaCopies].valueQuantity.system = "http://unitsofmeasure.org"
* component[ebvDnaCopies].valueQuantity.code = #{copies}/mL

* component[ebvIgmAntiEa].code = MicrobiologyCS#ebv-igm-anti-ea
* component[ebvIgmAntiEa].valueBoolean = false

* component[ebvIgmAntiVca].code = MicrobiologyCS#ebv-igm-anti-vca
* component[ebvIgmAntiVca].valueBoolean = false

* component[ebvIggAntiVca].code = MicrobiologyCS#ebv-igg-anti-vca
* component[ebvIggAntiVca].valueBoolean = true

* component[ebvIggEbna].code = MicrobiologyCS#ebv-igg-ebna
* component[ebvIggEbna].valueBoolean = true

// CMV
* component[cmvDna].code = MicrobiologyCS#cmv-dna
* component[cmvDna].valueBoolean = false

* component[cmvIgm].code = MicrobiologyCS#cmv-igm
* component[cmvIgm].valueBoolean = false

* component[cmvIgg].code = MicrobiologyCS#cmv-igg
* component[cmvIgg].valueBoolean = true

// Parvovirus B19
* component[parvoB19Dna].code = MicrobiologyCS#parvovirus-b19-dna
* component[parvoB19Dna].valueBoolean = false

* component[parvoB19Igg].code = MicrobiologyCS#parvovirus-b19-igg
* component[parvoB19Igg].valueBoolean = true

* component[parvoB19Igm].code = MicrobiologyCS#parvovirus-b19-igm
* component[parvoB19Igm].valueBoolean = false

// HSV
* component[hsvIgg].code = MicrobiologyCS#hsv-igg
* component[hsvIgg].valueBoolean = true

* component[hsvIgm].code = MicrobiologyCS#hsv-igm
* component[hsvIgm].valueBoolean = false

// Adenovirus
* component[adenovirusIgg].code = MicrobiologyCS#adenovirus-igg
* component[adenovirusIgg].valueBoolean = true

* component[adenovirusIgm].code = MicrobiologyCS#adenovirus-igm
* component[adenovirusIgm].valueBoolean = false

// VZV
* component[vzvIgg].code = MicrobiologyCS#vzv-igg
* component[vzvIgg].valueBoolean = true

* component[vzvIgm].code = MicrobiologyCS#vzv-igm
* component[vzvIgm].valueBoolean = false

// BKV
* component[bloodBkvDna].code = MicrobiologyCS#blood-bkv-dna
* component[bloodBkvDna].valueBoolean = false

* component[urineBkvDna].code = MicrobiologyCS#urine-bkv-dna
* component[urineBkvDna].valueBoolean = false

* component[bkvDnaKidneyBiopsy].code = MicrobiologyCS#bkv-dna-kidney-biopsy
* component[bkvDnaKidneyBiopsy].valueBoolean = false

* component[bkvFishKidneyBiopsy].code = MicrobiologyCS#bkv-fish-kidney-biopsy
* component[bkvFishKidneyBiopsy].valueBoolean = false
