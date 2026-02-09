// lab-result.fsh
// Lab results modeled with Observation + DiagnosticReport

// ---------------------------------------
// Unit terminology for lab results (unit)
// ---------------------------------------

// ---------------------------------------
// Unit terminology for lab results (UCUM)
// ---------------------------------------

// Use UCUM for Observation.valueQuantity
// system: http://unitsofmeasure.org
// code: UCUM code (e.g., "mg/dL")

ValueSet: LabResultUnitVS
Id: lab-result-unit-vs
Title: "Lab Result Unit ValueSet"
Description: "Allowed UCUM units of measurement for lab result values (unit column)."
* ^experimental = true

* http://unitsofmeasure.org#"mg/dL" "mg/dL"
* http://unitsofmeasure.org#"umol/L" "µmol/L"
* http://unitsofmeasure.org#"mL/min/{1.73_m2}" "mL/min/1.73 m2"
* http://unitsofmeasure.org#"meq/L" "mEq/L"
* http://unitsofmeasure.org#"g/dL" "g/dL"
* http://unitsofmeasure.org#"g/L" "g/L"
* http://unitsofmeasure.org#"[IU]/L" "IU/L"
* http://unitsofmeasure.org#"%" "%"
* http://unitsofmeasure.org#"mmol/L" "mmol/L"
* http://unitsofmeasure.org#"10*3/uL" "10^3/µL"
* http://unitsofmeasure.org#"10*9/L" "10^9/L"
* http://unitsofmeasure.org#"10*3/mm3" "10^3/mm3"
* http://unitsofmeasure.org#"s" "s"


// ---------------------------------------
// Extensions
// ---------------------------------------

// ---------------------------------------

// Link to LabTest catalog row (lab_test_id)
Extension: LabResultLabTestRef
Id: lab-result-labtest-ref
Title: "Lab test reference"
Description: "lab_test_id – reference to the lab test definition (LabTest catalog row) associated with this lab result."
* value[x] only Reference(LabTest)
* valueReference 1..1
* valueReference ^short = "Lab test definition (catalog row)"

// Limit context to Observation
* ^context[0].type = #element
* ^context[0].expression = "Observation"

// patient_id – ElementReference to PatientTransplant
Extension: LabResultPatientRef
Id: lab-result-patient-ref
Title: "Lab result patient reference"
Description: "patient_id – reference to the transplant recipient for whom this lab result is recorded."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// Limit context to Observation
* ^context[0].type = #element
* ^context[0].expression = "Observation"



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

// Test code
* code 1..1 MS
* code ^short = "Lab test code (e.g. creatinine, ALT, etc.)"

// Recipient link 
* subject 0..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Optional subject; DM patient_id is captured in extension[patient_id]"

// Timing – date of the lab test
* effective[x] 1..1 MS
* effective[x] only dateTime
* effectiveDateTime ^short = "date – date (and time) when the lab test was performed"

// Specimen (BioSample)
* specimen 0..1 MS
* specimen only Reference(BioSample)
* specimen ^short = "Specimen (bio_sample) from which the lab result was obtained"

// Numerical result – value (Float) and unit
* value[x] 1..1 MS
* value[x] only Quantity
* valueQuantity ^short = "value – value of the test as a numeric quantity with unit"

// Bind Quantity fields to DM unit and value
* valueQuantity.value 1..1
* valueQuantity.value ^short = "Numeric result (float) – maps the 'value' column"
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org" (exactly)
* valueQuantity.code 1..1
* valueQuantity.code from LabResultUnitVS (required)
* valueQuantity.code ^short = "unit – unit of measurement (from LabResultUnitVS)"
* valueQuantity.unit 0..1
* valueQuantity.unit ^short = "Human-readable unit label (e.g. mg/dL, µmol/L)"

// Interpretation (e.g. high/low/normal)
* interpretation 0..*
* interpretation ^short = "Clinical interpretation (e.g. high, low, normal)"

// Attach DM ElementReferences as extensions
* extension contains LabResultLabTestRef named lab_test_id 1..1 MS
* extension contains LabResultPatientRef named patient_id 1..1 MS

* extension[lab_test_id] ^short = "lab_test_id – reference to LabTest catalog row"
* extension[patient_id] ^short = "patient_id – reference to PatientTransplant"



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

// Test code – example: serum creatinine (LOINC 2160-0)
* code.coding[0].system = "http://loinc.org"
* code.coding[0].code = #2160-0
* code.coding[0].display = "Creatinine [Mass/volume] in Serum or Plasma"

// DM ElementReferences
* extension[lab_test_id].valueReference = Reference(LabTestExample1)
* extension[patient_id].valueReference = Reference(ExamplePatientTransplant1)

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
