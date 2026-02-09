// ================================================
// Immunosuppressive Maintenance to Patient
// ================================================

// ------------------------------------------------------
// Type of Basic resource (for Basic.code)
// ------------------------------------------------------

CodeSystem: ImmunosuppressiveMaintenanceTypeCS
Id: immunosuppressive-maintenance-type-cs
Title: "Immunosuppressive Maintenance to Patient Type CodeSystem"
Description: "Type of immunosuppressive maintenance record."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunosuppressive-maintenance-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #maintenance-to-patient "Immunosuppressive maintenance therapy to patient"

ValueSet: ImmunosuppressiveMaintenanceTypeVS
Id: immunosuppressive-maintenance-type-vs
Title: "Immunosuppressive Maintenance to Patient Type ValueSet"
Description: "Allowed types for immunosuppressive maintenance records."
* ImmunosuppressiveMaintenanceTypeCS#maintenance-to-patient

// ------------------------------------------------------
// Extensions
// ------------------------------------------------------

// patient_id – Reference(PatientTransplant)
Extension: ImmunosuppressiveMaintenancePatientRef
Id: immunosuppressive-maintenance-patient-ref
Title: "Recipient patient reference"
Description: "patient_id – reference to the transplant recipient for whom maintenance therapy is recorded."
* value[x] only Reference(PatientTransplant)
* valueReference 1..1

// immunosuppressant_id – Reference(Immunosuppressant)
Extension: ImmunosuppressiveMaintenanceImmunosuppressantRef
Id: immunosuppressive-maintenance-immunosuppressant-ref
Title: "Immunosuppressant ID relationship"
Description: "immunosuppressant_id – reference to the immunosuppressant drug used for maintenance."
* value[x] only Reference(Immunosuppressant)
* valueReference 1..1

// dose – decimal
Extension: ImmunosuppressiveMaintenanceDose
Id: immunosuppressive-maintenance-dose
Title: "Dose of immunosuppressant"
Description: "dose – maintenance dose of the immunosuppressant."
* value[x] only Quantity
* valueQuantity 1..1
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org" (exactly)
* valueQuantity.code 1..1
* valueQuantity.unit 0..1

// pre_dose_level – drug level before dose (e.g., trough level)
Extension: ImmunosuppressiveMaintenancePreDoseLevel
Id: immunosuppressive-maintenance-pre-dose-level
Title: "Pre-dose drug level"
Description: "pre_dose_level – drug level measured immediately before dosing (trough level)."
* value[x] only Quantity
* valueQuantity 1..1
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org" (exactly)
* valueQuantity.code 1..1
* valueQuantity.unit 0..1

// csa2h_post_dose_level – drug level 2 hours post dose (e.g., cyclosporine C2)
Extension: ImmunosuppressiveMaintenanceCsa2hPostDoseLevel
Id: immunosuppressive-maintenance-csa2h-post-dose-level
Title: "2h post-dose drug level (C2)"
Description: "csa2h_post_dose_level – drug level measured 2 hours after dosing (commonly cyclosporine C2)."
* value[x] only Quantity
* valueQuantity 1..1
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org" (exactly)
* valueQuantity.code 1..1
* valueQuantity.unit 0..1

// auc – area under the concentration–time curve
Extension: ImmunosuppressiveMaintenanceAUC
Id: immunosuppressive-maintenance-auc
Title: "Area under the concentration–time curve (AUC)"
Description: "auc – pharmacokinetic area under the curve for the immunosuppressant."
* value[x] only Quantity
* valueQuantity 1..1
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org" (exactly)
* valueQuantity.code 1..1
* valueQuantity.unit 0..1


// (optional) start_date
Extension: ImmunosuppressiveMaintenanceStartDate
Id: immunosuppressive-maintenance-start-date
Title: "Start date of maintenance therapy"
Description: "Date when this maintenance immunosuppressant regimen was started."
* value[x] only date
* valueDate 1..1

// (optional) end_date
Extension: ImmunosuppressiveMaintenanceEndDate
Id: immunosuppressive-maintenance-end-date
Title: "End date of maintenance therapy"
Description: "Date when this maintenance immunosuppressant regimen was stopped (if applicable)."
* value[x] only date
* valueDate 1..1

// ------------------------------------------------------
// Profile on Basic
// ------------------------------------------------------

Profile: ImmunosuppressiveMaintenancePatient
Parent: Basic
Id: immunosuppressive-maintenance-patient
Title: "Immunosuppressive Maintenance to Patient"
Description: "Maintenance immunosuppressive therapy given to the transplant patient, aligned with the immunosuppressive_maintenance_patient table."

// imm_main_pat_id → Basic.identifier (Mandatory)
* identifier 1..1 MS
* identifier ^short = "imm_main_pat_id – identifier of the immunosuppressive maintenance record"
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunosuppressive-maintenance-patient-id" (exactly)
* identifier.value 1..1

// Basic.code – type of Basic
* code 1..1 MS
* code ^short = "Type of immunosuppressive maintenance record"
* code ^binding.strength = #required
* code ^binding.valueSet = Canonical(ImmunosuppressiveMaintenanceTypeVS)

// Attach extensions with DM variable names as slice names
* extension contains ImmunosuppressiveMaintenancePatientRef named patient_id 1..1 MS
* extension contains ImmunosuppressiveMaintenanceImmunosuppressantRef named immunosuppressant_id 1..1 MS
* extension contains ImmunosuppressiveMaintenanceDose named dose 1..1 MS
* extension contains ImmunosuppressiveMaintenancePreDoseLevel named pre_dose_level 0..1 MS
* extension contains ImmunosuppressiveMaintenanceCsa2hPostDoseLevel named csa2h_post_dose_level 0..1 MS
* extension contains ImmunosuppressiveMaintenanceAUC named auc 0..1 MS
* extension contains ImmunosuppressiveMaintenanceStartDate named start_date 0..1 MS
* extension contains ImmunosuppressiveMaintenanceEndDate named end_date 0..1 MS

* extension[patient_id] ^short = "patient_id – reference to PatientTransplant"
* extension[immunosuppressant_id] ^short = "immunosuppressant_id – reference to Immunosuppressant"
* extension[dose] ^short = "dose – maintenance dose of the immunosuppressant"
* extension[pre_dose_level] ^short = "pre_dose_level – drug level before dosing (trough)"
* extension[csa2h_post_dose_level] ^short = "csa2h_post_dose_level – drug level 2 hours after dosing (C2)"
* extension[auc] ^short = "auc – area under the concentration–time curve"
* extension[start_date] ^short = "start_date – date maintenance therapy started"
* extension[end_date] ^short = "end_date – date maintenance therapy stopped"

// ------------------------------------------------------
// Example instance
// ------------------------------------------------------

Instance: ImmunosuppressiveMaintenancePatientExample1
InstanceOf: ImmunosuppressiveMaintenancePatient
Usage: #example
Title: "Example Immunosuppressive Maintenance to Patient"
Description: "Example record of maintenance immunosuppressive therapy for a transplant recipient."

* id = "immunosuppressive-maintenance-patient-example-1"

// imm_main_pat_id
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunosuppressive-maintenance-patient-id"
* identifier.value = "IMMPAT0001"

// Basic.code – type
* code = https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/immunosuppressive-maintenance-type#maintenance-to-patient
* code.text = "Immunosuppressive maintenance therapy to patient"

// patient_id
* extension[patient_id].valueReference = Reference(ExamplePatientTransplant1)

// immunosuppressant_id – example immunosuppressant
* extension[immunosuppressant_id].valueReference = Reference(ImmunosuppressantExample1)

// dose
* extension[dose].valueQuantity.value = 2.0
* extension[dose].valueQuantity.system = "http://unitsofmeasure.org"
* extension[dose].valueQuantity.code = #mg.kg-1
* extension[dose].valueQuantity.unit = "mg/kg"


// pre_dose_level (example trough)
* extension[pre_dose_level].valueQuantity.value = 120
* extension[pre_dose_level].valueQuantity.system = "http://unitsofmeasure.org"
* extension[pre_dose_level].valueQuantity.code = #ng.mL-1
* extension[pre_dose_level].valueQuantity.unit = "ng/mL"

// csa2h_post_dose_level (example C2)
* extension[csa2h_post_dose_level].valueQuantity.value = 800
* extension[csa2h_post_dose_level].valueQuantity.system = "http://unitsofmeasure.org"
* extension[csa2h_post_dose_level].valueQuantity.code = #ng.mL-1
* extension[csa2h_post_dose_level].valueQuantity.unit = "ng/mL"

// auc (example)
* extension[auc].valueQuantity.value = 4500
* extension[auc].valueQuantity.system = "http://unitsofmeasure.org"
* extension[auc].valueQuantity.code = #ng.h.mL-1
* extension[auc].valueQuantity.unit = "ng·h/mL"


// start_date / end_date
* extension[start_date].valueDate = "2024-04-01"
* extension[end_date].valueDate = "2024-10-01"
