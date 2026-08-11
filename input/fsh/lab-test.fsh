// ================================================
// Lab Test — lab_test table
// ObservationDefinition
// ================================================

Alias: $loinc = http://loinc.org

// ------------------------------------------------
// Terminology
// ------------------------------------------------

// LOINC-based ValueSet for lab test names.
// Previous versions used a local CodeSystem mixing OMOP concept IDs with
// semantic abbreviations. This has been replaced with LOINC codes,
// which are the international standard for laboratory test identification.
// For tests where no single unambiguous LOINC code exists, local codes
// from LabTestLocalCS are provided.

CodeSystem: LabTestLocalCS
Id: lab-test-local-cs
Title: "Lab Test Local Codes"
Description: "Local codes for laboratory tests that do not have a single unambiguous LOINC code in the PROTECT-CHILD context (e.g., calculated values or composite measures)."
* ^content = #complete
* ^caseSensitive = true
* ^experimental = true
* #creatinine-egfr                "Creatinine eGFR"
  "Estimated GFR calculated from serum creatinine (formula specified in Observation extension gfr_formula)."
* #cystatinc-egfr                 "Cystatin C eGFR"
  "Estimated GFR calculated from Cystatin C (formula specified in Observation extension gfr_cyst_formula)."
* #indirect-bilirubin             "Indirect Bilirubin"
  "Indirect (unconjugated) bilirubin — calculated as total minus direct."
* #proteinuria-creatininuria-ratio "Proteinuria/creatininuria ratio"
  "Urine protein-to-creatinine ratio."
* #prothrombin-activity           "Prothrombin Activity"
  "Prothrombin activity (%). Distinct from prothrombin time (seconds/INR)."
* #urine-microscopic-hematuria    "Urine microscopic hematuria"
  "Microscopic hematuria on urine sediment examination."

ValueSet: LabTestNameVS
Id: lab-test-name-vs
Title: "Lab Test Name ValueSet"
Description: "Allowed laboratory test names for the PROTECT-CHILD data model. LOINC codes are used as the primary standard; local codes from LabTestLocalCS are used only for calculated or composite measures without a single unambiguous LOINC equivalent."
* ^experimental = true

// ── Proteins & Enzymes ──
* $loinc#1751-7   "Albumin [Mass/volume] in Serum or Plasma"
* $loinc#14959-1  "Microalbumin/Creatinine [Mass Ratio] in Urine"
* $loinc#1742-6   "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"   // ALT
* $loinc#1920-8   "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"  // AST
* $loinc#2324-2   "Gamma glutamyl transferase [Enzymatic activity/volume] in Serum or Plasma"  // GGT
* $loinc#2532-0   "Lactate dehydrogenase [Enzymatic activity/volume] in Serum or Plasma"       // LDH
* $loinc#2885-2   "Protein [Mass/volume] in Serum or Plasma"                                    // Total protein
* $loinc#4536-9   "Haptoglobin [Mass/volume] in Serum or Plasma"

// ── Bilirubin ──
* $loinc#1975-2   "Bilirubin.total [Mass/volume] in Serum or Plasma"
* $loinc#1968-7   "Bilirubin.direct [Mass/volume] in Serum or Plasma"
* LabTestLocalCS#indirect-bilirubin "Indirect Bilirubin"

// ── Renal function ──
* $loinc#2160-0   "Creatinine [Mass/volume] in Serum or Plasma"
* LabTestLocalCS#creatinine-egfr "Creatinine eGFR"
* $loinc#33806-1  "Cystatin C [Mass/volume] in Serum or Plasma"
* LabTestLocalCS#cystatinc-egfr "Cystatin C eGFR"
* $loinc#3094-0   "Urea nitrogen [Mass/volume] in Serum or Plasma"                             // Urea/BUN
* $loinc#3084-1   "Uric acid [Mass/volume] in Serum or Plasma"
* $loinc#2161-8   "Creatinine [Mass/volume] in Urine"
* $loinc#5794-3   "Hemoglobin [Presence] in Urine by Test strip"                               // Urine haemoglobin
* $loinc#2889-4   "Protein [Mass/volume] in 24 hour Urine"                                     // Quantitative proteinuria
* LabTestLocalCS#proteinuria-creatininuria-ratio "Proteinuria/creatininuria ratio"
* $loinc#2777-1   "Phosphate [Mass/volume] in Serum or Plasma"                                 // Phosphorus

// ── Metabolic ──
* $loinc#2345-7   "Glucose [Mass/volume] in Serum or Plasma"
* $loinc#2093-3   "Cholesterol [Mass/volume] in Serum or Plasma"
* $loinc#17861-6  "Calcium [Mass/volume] in Serum or Plasma"
* $loinc#2823-3   "Potassium [Moles/volume] in Serum or Plasma"
* $loinc#2951-2   "Sodium [Moles/volume] in Serum or Plasma"
* $loinc#1963-8   "Bicarbonate [Moles/volume] in Serum or Plasma"                              // HCO3
* $loinc#2524-7   "Lactate [Moles/volume] in Venous blood"
* $loinc#2745-8   "pH of Venous blood"
* $loinc#4548-4   "Hemoglobin A1c/Hemoglobin.total in Blood"                                  // HbA1c
* $loinc#2258-2   "Bile acids [Moles/volume] in Serum or Plasma"
* $loinc#1845-7   "Ammonia [Moles/volume] in Plasma"                                           // Ammonium levels

// ── Endocrine ──
* $loinc#2731-8   "Parathyrin.intact [Units/volume] in Serum or Plasma"                        // PTH
* $loinc#14635-7  "25-hydroxyvitamin D3 [Mass/volume] in Serum or Plasma"                      // Vitamin D

// ── Haematology ──
* $loinc#718-7    "Hemoglobin [Mass/volume] in Blood"
* $loinc#4544-3   "Hematocrit [Volume Fraction] of Blood by Automated count"
* $loinc#789-8    "Erythrocytes [#/volume] in Blood by Automated count"                        // RBC
* $loinc#777-3    "Platelets [#/volume] in Blood by Automated count"
* $loinc#6690-2   "Leukocytes [#/volume] in Blood by Automated count"                         // WBC
* $loinc#731-0    "Lymphocytes [#/volume] in Blood by Automated count"
* $loinc#751-8    "Neutrophils [#/volume] in Blood by Automated count"

// ── Coagulation ──
* $loinc#5902-2   "Prothrombin time (PT)"
* $loinc#6301-6   "INR in Platelet poor plasma by Coagulation assay"                           // INR
* $loinc#3173-2   "aPTT in Platelet poor plasma by Coagulation assay"
* LabTestLocalCS#prothrombin-activity "Prothrombin Activity"

// ── Urine sediment ──
* LabTestLocalCS#urine-microscopic-hematuria "Urine microscopic hematuria"


// ================================================
// LabTest profile — ObservationDefinition
// ================================================

Profile: LabTest
Parent: ObservationDefinition
Id: lab-test
Title: "Lab Test"
Description: "Definition of a laboratory test (catalogue entry), aligned with the lab_test table. Systems SHALL use LOINC codes from LabTestNameVS as the primary code. Local codes from LabTestLocalCS SHALL only be used for calculated values without a single unambiguous LOINC code."

// lab_test_id → ObservationDefinition.identifier
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/lab-test-id" (exactly)
* identifier.value 1..1
* identifier ^short = "lab_test_id — laboratory test catalogue identifier"

// name → ObservationDefinition.code (required binding to LOINC-based ValueSet)
* code 1..1 MS
* code from LabTestNameVS (required)
* code ^short = "name — laboratory test name (LOINC code preferred)"

// unit_id → ObservationDefinition.quantitativeDetails.unit (UCUM)
* quantitativeDetails 0..1 MS
* quantitativeDetails.unit 0..1 MS
* quantitativeDetails.unit ^short = "unit_id — UCUM unit for the test result"


// ================================================
// Example
// ================================================

Instance: LabTestExample1
InstanceOf: LabTest
Usage: #example
Title: "Example Lab Test"
Description: "Example lab test catalogue entry — Albumin, reported in g/dL."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/lab-test-id"
* identifier.value = "LT0001"
* code = $loinc#1751-7 "Albumin [Mass/volume] in Serum or Plasma"
* quantitativeDetails.unit.coding[0].system = "http://unitsofmeasure.org"
* quantitativeDetails.unit.coding[0].code = #g/dL
* quantitativeDetails.unit.coding[0].display = "g/dL"
