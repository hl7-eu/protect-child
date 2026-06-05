// ================================================
// Immunosuppressant to Patient (imm_pat)
// MedicationStatement + linked PK Observations
// ================================================

Alias: $obs-cat = http://terminology.hl7.org/CodeSystem/observation-category

// ------------------------------------------------
// Terminology – phase (Induction / Maintenance)
// ------------------------------------------------

CodeSystem: ImmPatPhaseCS
Id: imm-pat-phase-cs
Title: "Immunosuppressant Phase CodeSystem"
Description: "Whether the immunosuppressant record is for induction or maintenance phase (DMv1.2). Used as MedicationStatement.category codes."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/imm-pat-phase"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #induction    "Induction"
* #maintenance  "Maintenance"

ValueSet: ImmPatPhaseVS
Id: imm-pat-phase-vs
Title: "Immunosuppressant Phase ValueSet"
Description: "Allowed phase values for MedicationStatement.category on ImmPat records."
* ImmPatPhaseCS#induction
* ImmPatPhaseCS#maintenance

// ------------------------------------------------
// Terminology – PK observation types
// Codes for ImmPatPKObservation.code — one per DM field:
// pre_dose_level, csa_2h_post_dose_level, auc.
// ------------------------------------------------

CodeSystem: ImmPatPKTypeCS
Id: imm-pat-pk-type-cs
Title: "Immunosuppressant PK Observation Type CodeSystem"
Description: "Types of pharmacokinetic monitoring observations for immunosuppressant therapy (DMv1.2 pre_dose_level, csa_2h_post_dose_level, auc)."
* ^url = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/CodeSystem/imm-pat-pk-type"
* ^content = #complete
* ^caseSensitive = false
* ^experimental = true
* #pre-dose-level     "Pre-dose drug level (trough / C0)"
* #post-dose-2h-level "2 h post-dose drug level (C2)"
* #auc                "Pharmacokinetic AUC"

ValueSet: ImmPatPKTypeVS
Id: imm-pat-pk-type-vs
Title: "Immunosuppressant PK Observation Type ValueSet"
Description: "Allowed PK observation types for ImmPatPKObservation."
* ImmPatPKTypeCS#pre-dose-level
* ImmPatPKTypeCS#post-dose-2h-level
* ImmPatPKTypeCS#auc

// ------------------------------------------------
// Terminology – dose unit (unit field in imm_pat table)
// DM values: mg/kg, mg/m², mg, mg/mq (mg/mq = mg/m² in Italian notation)
// ------------------------------------------------

ValueSet: ImmPatDoseUnitVS
Id: imm-pat-dose-unit-vs
Title: "Immunosuppressant Dose Unit ValueSet"
Description: "Allowed UCUM dose units for immunosuppressant therapy records (DMv1.2 imm_pat.unit field)."
* ^experimental = true
* http://unitsofmeasure.org#mg.kg-1    "mg/kg"
* http://unitsofmeasure.org#mg.m-2     "mg/m²"
* http://unitsofmeasure.org#mg         "mg"

// ================================================
// Profile: ImmPat — MedicationStatement
// ================================================

Profile: ImmPat
Parent: MedicationStatement
Id: imm-pat
Title: "Immunosuppressant to Patient"
Description: "Immunosuppressive treatment record for a transplant patient (induction or maintenance), aligned with the DMv1.2 imm_pat table. Covers both induction and maintenance phases via MedicationStatement.category. Patient is navigable via context (Visit) → Visit.subject. Pharmacokinetic monitoring values (pre_dose_level, csa_2h_post_dose_level, auc) are represented as linked ImmPatPKObservation resources via Observation.partOf."

// imm_pat_id → MedicationStatement.identifier (M)
* identifier 1..1 MS
* identifier.system 1..1
* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/imm-pat-id" (exactly)
* identifier.value 1..1
* identifier ^short = "imm_pat_id — treatment record identifier"

// imm_id → MedicationStatement.medication[x]
* medication[x] only Reference(Immunosuppressant)
* medicationReference 1..1 MS
* medicationReference ^short = "imm_id — reference to the Immunosuppressant drug catalogue entry"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient (navigate via context → Visit.subject)"

* status 1..1 MS
* status ^short = "Use #active for ongoing therapy, #completed for finished regimens"

// visit_id → MedicationStatement.context
* context 1..1 MS
* context only Reference(Visit)
* context ^short = "visit_id — Visit at which this treatment was recorded"

// start_date / end_date → MedicationStatement.effectivePeriod
* effective[x] 0..1 MS
* effectivePeriod.start 0..1
* effectivePeriod.start ^short = "start_date — date treatment started"
* effectivePeriod.end 0..1
* effectivePeriod.end ^short = "end_date — date treatment ended"

// dose + unit → MedicationStatement.dosage.doseAndRate.doseQuantity
* dosage 0..1 MS
* dosage.doseAndRate 0..1 MS
* dosage.doseAndRate.doseQuantity 0..1 MS
* dosage.doseAndRate.doseQuantity.system 0..1
* dosage.doseAndRate.doseQuantity.system = "http://unitsofmeasure.org"
* dosage.doseAndRate.doseQuantity.code 0..1
* dosage.doseAndRate.doseQuantity.code from ImmPatDoseUnitVS (required)
* dosage.doseAndRate.doseQuantity ^short = "dose + unit — numeric dose with UCUM unit from ImmPatDoseUnitVS"

* category 1..1 MS
* category from ImmPatPhaseVS (required)
* category ^short = "phase — Induction or Maintenance (ImmPatPhaseVS)"

// ================================================
// Invariant for ImmPatPKObservation
// ================================================

Invariant: pc-pk-1
Description: "A PK observation SHALL have either a value[x] or a dataAbsentReason, but not both."
Severity: #error
Expression: "value.exists() xor dataAbsentReason.exists()"

// ================================================
// Profile: ImmPatPKObservation
// Pharmacokinetic monitoring result linked to ImmPat via Observation.partOf
// ================================================

Profile: ImmPatPKObservation
Parent: Observation
Id: imm-pat-pk-observation
Title: "Immunosuppressant PK Observation"
Description: "Pharmacokinetic monitoring result (pre-dose trough level, 2 h post-dose level / C2, or AUC) for an immunosuppressant therapy record. Linked to the parent ImmPat MedicationStatement via Observation.partOf. Use Observation.subject to carry the patient directly for FHIR searchability."

// Link to parent ImmPat record (M)
* partOf 1..1 MS
* partOf only Reference(ImmPat)
* partOf ^short = "Reference to the ImmPat MedicationStatement this PK measurement belongs to"

* status 1..1 MS
* status = #final (exactly)

* category 1..1 MS
* category = $obs-cat#laboratory (exactly)

// PK measurement type — identifies which DM field this Observation represents
* code 1..1 MS
* code from ImmPatPKTypeVS (required)
* code ^short = "PK type — pre-dose level (#pre-dose-level), C2 (#post-dose-2h-level), or AUC (#auc)"

* subject 1..1 MS
* subject only Reference(PatientTransplant)
* subject ^short = "Transplant recipient (required for FHIR searchability)"

* effective[x] 0..1 MS

// Measured value — Quantity with a UCUM unit.
// When a PK value is unavailable (e.g. below detection limit, not assayed),
// value[x] SHALL be absent and dataAbsentReason SHALL be populated instead.
// Invariant pc-pk-1 enforces that exactly one of the two is present.
* obeys pc-pk-1
* value[x] 0..1 MS
* value[x] only Quantity
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org" (exactly)
* valueQuantity.value 0..1
* valueQuantity ^short = "Measured PK value with UCUM unit (e.g. ng/mL for drug levels, h.mg/L for AUC)"

// dataAbsentReason — required when value[x] is absent
* dataAbsentReason 0..1 MS
* dataAbsentReason ^short = "Reason PK value is missing (e.g. not-performed, below-detection-limit)"

// ================================================
// Examples
// ================================================

Instance: ImmPatInductionExample1
InstanceOf: ImmPat
Usage: #example
Title: "Example Immunosuppressant to Patient — Induction"
Description: "Example induction immunosuppressant record (methylprednisolone) at time of transplant."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/imm-pat-id"
* identifier.value = "IMMPAT-IND-001"
* status = #completed
* subject = Reference(ExamplePatientTransplant1)
* medicationReference = Reference(ImmunosuppressantExample1)
* context = Reference(VisitExample1)
* category = ImmPatPhaseCS#induction "Induction"
* effectivePeriod.start = "2023-08-15"
* effectivePeriod.end = "2023-08-15"
* dosage.doseAndRate.doseQuantity.value = 0.15
* dosage.doseAndRate.doseQuantity.system = "http://unitsofmeasure.org"
* dosage.doseAndRate.doseQuantity.code = #mg.kg-1
* dosage.doseAndRate.doseQuantity.unit = "mg/kg"

Instance: ImmPatMaintenanceExample1
InstanceOf: ImmPat
Usage: #example
Title: "Example Immunosuppressant to Patient — Maintenance"
Description: "Example maintenance immunosuppressant record (tacrolimus) at 1-month visit. PK monitoring values are separate ImmPatPKObservation resources linked via Observation.partOf."

* identifier.system = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/imm-pat-id"
* identifier.value = "IMMPAT-MAIN-001"
* status = #active
* subject = Reference(ExamplePatientTransplant1)
* medicationReference = Reference(ImmunosuppressantExample1)
* context = Reference(VisitExample1)
* category = ImmPatPhaseCS#maintenance "Maintenance"
* effectivePeriod.start = "2023-09-15"
* dosage.doseAndRate.doseQuantity.value = 0.1
* dosage.doseAndRate.doseQuantity.system = "http://unitsofmeasure.org"
* dosage.doseAndRate.doseQuantity.code = #mg.kg-1
* dosage.doseAndRate.doseQuantity.unit = "mg/kg"

Instance: ImmPatPKObservationExample1
InstanceOf: ImmPatPKObservation
Usage: #example
Title: "Example ImmPat PK Observation — Pre-dose level"
Description: "Tacrolimus trough level (C0) linked to the maintenance ImmPat record via partOf."

* partOf = Reference(ImmPatMaintenanceExample1)
* status = #final
* category = $obs-cat#laboratory
* code = ImmPatPKTypeCS#pre-dose-level "Pre-dose drug level (trough / C0)"
* subject = Reference(ExamplePatientTransplant1)
* effectiveDateTime = "2023-09-15"
* valueQuantity.value = 8.5
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #ng.mL-1
* valueQuantity.unit = "ng/mL"
