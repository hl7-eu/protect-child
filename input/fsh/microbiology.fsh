// ================================================
// Microbiology – profile & extensions
// ================================================

// --------------------------------
// Invariants
// --------------------------------

// ebv_dna should be non-negative if present
Invariant: microbiology-ebv-dna-nonnegative
Description: "EBV-DNA value must be zero or positive."
Severity: #error
Expression: "valueDecimal >= 0"

// ================================================
// Extensions – relationships
// ================================================

// patient_id – ElementReference → PatientTransplant
Extension: MicrobiologyPatientRef
Id: microbiology-patient-ref
Title: "Patient ID relationship"
Description: "patient_id – reference to the transplant recipient associated with this microbiology record."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// donor_id – ElementReference → Donor
Extension: MicrobiologyDonorRef
Id: microbiology-donor-ref
Title: "Donor ID relationship"
Description: "donor_id – reference to the donor associated with this microbiology record."
* value[x] only Reference(Donor)
* valueReference 1..1

// ================================================
// Extensions – test variables
// ================================================

// ebv_dna – Float
Extension: MicrobiologyEBVDNA
Id: microbiology-ebv-dna
Title: "Blood EBV-DNA"
Description: "ebv_dna – EBV nucleic acid test result (quantitative, float)."
* value[x] only decimal
* valueDecimal 1..1
* obeys microbiology-ebv-dna-nonnegative

// ebv_igm_anti_ea – Boolean (Negative/Positive)
Extension: MicrobiologyEBVIgMAntiEA
Id: microbiology-ebv-igm-anti-ea
Title: "EBV serology IgM anti-EA"
Description: "ebv_igm_anti_ea – presence of IgM antibodies against EBV Early Antigen (EA); false=Negative, true=Positive."
* value[x] only boolean

// ebv_igm_anti_vca – Boolean
Extension: MicrobiologyEBVIgMAntiVCA
Id: microbiology-ebv-igm-anti-vca
Title: "EBV serology IgM anti-VCA"
Description: "ebv_igm_anti_vca – presence of IgM antibodies against EBV Viral Capsid Antigen (VCA); false=Negative, true=Positive."
* value[x] only boolean

// ebv_igg_anti_vca – Boolean
Extension: MicrobiologyEBVIgGAntiVCA
Id: microbiology-ebv-igg-anti-vca
Title: "EBV serology IgG anti-VCA"
Description: "ebv_igg_anti_vca – presence of IgG antibodies against EBV Viral Capsid Antigen (VCA); false=Negative, true=Positive."
* value[x] only boolean

// ebv_igg_ebna – Boolean
Extension: MicrobiologyEBVIgGEBNA
Id: microbiology-ebv-igg-ebna
Title: "EBV serology IgG EBNA"
Description: "ebv_igg_ebna – presence of IgG antibodies against EBV Nuclear Antigen (EBNA); false=Negative, true=Positive."
* value[x] only boolean

// cmv_dna – Boolean (Negative/Positive; DM says Boolean)
Extension: MicrobiologyCMVDNA
Id: microbiology-cmv-dna
Title: "Blood CMV-DNA"
Description: "cmv_dna – CMV nucleic acid test result (false=Negative, true=Positive)."
* value[x] only boolean

// cmv_igm – Boolean
Extension: MicrobiologyCMVIgM
Id: microbiology-cmv-igm
Title: "CMV serology IgM"
Description: "cmv_igm – presence of IgM antibodies against CMV; false=Negative, true=Positive."
* value[x] only boolean

// cmv_igg – Boolean
Extension: MicrobiologyCMVIgG
Id: microbiology-cmv-igg
Title: "CMV serology IgG"
Description: "cmv_igg – presence of IgG antibodies against CMV; false=Negative, true=Positive."
* value[x] only boolean

// parvovirus_b19_dna – Boolean
Extension: MicrobiologyParvoB19DNA
Id: microbiology-parvovirus-b19-dna
Title: "Blood Parvovirus B19-DNA"
Description: "parvovirus_b19_dna – detection of parvovirus B19 DNA in blood; false=Negative, true=Positive."
* value[x] only boolean

// parvovirus_b19_dna_igg – Boolean
Extension: MicrobiologyParvoB19IgG
Id: microbiology-parvovirus-b19-dna-igg
Title: "Parvovirus B19 serology IgG"
Description: "parvovirus_b19_dna_igg – presence of IgG antibodies to parvovirus B19; false=Negative, true=Positive."
* value[x] only boolean

// parvovirus_b19_dna_igm – Boolean
Extension: MicrobiologyParvoB19IgM
Id: microbiology-parvovirus-b19-dna-igm
Title: "Parvovirus B19 serology IgM"
Description: "parvovirus_b19_dna_igm – presence of IgM antibodies to parvovirus B19; false=Negative, true=Positive."
* value[x] only boolean

// hsv_igg – Boolean
Extension: MicrobiologyHSV_IgG
Id: microbiology-hsv-igg
Title: "HSV serology IgG"
Description: "hsv_igg – presence of IgG antibodies to HSV; false=Negative, true=Positive."
* value[x] only boolean

// hsv_igm – Boolean
Extension: MicrobiologyHSV_IgM
Id: microbiology-hsv-igm
Title: "HSV serology IgM"
Description: "hsv_igm – presence of IgM antibodies to HSV; false=Negative, true=Positive."
* value[x] only boolean

// adenovirus_igg – Boolean
Extension: MicrobiologyAdenovirusIgG
Id: microbiology-adenovirus-igg
Title: "Adenovirus serology IgG"
Description: "adenovirus_igg – presence of IgG antibodies to adenovirus; false=Negative, true=Positive."
* value[x] only boolean

// adenovirus_igm – Boolean
Extension: MicrobiologyAdenovirusIgM
Id: microbiology-adenovirus-igm
Title: "Adenovirus serology IgM"
Description: "adenovirus_igm – presence of IgM antibodies to adenovirus; false=Negative, true=Positive."
* value[x] only boolean

// vzv_igg – Boolean
Extension: MicrobiologyVZVIgG
Id: microbiology-vzv-igg
Title: "VZV serology IgG"
Description: "vzv_igg – presence of IgG antibodies to varicella–zoster virus; false=Negative, true=Positive."
* value[x] only boolean

// vzv_igm – Boolean
Extension: MicrobiologyVZVIgM
Id: microbiology-vzv-igm
Title: "VZV serology IgM"
Description: "vzv_igm – presence of IgM antibodies to varicella–zoster virus; false=Negative, true=Positive."
* value[x] only boolean

// blood_bkv_dna – Boolean
Extension: MicrobiologyBloodBKVDNA
Id: microbiology-blood-bkv-dna
Title: "Blood BKV-DNA"
Description: "blood_bkv_dna – detection of BK virus DNA in blood; false=Negative, true=Positive."
* value[x] only boolean

// urine_bkv_dna – Boolean
Extension: MicrobiologyUrineBKVDNA
Id: microbiology-urine-bkv-dna
Title: "Urine BKV-DNA"
Description: "urine_bkv_dna – detection of BK virus DNA in urine; false=Negative, true=Positive."
* value[x] only boolean

// bkv_dna_kidney_biopsy – Boolean
Extension: MicrobiologyBKVDNAKidneyBiopsy
Id: microbiology-bkv-dna-kidney-biopsy
Title: "BKV-DNA on kidney biopsy"
Description: "bkv_dna_kidney_biopsy – detection of BK virus DNA on kidney biopsy; false=Negative, true=Positive."
* value[x] only boolean

// bkv_fish_kidney_biopsy – Boolean
Extension: MicrobiologyBKVFISHKidneyBiopsy
Id: microbiology-bkv-fish-kidney-biopsy
Title: "BKV FISH on kidney biopsy"
Description: "bkv_fish_kidney_biopsy – BK virus FISH on kidney biopsy; false=Negative, true=Positive."
* value[x] only boolean

// ================================================
// Microbiology profile (Observation)
// ================================================

Profile: Microbiology
Parent: Observation
Id: microbiology
Title: "Microbiology"
Description: "Microbiology results related to transplant recipients and/or donors, aligned with the microbiology table."

// microbiology_id → Observation.identifier (Mandatory)
* identifier 1..1 MS
* identifier ^short = "microbiology_id – Microbiology ID from the data model"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/microbiology-id" (exactly)
* identifier.value 1..1

// Observation basics
* status 1..1 MS
* status = #final
* code 1..1 MS
* code.text = "Microbiology panel"
* subject 0..1 MS
* subject ^short = "Optional subject; may be recipient or donor. See patient_id and donor_id extensions for exact linkage."

// We don't use Observation.value[x] directly; all tests are on extensions
* value[x] 0..0

// Attach relationship extensions
* extension contains MicrobiologyPatientRef named patient_id 0..1 MS
* extension contains MicrobiologyDonorRef named donor_id 0..1 MS

* extension[patient_id] ^short = "patient_id – reference to PatientTransplant"
* extension[donor_id] ^short = "donor_id – reference to Donor"

// Attach test extensions 
* extension contains MicrobiologyEBVDNA named ebv_dna 1..1 MS
* extension contains MicrobiologyEBVIgMAntiEA named ebv_igm_anti_ea 1..1 MS
* extension contains MicrobiologyEBVIgMAntiVCA named ebv_igm_anti_vca 1..1 MS
* extension contains MicrobiologyEBVIgGAntiVCA named ebv_igg_anti_vca 1..1 MS
* extension contains MicrobiologyEBVIgGEBNA named ebv_igg_ebna 1..1 MS
* extension contains MicrobiologyCMVDNA named cmv_dna 1..1 MS
* extension contains MicrobiologyCMVIgM named cmv_igm 1..1 MS
* extension contains MicrobiologyCMVIgG named cmv_igg 1..1 MS
* extension contains MicrobiologyParvoB19DNA named parvovirus_b19_dna 1..1 MS
* extension contains MicrobiologyParvoB19IgG named parvovirus_b19_dna_igg 1..1 MS
* extension contains MicrobiologyParvoB19IgM named parvovirus_b19_dna_igm 1..1 MS
* extension contains MicrobiologyHSV_IgG named hsv_igg 1..1 MS
* extension contains MicrobiologyHSV_IgM named hsv_igm 1..1 MS
* extension contains MicrobiologyAdenovirusIgG named adenovirus_igg 1..1 MS
* extension contains MicrobiologyAdenovirusIgM named adenovirus_igm 1..1 MS
* extension contains MicrobiologyVZVIgG named vzv_igg 1..1 MS
* extension contains MicrobiologyVZVIgM named vzv_igm 1..1 MS
* extension contains MicrobiologyBloodBKVDNA named blood_bkv_dna 1..1 MS
* extension contains MicrobiologyUrineBKVDNA named urine_bkv_dna 1..1 MS
* extension contains MicrobiologyBKVDNAKidneyBiopsy named bkv_dna_kidney_biopsy 1..1 MS
* extension contains MicrobiologyBKVFISHKidneyBiopsy named bkv_fish_kidney_biopsy 1..1 MS

// Short labels for tests 
* extension[ebv_dna] ^short = "ebv_dna – EBV nucleic acid test result (float)"
* extension[ebv_igm_anti_ea] ^short = "ebv_igm_anti_ea – EBV serology IgM anti-EA (false=Negative, true=Positive)"
* extension[ebv_igm_anti_vca] ^short = "ebv_igm_anti_vca – EBV serology IgM anti-VCA (false=Negative, true=Positive)"
* extension[ebv_igg_anti_vca] ^short = "ebv_igg_anti_vca – EBV serology IgG anti-VCA (false=Negative, true=Positive)"
* extension[ebv_igg_ebna] ^short = "ebv_igg_ebna – EBV serology IgG EBNA (false=Negative, true=Positive)"
* extension[cmv_dna] ^short = "cmv_dna – Blood CMV-DNA (false=Negative, true=Positive)"
* extension[cmv_igm] ^short = "cmv_igm – CMV serology IgM (false=Negative, true=Positive)"
* extension[cmv_igg] ^short = "cmv_igg – CMV serology IgG (false=Negative, true=Positive)"
* extension[parvovirus_b19_dna] ^short = "parvovirus_b19_dna – Blood Parvovirus B19-DNA (false=Negative, true=Positive)"
* extension[parvovirus_b19_dna_igg] ^short = "parvovirus_b19_dna_igg – Parvovirus B19 serology IgG (false=Negative, true=Positive)"
* extension[parvovirus_b19_dna_igm] ^short = "parvovirus_b19_dna_igm – Parvovirus B19 serology IgM (false=Negative, true=Positive)"
* extension[hsv_igg] ^short = "hsv_igg – HSV serology IgG (false=Negative, true=Positive)"
* extension[hsv_igm] ^short = "hsv_igm – HSV serology IgM (false=Negative, true=Positive)"
* extension[adenovirus_igg] ^short = "adenovirus_igg – Adenovirus serology IgG (false=Negative, true=Positive)"
* extension[adenovirus_igm] ^short = "adenovirus_igm – Adenovirus serology IgM (false=Negative, true=Positive)"
* extension[vzv_igg] ^short = "vzv_igg – VZV serology IgG (false=Negative, true=Positive)"
* extension[vzv_igm] ^short = "vzv_igm – VZV serology IgM (false=Negative, true=Positive)"
* extension[blood_bkv_dna] ^short = "blood_bkv_dna – Blood BKV-DNA (false=Negative, true=Positive)"
* extension[urine_bkv_dna] ^short = "urine_bkv_dna – Urine BKV-DNA (false=Negative, true=Positive)"
* extension[bkv_dna_kidney_biopsy] ^short = "bkv_dna_kidney_biopsy – BKV-DNA on kidney biopsy (false=Negative, true=Positive)"
* extension[bkv_fish_kidney_biopsy] ^short = "bkv_fish_kidney_biopsy – BKV FISH on kidney biopsy (false=Negative, true=Positive)"

// ================================================
// Example Microbiology instance
// ================================================

Instance: MicrobiologyExample1
InstanceOf: Microbiology
Usage: #example
Title: "Example Microbiology record"
Description: "Example microbiology panel for a transplant recipient."

* id = "microbiology-example-1"

* code.coding[0].system = "http://loinc.org"
* code.coding[0].code = #24323-8
* code.coding[0].display = "Microbiology studies (set)"

// microbiology_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/microbiology-id"
* identifier.value = "M0001"

// optional subject (recipient)
* subject = Reference(ExamplePatientTransplant1)

// patient_id / donor_id relationships
* extension[patient_id].valueReference = Reference(ExamplePatientTransplant1)
// If needed, donor example can be added as well:
// * extension[donor_id].valueReference = Reference(ExampleDonor1)

// Example test values
* extension[ebv_dna].valueDecimal = 2450.0
* extension[ebv_igm_anti_ea].valueBoolean = false
* extension[ebv_igm_anti_vca].valueBoolean = false
* extension[ebv_igg_anti_vca].valueBoolean = true
* extension[ebv_igg_ebna].valueBoolean = true

* extension[cmv_dna].valueBoolean = false
* extension[cmv_igm].valueBoolean = false
* extension[cmv_igg].valueBoolean = true

* extension[parvovirus_b19_dna].valueBoolean = false
* extension[parvovirus_b19_dna_igg].valueBoolean = true
* extension[parvovirus_b19_dna_igm].valueBoolean = false

* extension[hsv_igg].valueBoolean = true
* extension[hsv_igm].valueBoolean = false

* extension[adenovirus_igg].valueBoolean = true
* extension[adenovirus_igm].valueBoolean = false

* extension[vzv_igg].valueBoolean = true
* extension[vzv_igm].valueBoolean = false

* extension[blood_bkv_dna].valueBoolean = false
* extension[urine_bkv_dna].valueBoolean = false
* extension[bkv_dna_kidney_biopsy].valueBoolean = false
* extension[bkv_fish_kidney_biopsy].valueBoolean = false
