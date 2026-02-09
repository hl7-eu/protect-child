// ================================================
// Clinical Variable – extensions & profile
// ================================================

// ================================================
// Extensions
// ================================================

// patient_id – ElementReference(PatientTransplant)
Extension: ClinicalVariablePatientRef
Id: clinical-variable-patient-ref
Title: "Patient ID relationship"
Description: "Reference to the patient for whom clinical variables are recorded."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// date – Date
Extension: ClinicalVariableDate
Id: clinical-variable-date
Title: "Date"
Description: "Date when vital signs were measured."
* value[x] only date
* valueDate 1..1

// weight – Float (decimal, kg)
Extension: ClinicalVariableWeight
Id: clinical-variable-weight
Title: "Weight"
Description: "Patient’s weight in kilograms."
* value[x] only decimal
* valueDecimal 1..1

// height – Float (decimal, cm)
Extension: ClinicalVariableHeight
Id: clinical-variable-height
Title: "Height"
Description: "Patient’s height/length in centimeters."
* value[x] only decimal
* valueDecimal 1..1

// systolic_blood_pressure – Integer (mmHg)
Extension: ClinicalVariableSystolicBloodPressure
Id: clinical-variable-systolic-blood-pressure
Title: "Systolic blood pressure"
Description: "Systolic blood pressure in mmHg."
* value[x] only integer
* valueInteger 1..1
* valueInteger ^minValueInteger = 0
* valueInteger ^maxValueInteger = 300

// diastolic_blood_pressure – Integer (mmHg)
Extension: ClinicalVariableDiastolicBloodPressure
Id: clinical-variable-diastolic-blood-pressure
Title: "Diastolic blood pressure"
Description: "Diastolic blood pressure in mmHg."
* value[x] only integer
* valueInteger 1..1
* valueInteger ^minValueInteger = 0
* valueInteger ^maxValueInteger = 150

// heart_rate – Integer (beats/min)
Extension: ClinicalVariableHeartRate
Id: clinical-variable-heart-rate
Title: "Heart rate"
Description: "Pulse rate in beats per minute."
* value[x] only integer
* valueInteger 1..1
* valueInteger ^minValueInteger = 0
* valueInteger ^maxValueInteger = 300

// oxygen_saturation – Integer (%)
Extension: ClinicalVariableOxygenSaturation
Id: clinical-variable-oxygen-saturation
Title: "Oxygen saturation"
Description: "Oxygen saturation at rest, in percent."
* value[x] only integer
* valueInteger 1..1
* valueInteger ^minValueInteger = 0
* valueInteger ^maxValueInteger = 100

// temperature – Integer (°C)
Extension: ClinicalVariableTemperature
Id: clinical-variable-temperature
Title: "Temperature"
Description: "Body temperature in degrees Celsius."
* value[x] only integer
* valueInteger 1..1
* valueInteger ^minValueInteger = 35
* valueInteger ^maxValueInteger = 45


// ================================================
// Clinical Variable profile (using Basic)
// ================================================

Profile: ClinicalVariable
Parent: Basic
Id: clinical-variable
Title: "Clinical Variable"
Description: "Clinical variables and vital signs recorded for a transplant patient."

// ------------------------------------------------
// clinical_variable_id → Basic.identifier
//   Column: clinical_variable_id
//   Type: ID
// ------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Clinical variable ID"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/clinical-variable-id" (exactly)
* identifier.value 1..1

// ------------------------------------------------
// Basic.code is required.
// Use as a simple category for vitals/clinical variables.
// ------------------------------------------------
* code 1..1 MS
* code ^short = "Clinical variable category"
* code.coding 1..1
* code.coding.system 1..1
* code.coding.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/clinical-variable-type" (exactly)
* code.coding.code 1..1
* code.coding.display 0..1

// ------------------------------------------------
// Attach Clinical Variable–specific extensions
// ------------------------------------------------
* extension contains
    ClinicalVariablePatientRef named patientId 0..1 MS and
    ClinicalVariableDate named date 0..1 MS and
    ClinicalVariableWeight named weight 0..1 MS and
    ClinicalVariableHeight named height 0..1 MS and
    ClinicalVariableSystolicBloodPressure named systolicBloodPressure 0..1 MS and
    ClinicalVariableDiastolicBloodPressure named diastolicBloodPressure 0..1 MS and
    ClinicalVariableHeartRate named heartRate 0..1 MS and
    ClinicalVariableOxygenSaturation named oxygenSaturation 0..1 MS and
    ClinicalVariableTemperature named temperature 0..1 MS

// Short labels
* extension[patientId] ^short = "Patient ID relationship"
* extension[date] ^short = "Date vitals were measured"
* extension[weight] ^short = "Weight (kg)"
* extension[height] ^short = "Height (cm)"
* extension[systolicBloodPressure] ^short = "Systolic blood pressure (mmHg)"
* extension[diastolicBloodPressure] ^short = "Diastolic blood pressure (mmHg)"
* extension[heartRate] ^short = "Heart rate (beats/min)"
* extension[oxygenSaturation] ^short = "Oxygen saturation at rest (%)"
* extension[temperature] ^short = "Body temperature (°C)"

// ================================================
// Example Clinical Variable instance
// ================================================

Instance: ClinicalVariableExample1
InstanceOf: ClinicalVariable
Usage: #example
Title: "Example Clinical Variables"
Description: "Example set of clinical variables for a transplant patient."

* id = "clinical-variable-example-1"

// clinical_variable_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/clinical-variable-id"
* identifier.value = "CV0001"

// REQUIRED: Basic.code
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/clinical-variable-type#vitals "Vital signs"

// patient_id
* extension[patientId].valueReference = Reference(ExamplePatientTransplant1)

// date
* extension[date].valueDate = "2025-01-15"

// weight (kg)
* extension[weight].valueDecimal = 72.5

// height (cm)
* extension[height].valueDecimal = 175.0

// systolic_blood_pressure (mmHg)
* extension[systolicBloodPressure].valueInteger = 120

// diastolic_blood_pressure (mmHg)
* extension[diastolicBloodPressure].valueInteger = 75

// heart_rate (beats/min)
* extension[heartRate].valueInteger = 68

// oxygen_saturation (%)
* extension[oxygenSaturation].valueInteger = 98

// temperature (°C)
* extension[temperature].valueInteger = 37