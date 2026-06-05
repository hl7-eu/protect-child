// lab-result.fsh
// Lab results — lab_result table
// Observation + DiagnosticReport

// gfr_formula and gfr_cyst_formula are carried via Observation.method (native R4 field).
// method.text holds the free-text formula name (e.g. "CKD-EPI", "Schwartz", "MDRD").

// Unit terminology — UCUM codes for Observation.valueQuantity
ValueSet: LabResultUnitVS
Id: lab-result-unit-vs
Title: "Lab Result Unit ValueSet"
Description: "Allowed UCUM units of measurement for lab result values (DMv1.2 unit field)."
* ^experimental = true

* http://unitsofmeasure.org#"mg/dL"           "mg/dL"
* http://unitsofmeasure.org#"umol/L"          "µmol/L"
* http://unitsofmeasure.org#"mL/min/{1.73_m2}" "mL/min/1.73 m²"
* http://unitsofmeasure.org#"mg/L"            "mg/L"
* http://unitsofmeasure.org#"meq/L"           "mEq/L"
* http://unitsofmeasure.org#"mmol/L"          "mmol/L"
* http://unitsofmeasure.org#"ng/L"            "ng/L"
* http://unitsofmeasure.org#"nmol/L"          "nmol/L"
* http://unitsofmeasure.org#"[IU]/L"          "U/L"
* http://unitsofmeasure.org#"%"               "%"
* http://unitsofmeasure.org#"g/L"             "g/L"
* http://unitsofmeasure.org#"1"               "ratio"
* http://unitsofmeasure.org#"g/dL"            "g/dL"
* http://unitsofmeasure.org#"10*12/L"         "10^12/L"
* http://unitsofmeasure.org#"10*6/L"          "10^6/L"
* http://unitsofmeasure.org#"10*9/L"          "10^9/L"
* http://unitsofmeasure.org#"10*3/uL"         "10^3/µL"
* http://unitsofmeasure.org#"s"               "s"
* http://unitsofmeasure.org#"el/uL"           "el/µL"
* http://unitsofmeasure.org#"mg/d"            "mg(protein)/day"
* http://unitsofmeasure.org#"mg/mg"           "mg/mg"
* http://unitsofmeasure.org#"mg/mmol"         "mg/mmol"
* http://unitsofmeasure.org#"mg/g"            "mg/g"



// ---------------------------------------
// Invariants
// ---------------------------------------

Invariant: pc-lab-1
Description: "A lab result SHALL have either a value[x] or a dataAbsentReason, but not both."
Severity: #error
Expression: "value.exists() xor dataAbsentReason.exists()"

// ---------------------------------------
// LabResultObservation profile (Observation)
// ---------------------------------------

Profile: LabResultObservation
Parent: Observation
Id: lab-result-observation
Title: "Lab Result"
Description: "Individual laboratory result for a transplant recipient, aligned with the lab_result table."

// lab_result_id -> Observation.identifier (Mandatory)
* identifier 1..1 MS
* identifier ^short = "lab_result_id – lab result identifier from the data model"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/lab-result-id" (exactly)
* identifier.value 1..1

// Status is mandatory
* status 1..1 MS
* status ^short = "Status of the lab result (e.g. final, amended)"

// Category fixed to laboratory
* category 1..1 MS
* category.coding 1..1
* category.coding.system 1..1
* category.coding.system = "http://terminology.hl7.org/CodeSystem/observation-category" (exactly)
* category.coding.code 1..1
* category.coding.code = #laboratory (exactly)
* category.coding.display = "Laboratory"

// lab_test_id → Observation.code (required binding to LabTestNameVS)
// The code value is the OMOP concept_id, matching LabTest.code — no reference extension needed.
* code 1..1 MS
* code from LabTestNameVS (required)
* code ^short = "lab_test_id — lab test name (from LabTestNameVS / LabTest.code)"

// patient_id → Observation.subject
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "patient_id — transplant recipient"

// visit_id → Observation.encounter
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id – visit during which this lab result was obtained"

// Timing – date of the lab test
* effective[x] 1..1 MS
* effective[x] only dateTime
* effectiveDateTime ^short = "date – date (and time) when the lab test was performed"

// lab_test_id → LabTest (ObservationDefinition) link is implicit via shared code.
// R4 Observation.basedOn does not allow Reference(ObservationDefinition); the link is
// established by matching Observation.code against LabTest.code (both bound to LabTestNameVS).

// Specimen (BioSample)
* specimen 0..1 MS
* specimen only Reference(BioSample)
* specimen ^short = "Specimen (bio_sample) from which the lab result was obtained"

// Numerical result – value (Float) and unit.
// DM v1.2 marks 'value' as R (Recommended), so value[x] is 0..1.
// When a result is unavailable (not collected, below detection limit, etc.)
// value[x] SHALL be absent and dataAbsentReason SHALL be populated instead.
// Invariant pc-lab-1 enforces that exactly one of the two is present.
* obeys pc-lab-1
* value[x] 0..1 MS
* value[x] only Quantity
* valueQuantity ^short = "value – numeric result with UCUM unit"

// Quantity sub-elements
* valueQuantity.value 0..1
* valueQuantity.value ^short = "Numeric result (float) – maps the 'value' column"
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org" (exactly)
* valueQuantity.code 1..1
* valueQuantity.code from LabResultUnitVS (required)
* valueQuantity.code ^short = "unit – unit of measurement (from LabResultUnitVS)"
* valueQuantity.unit 0..1
* valueQuantity.unit ^short = "Human-readable unit label (e.g. mg/dL, µmol/L)"

// dataAbsentReason – required when value[x] is absent
* dataAbsentReason 0..1 MS
* dataAbsentReason ^short = "Reason value is missing (e.g. not-performed, error, below-detection-limit)"

// Interpretation (e.g. high/low/normal)
* interpretation 0..*
* interpretation ^short = "Clinical interpretation (e.g. high, low, normal)"

// gfr_formula / gfr_cyst_formula → Observation.method (native field for measurement technique)
* method 0..1 MS
* method ^short = "gfr_formula / gfr_cyst_formula — formula used to calculate GFR (e.g. CKD-EPI, Schwartz, MDRD). Use method.text for free-text formula name."



// ---------------------------------------
// LabReport profile (DiagnosticReport)
// ---------------------------------------

Profile: LabReport
Parent: DiagnosticReport
Id: lab-report
Title: "Laboratory DiagnosticReport"
Description: "Laboratory report grouping one or more lab result observations for a transplant recipient."

// Status is mandatory
* status 1..1 MS
* status ^short = "Status of the laboratory report"

// Category fixed to LAB
* category 1..1 MS
* category.coding 1..1
* category.coding.system 1..1
* category.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0074" (exactly)
* category.coding.code 1..1
* category.coding.code = #LAB (exactly)
* category.coding.display = "Laboratory"

// Report code (generic)
* code 1..1 MS
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "http://loinc.org" (exactly)
* code.coding.code 1..1
* code.coding.code = #11502-2
* code.coding.display = "Laboratory report"

// Recipient link
* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// Timing
* effective[x] 0..1 MS
* issued 0..1 MS

// Specimen
* specimen 0..* MS
* specimen only Reference(BioSample)

// Results
* result 1..* MS
* result only Reference(Observation)
* result ^short = "References one or more LabResultObservation resources"



// ---------------------------------------
// Examples
// ---------------------------------------

Instance: LabResultObservationExample1
InstanceOf: LabResultObservation
Usage: #example
Title: "Example Lab Result Observation"
Description: "Example creatinine result for a transplant recipient."

* id = "lab-result-observation-example-1"

// lab_result_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/lab-result-id"
* identifier.value = "LR0001"

// Status & category
* status = #final
* category.coding.system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category.coding.code = #laboratory
* category.coding.display = "Laboratory"

// lab_test_id → Observation.code (LOINC 2160-0 = Creatinine in Serum or Plasma)
* code = http://loinc.org#2160-0 "Creatinine [Mass/volume] in Serum or Plasma"

// patient_id → Observation.subject (native)
* subject = Reference(ExamplePatientTransplant1)

// visit_id (link back to Visit)
* encounter = Reference(VisitExample1)

// Timing (date of lab test)
* effectiveDateTime = "2023-09-02T09:15:00+01:00"

// Specimen
* specimen = Reference(BioSampleExample1)

// Numeric result and unit
* valueQuantity.value = 1.2
* valueQuantity.code = #"mg/dL"
* valueQuantity.unit = "mg/dL"
* valueQuantity.system = "http://unitsofmeasure.org"

// Optional interpretation
* interpretation[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"
* interpretation[0].coding[0].code = #H
* interpretation[0].coding[0].display = "High"


Instance: LabReportExample1
InstanceOf: LabReport
Usage: #example
Title: "Example Laboratory Report"
Description: "Example lab report grouping a single creatinine result."

* id = "lab-report-example-1"

// Status & category
* status = #final
* category.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0074"
* category.coding.code = #LAB
* category.coding.display = "Laboratory"

// Report code
* code.coding.system = "http://loinc.org"
* code.coding.code = #11502-2
* code.coding.display = "Laboratory report"

// Recipient
* subject = Reference(ExamplePatientTransplant1)

// Timing
* effectiveDateTime = "2023-09-02T09:15:00+01:00"
* issued = "2023-09-02T11:30:00+01:00"

// Specimen
* specimen[0] = Reference(BioSampleExample1)

// Results
* result[0] = Reference(LabResultObservationExample1)
