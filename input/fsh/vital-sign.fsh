// ================================================
// VitalSign — vital_sign table
// Observation panel (vital-signs category)
// ================================================

Alias: $loinc   = http://loinc.org
Alias: $ucum    = http://unitsofmeasure.org
Alias: $obs-cat = http://terminology.hl7.org/CodeSystem/observation-category

// ================================================
// Local codes for ABPM metrics with no LOINC equivalent
// (sbp_load, dbp_load, sbp_dip, dbp_dip)
// ================================================

CodeSystem: VitalSignLocalCS
Id: vital-sign-local-cs
Title: "Vital Sign Local Codes"
Description: "Local codes for ABPM-derived metrics that have no published LOINC code: systolic/diastolic blood pressure load and nocturnal dip percentages."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/vital-sign-local"
* ^content = #complete
* ^caseSensitive = true
* ^experimental = true
* #sbp-load "Systolic blood pressure load (%)"
* #dbp-load "Diastolic blood pressure load (%)"
* #sbp-dip  "Systolic blood pressure nocturnal dip (%)"
* #dbp-dip  "Diastolic blood pressure nocturnal dip (%)"

// ================================================
// Profile: VitalSign — Observation panel
// ================================================

Profile: VitalSign
Parent: Observation
Id: vital-sign
Title: "Vital Sign"
Description: "Vital signs panel for a transplant patient at a visit, aligned with the DMv1.2 vital_sign table. Captures standard vitals plus ABPM (24-hour ambulatory blood pressure) metrics."

// vital_sign_id → Observation.identifier (M)
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/vital-sign-id" (exactly)
* identifier.value 1..1
* identifier ^short = "vital_sign_id"

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#vital-signs (exactly)

// Panel code — vital signs panel
* code 1..1 MS
* code = $loinc#85353-1 "Vital signs, weight, height, head circumference, oxygen saturation and BMI panel" (exactly)
* code ^short = "Vital signs panel"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient"

// visit_id → Observation.encounter (M)
* encounter 1..1 MS
* encounter only Reference(Visit)
* encounter ^short = "visit_id — Visit at which vitals were measured"

// date → Observation.effectiveDateTime (M)
* effective[x] 1..1 MS
* effective[x] only dateTime
* effectiveDateTime ^short = "date — date when vitals were measured"

// ------------------------------------------------
// Components
// ------------------------------------------------

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component MS

// systolic_blood_pressure (mmHg)
* component contains systolic_bp 0..1 MS
* component[systolic_bp].code = $loinc#8480-6 "Systolic blood pressure" (exactly)
* component[systolic_bp].value[x] only Quantity
* component[systolic_bp].valueQuantity.system = $ucum
* component[systolic_bp].valueQuantity.code = #mm[Hg]
* component[systolic_bp] ^short = "systolic_blood_pressure (mmHg)"

// diastolic_blood_pressure (mmHg)
* component contains diastolic_bp 0..1 MS
* component[diastolic_bp].code = $loinc#8462-4 "Diastolic blood pressure" (exactly)
* component[diastolic_bp].value[x] only Quantity
* component[diastolic_bp].valueQuantity.system = $ucum
* component[diastolic_bp].valueQuantity.code = #mm[Hg]
* component[diastolic_bp] ^short = "diastolic_blood_pressure (mmHg)"

// heart_rate (bpm)
* component contains heart_rate 0..1 MS
* component[heart_rate].code = $loinc#8867-4 "Heart rate" (exactly)
* component[heart_rate].value[x] only Quantity
* component[heart_rate].valueQuantity.system = $ucum
* component[heart_rate].valueQuantity.code = #/min
* component[heart_rate] ^short = "heart_rate (bpm)"

// oxygen_saturation (%)
* component contains oxygen_saturation 0..1 MS
* component[oxygen_saturation].code = $loinc#59408-5 "Oxygen saturation in Arterial blood by Pulse oximetry" (exactly)
* component[oxygen_saturation].value[x] only Quantity
* component[oxygen_saturation].valueQuantity.system = $ucum
* component[oxygen_saturation].valueQuantity.code = #%
* component[oxygen_saturation] ^short = "oxygen_saturation (%)"

// temperature (°C)
* component contains temperature 0..1 MS
* component[temperature].code = $loinc#8310-5 "Body temperature" (exactly)
* component[temperature].value[x] only Quantity
* component[temperature].valueQuantity.system = $ucum
* component[temperature].valueQuantity.code = #Cel
* component[temperature] ^short = "temperature (°C)"

// bmi
* component contains bmi 0..1 MS
* component[bmi].code = $loinc#39156-5 "Body mass index (BMI) [Ratio]" (exactly)
* component[bmi].value[x] only Quantity
* component[bmi].valueQuantity.system = $ucum
* component[bmi].valueQuantity.code = #kg/m2
* component[bmi] ^short = "bmi (kg/m²)"

// sbp_percentile
* component contains sbp_percentile 0..1 MS
* component[sbp_percentile].code = $loinc#59574-4 "Systolic blood pressure percentile" (exactly)
* component[sbp_percentile].value[x] only integer
* component[sbp_percentile] ^short = "sbp_percentile — systolic BP percentile"

// dbp_percentile
* component contains dbp_percentile 0..1 MS
* component[dbp_percentile].code = $loinc#59575-1 "Diastolic blood pressure percentile" (exactly)
* component[dbp_percentile].value[x] only integer
* component[dbp_percentile] ^short = "dbp_percentile — diastolic BP percentile"

// ABPM — mean_sbp_24
* component contains mean_sbp_24 0..1 MS
* component[mean_sbp_24].code = $loinc#8490-5 "Systolic blood pressure 24 hour mean" (exactly)
* component[mean_sbp_24].value[x] only Quantity
* component[mean_sbp_24].valueQuantity.system = $ucum
* component[mean_sbp_24].valueQuantity.code = #mm[Hg]
* component[mean_sbp_24] ^short = "mean_sbp_24 — 24h mean systolic BP (mmHg)"

// ABPM — mean_dbp_24
* component contains mean_dbp_24 0..1 MS
* component[mean_dbp_24].code = $loinc#8472-3 "Diastolic blood pressure 24 hour mean" (exactly)
* component[mean_dbp_24].value[x] only Quantity
* component[mean_dbp_24].valueQuantity.system = $ucum
* component[mean_dbp_24].valueQuantity.code = #mm[Hg]
* component[mean_dbp_24] ^short = "mean_dbp_24 — 24h mean diastolic BP (mmHg)"

// ABPM — mean_sbp_day
* component contains mean_sbp_day 0..1 MS
* component[mean_sbp_day].code = $loinc#8484-8 "Systolic blood pressure --day average" (exactly)
* component[mean_sbp_day].value[x] only Quantity
* component[mean_sbp_day].valueQuantity.system = $ucum
* component[mean_sbp_day].valueQuantity.code = #mm[Hg]
* component[mean_sbp_day] ^short = "mean_sbp_day — daytime mean systolic BP (mmHg)"

// ABPM — mean_dbp_day
* component contains mean_dbp_day 0..1 MS
* component[mean_dbp_day].code = $loinc#8466-5 "Diastolic blood pressure --day average" (exactly)
* component[mean_dbp_day].value[x] only Quantity
* component[mean_dbp_day].valueQuantity.system = $ucum
* component[mean_dbp_day].valueQuantity.code = #mm[Hg]
* component[mean_dbp_day] ^short = "mean_dbp_day — daytime mean diastolic BP (mmHg)"

// ABPM — mean_sbp_night
* component contains mean_sbp_night 0..1 MS
* component[mean_sbp_night].code = $loinc#8489-7 "Systolic blood pressure --night average" (exactly)
* component[mean_sbp_night].value[x] only Quantity
* component[mean_sbp_night].valueQuantity.system = $ucum
* component[mean_sbp_night].valueQuantity.code = #mm[Hg]
* component[mean_sbp_night] ^short = "mean_sbp_night — night-time mean systolic BP (mmHg)"

// ABPM — mean_dbp_night
* component contains mean_dbp_night 0..1 MS
* component[mean_dbp_night].code = $loinc#8471-5 "Diastolic blood pressure --night average" (exactly)
* component[mean_dbp_night].value[x] only Quantity
* component[mean_dbp_night].valueQuantity.system = $ucum
* component[mean_dbp_night].valueQuantity.code = #mm[Hg]
* component[mean_dbp_night] ^short = "mean_dbp_night — night-time mean diastolic BP (mmHg)"

// sbp_load (%) — local code (no LOINC equivalent)
* component contains sbp_load 0..1 MS
* component[sbp_load].code = VitalSignLocalCS#sbp-load "Systolic blood pressure load (%)" (exactly)
* component[sbp_load].value[x] only Quantity
* component[sbp_load].valueQuantity.system = $ucum
* component[sbp_load].valueQuantity.code = #%
* component[sbp_load] ^short = "sbp_load — systolic BP load (%)"

// dbp_load (%) — local code (no LOINC equivalent)
* component contains dbp_load 0..1 MS
* component[dbp_load].code = VitalSignLocalCS#dbp-load "Diastolic blood pressure load (%)" (exactly)
* component[dbp_load].value[x] only Quantity
* component[dbp_load].valueQuantity.system = $ucum
* component[dbp_load].valueQuantity.code = #%
* component[dbp_load] ^short = "dbp_load — diastolic BP load (%)"

// sbp_dip (%) — local code (no LOINC equivalent)
* component contains sbp_dip 0..1 MS
* component[sbp_dip].code = VitalSignLocalCS#sbp-dip "Systolic blood pressure nocturnal dip (%)" (exactly)
* component[sbp_dip].value[x] only Quantity
* component[sbp_dip].valueQuantity.system = $ucum
* component[sbp_dip].valueQuantity.code = #%
* component[sbp_dip] ^short = "sbp_dip — systolic BP nocturnal dip (%)"

// dbp_dip (%) — local code (no LOINC equivalent)
* component contains dbp_dip 0..1 MS
* component[dbp_dip].code = VitalSignLocalCS#dbp-dip "Diastolic blood pressure nocturnal dip (%)" (exactly)
* component[dbp_dip].value[x] only Quantity
* component[dbp_dip].valueQuantity.system = $ucum
* component[dbp_dip].valueQuantity.code = #%
* component[dbp_dip] ^short = "dbp_dip — diastolic BP nocturnal dip (%)"


// ================================================
// Example
// ================================================

Instance: VitalSignExample1
InstanceOf: VitalSign
Usage: #example
Title: "Example Vital Sign"
Description: "Example vital signs panel for a transplant recipient at 1-month visit."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/vital-sign-id"
* identifier.value = "VS-001"
* status = #final
* category = $obs-cat#vital-signs
* code = $loinc#85353-1 "Vital signs, weight, height, head circumference, oxygen saturation and BMI panel"
* subject = Reference(ExamplePatientTransplant1)
* encounter = Reference(VisitExample1)
* effectiveDateTime = "2023-09-15"

* component[systolic_bp].valueQuantity.value = 118
* component[systolic_bp].valueQuantity.system = $ucum
* component[systolic_bp].valueQuantity.code = #mm[Hg]
* component[systolic_bp].valueQuantity.unit = "mmHg"

* component[diastolic_bp].valueQuantity.value = 75
* component[diastolic_bp].valueQuantity.system = $ucum
* component[diastolic_bp].valueQuantity.code = #mm[Hg]
* component[diastolic_bp].valueQuantity.unit = "mmHg"

* component[heart_rate].valueQuantity.value = 72
* component[heart_rate].valueQuantity.system = $ucum
* component[heart_rate].valueQuantity.code = #/min
* component[heart_rate].valueQuantity.unit = "bpm"

* component[temperature].valueQuantity.value = 36.7
* component[temperature].valueQuantity.system = $ucum
* component[temperature].valueQuantity.code = #Cel
* component[temperature].valueQuantity.unit = "°C"

* component[bmi].valueQuantity.value = 17.4
* component[bmi].valueQuantity.system = $ucum
* component[bmi].valueQuantity.code = #kg/m2
* component[bmi].valueQuantity.unit = "kg/m²"
