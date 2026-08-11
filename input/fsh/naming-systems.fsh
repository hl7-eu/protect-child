// ================================================
// Identifier NamingSystems for PROTECT-CHILD entity IDs
// One per DMv1.2 table primary key; referenced as identifier.system in the profiles.
// ================================================

Instance: NsBioSampleId
InstanceOf: NamingSystem
Usage: #definition
Title: "BioSample identifier namespace"
Description: "Identifier namespace for BioSample (Specimen) resources in PROTECT-CHILD."
* name = "ProtectChildBioSampleId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/biosample-id"
* uniqueId[0].preferred = true

Instance: NsClinicalEventId
InstanceOf: NamingSystem
Usage: #definition
Title: "ClinicalEvent identifier namespace"
Description: "Identifier namespace for ClinicalEvent (Condition) resources in PROTECT-CHILD."
* name = "ProtectChildClinicalEventId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/clinical-event-id"
* uniqueId[0].preferred = true

Instance: NsClinicalVariableId
InstanceOf: NamingSystem
Usage: #definition
Title: "ClinicalVariable identifier namespace"
Description: "Identifier namespace for ClinicalVariable (Observation) resources in PROTECT-CHILD."
* name = "ProtectChildClinicalVariableId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/clinical-variable-id"
* uniqueId[0].preferred = true

Instance: NsConcomitantMedicationId
InstanceOf: NamingSystem
Usage: #definition
Title: "ConcomitantMedication identifier namespace"
Description: "Identifier namespace for ConcomitantMedication (MedicationStatement) resources in PROTECT-CHILD."
* name = "ProtectChildConcomitantMedicationId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/concomitant-medication-id"
* uniqueId[0].preferred = true

Instance: NsImmPatId
InstanceOf: NamingSystem
Usage: #definition
Title: "ImmPat identifier namespace"
Description: "Identifier namespace for ImmPat (MedicationStatement) resources in PROTECT-CHILD."
* name = "ProtectChildImmPatId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/imm-pat-id"
* uniqueId[0].preferred = true

Instance: NsImmunologicalDataId
InstanceOf: NamingSystem
Usage: #definition
Title: "ImmunologicalData identifier namespace"
Description: "Identifier namespace for ImmunologicalData (Observation) resources in PROTECT-CHILD."
* name = "ProtectChildImmunologicalDataId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunological-data-id"
* uniqueId[0].preferred = true

Instance: NsImmunosuppressantId
InstanceOf: NamingSystem
Usage: #definition
Title: "Immunosuppressant identifier namespace"
Description: "Identifier namespace for Immunosuppressant (Medication) resources in PROTECT-CHILD."
* name = "ProtectChildImmunosuppressantId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/immunosuppressant-id"
* uniqueId[0].preferred = true

Instance: NsInstrumentalInvestigationId
InstanceOf: NamingSystem
Usage: #definition
Title: "InstrumentalInvestigation identifier namespace"
Description: "Identifier namespace for PatientInstrumentalInvestigation (Observation) resources in PROTECT-CHILD."
* name = "ProtectChildInstrumentalInvestigationId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/instrumental-investigation-id"
* uniqueId[0].preferred = true

Instance: NsLabResultId
InstanceOf: NamingSystem
Usage: #definition
Title: "LabResult identifier namespace"
Description: "Identifier namespace for LabResultObservation (Observation) resources in PROTECT-CHILD."
* name = "ProtectChildLabResultId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/lab-result-id"
* uniqueId[0].preferred = true

Instance: NsLabTestId
InstanceOf: NamingSystem
Usage: #definition
Title: "LabTest identifier namespace"
Description: "Identifier namespace for LabTest (ObservationDefinition) resources in PROTECT-CHILD."
* name = "ProtectChildLabTestId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/lab-test-id"
* uniqueId[0].preferred = true

Instance: NsMicrobiologyId
InstanceOf: NamingSystem
Usage: #definition
Title: "Microbiology identifier namespace"
Description: "Identifier namespace for Microbiology (Observation) resources in PROTECT-CHILD."
* name = "ProtectChildMicrobiologyId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/microbiology-id"
* uniqueId[0].preferred = true

Instance: NsPreMedicationId
InstanceOf: NamingSystem
Usage: #definition
Title: "PreMedication identifier namespace"
Description: "Identifier namespace for PreMedication (MedicationStatement) resources in PROTECT-CHILD."
* name = "ProtectChildPreMedicationId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/pre-medication-id"
* uniqueId[0].preferred = true

Instance: NsVitalSignId
InstanceOf: NamingSystem
Usage: #definition
Title: "VitalSign identifier namespace"
Description: "Identifier namespace for VitalSign (Observation) resources in PROTECT-CHILD."
* name = "ProtectChildVitalSignId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/vital-sign-id"
* uniqueId[0].preferred = true
