// ================================================
// Identifier NamingSystem for PROTECT-CHILD entity IDs
// A single namespace for all business identifiers on PROTECT-CHILD records;
// the FHIR resource type distinguishes what each identifier refers to.
// (StudyCentre uses its own centre-code system.)
// ================================================

Instance: NsProtectChildId
InstanceOf: NamingSystem
Usage: #definition
Title: "PROTECT-CHILD identifier namespace"
Description: "Single identifier namespace for PROTECT-CHILD record business identifiers (patient, donor, visit, transplant, and all per-visit clinical/lab/medication/specimen/event records). The resource type distinguishes the kind of record. Identifiers follow one convention: TOKEN-CENTRE-SEQUENCE, for example REC-1-0001 (patient, centre 1, sequence 1) or LBR-1-0006 (lab result); study-wide catalogue entries such as lab tests are not centre-qualified and use TOKEN-SEQUENCE, for example LBT-0001. Identifiers carry no clinical meaning."
// Identifier convention
// TOKEN-CENTRE-SEQUENCE, e.g. REC-1-0001, VIS-1-0002, LBR-1-0006:
//   TOKEN     three letters for the data-model table
//   CENTRE    center_no (1-4) of the recruiting site — this is what keeps
//             identifiers unique when each site assigns its own sequences
//   SEQUENCE  four digits, assigned within that centre
// Tokens: REC patient, DON donor, VIS visit, TXP transplant, IMD immunological_data,
//   BIO bio_sample, PRM pre_medication, CLV clinical_variable, VIT vital_sign,
//   CMD concomitant_medication, MIC microbiology, IIV instrumental investigation performed,
//   IMP imm_pat, LBR lab_result, CLE clinical_event.
// Study-wide catalogue entries are not centre-qualified and use TOKEN-SEQUENCE:
//   LBT lab_test, INS instrumental_investigation type, IMM immunosuppressant,
//   CET clinical_event_type.
// Identifiers carry no clinical meaning: the kind of event, the phase of treatment
// and the analyte live in the resource's own coded elements, not in its identifier.
* name = "ProtectChildId"
* status = #draft
* kind = #identifier
* date = "2025-01-01"
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.eu/fhir/ig/hl7.eu.fhir.protect-child/NamingSystem/protect-child-id"
* uniqueId[0].preferred = true
