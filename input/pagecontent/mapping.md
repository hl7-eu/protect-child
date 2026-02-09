# Logical model element → FHIR mapping

This page maps **each element** from the PROTECT-CHILD logical models (StructureDefinition kind = `logical`) to the **FHIR profiles/resources** implemented in this IG.

**How to read this table**:
- **Logical element**: element name in the logical model
- **FHIR profile**: the primary FHIR profile where the data is represented
- **FHIR element path**: where the value lives (direct element or `extension[...]` slice)
- Some patient/donor facts are represented as **Observations** grouped in a **PatientObservations List** (see `patient-observations.fsh`).

## Patient logical model

Logical model: <a href="StructureDefinition-pc-patient-lm.html">patient-lm</a>
Primary FHIR profile: <a href="StructureDefinition-patient-transplant.html">patient-transplant</a> (Patient)

<p>Logical model representing the PROTECT-CHILD data model entity `patient`.</p>

<table class="table table-bordered table-striped" xmlns="http://www.w3.org/1999/xhtml">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>patientId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-transplant.html">patient-transplant</a></td>
<td><code>Patient.identifier.value</code></td>
<td>Maps PROTECT-CHILD patient_id.</td>
</tr>
<tr>
<td><code>gender</code></td>
<td><code>0..1</code></td>
<td><code>code</code></td>
<td><a href="StructureDefinition-patient-transplant.html">patient-transplant</a></td>
<td><code>Patient.gender</code></td>
<td></td>
</tr>
<tr>
<td><code>birthdate</code></td>
<td><code>0..1</code></td>
<td><code>date</code></td>
<td><a href="StructureDefinition-patient-transplant.html">patient-transplant</a></td>
<td><code>Patient.birthDate</code></td>
<td></td>
</tr>
<tr>
<td><code>currentAge</code></td>
<td><code>0..1</code></td>
<td><code>integer</code></td>
<td><a href="StructureDefinition-patient-transplant.html">patient-transplant</a></td>
<td><code>(derived)</code></td>
<td>Derived from Patient.birthDate</td>
</tr>
<tr>
<td><code>bloodGroup</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-patient-abo-group-observation.html">patient-abo-group-observation</a></td>
<td><code>Observation.valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>rhFactor</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-patient-rh-factor-observation.html">patient-rh-factor-observation</a></td>
<td><code>Observation.valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>maxPra</code></td>
<td><code>0..1</code></td>
<td><code>integer</code></td>
<td><a href="StructureDefinition-patient-pra-observation.html">patient-pra-observation</a></td>
<td><code>Observation.valueInteger (+ Observation.method = max/last)</code></td>
<td>Integer 0–100.</td>
</tr>
<tr>
<td><code>lastPra</code></td>
<td><code>0..1</code></td>
<td><code>integer</code></td>
<td><a href="StructureDefinition-patient-pra-observation.html">patient-pra-observation</a></td>
<td><code>Observation.valueInteger (+ Observation.method = max/last)</code></td>
<td>Integer 0–100.</td>
</tr>
<tr>
<td><code>allograftHlaClassIAb</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-patient-hla-typing-class-i-observation.html">patient-hla-typing-class-i-observation</a></td>
<td><code>Observation.component</code></td>
<td></td>
</tr>
<tr>
<td><code>allograftHlaClassIiAb</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-patient-hla-typing-class-ii-observation.html">patient-hla-typing-class-ii-observation</a></td>
<td><code>Observation.component</code></td>
<td></td>
</tr>
<tr>
<td><code>dateHistologicalDiag</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-patient-histological-diagnosis-date-observation.html">patient-histological-diagnosis-date-observation</a></td>
<td><code>Observation.valueDateTime</code></td>
<td></td>
</tr>
<tr>
<td><code>dateDiagLiverDisease</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-patient-liver-disease-diagnosis-observation.html">patient-liver-disease-diagnosis-observation</a></td>
<td><code>Observation.effectiveDateTime</code></td>
<td></td>
</tr>
<tr>
<td><code>diagLiverDisease</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-liver-disease-diagnosis-observation.html">patient-liver-disease-diagnosis-observation</a></td>
<td><code>Observation.valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>diagLiverDiseaseExtra</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-liver-disease-diagnosis-observation.html">patient-liver-disease-diagnosis-observation</a></td>
<td><code>Observation.note.text</code></td>
<td></td>
</tr>
<tr>
<td><code>dateDiagRenalDisease</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-patient-renal-disease-diagnosis-observation.html">patient-renal-disease-diagnosis-observation</a></td>
<td><code>Observation.effectiveDateTime</code></td>
<td></td>
</tr>
<tr>
<td><code>diagRenalDisease</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-renal-disease-diagnosis-observation.html">patient-renal-disease-diagnosis-observation</a></td>
<td><code>Observation.valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>diagRenalDiseaseExtra</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-renal-disease-diagnosis-observation.html">patient-renal-disease-diagnosis-observation</a></td>
<td><code>Observation.note.text</code></td>
<td></td>
</tr>
</tbody></table>

## Donor logical model

Logical model: <a href="StructureDefinition-pc-donor-lm.html">donor-lm</a>
Primary FHIR profile: <a href="StructureDefinition-donor.html">donor</a> (Patient)

<p>Logical model representing the PROTECT-CHILD data model entity `donor`.</p>

<table class="table table-bordered table-striped" xmlns="http://www.w3.org/1999/xhtml">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>donorId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-donor.html">donor</a></td>
<td><code>Patient.identifier.value</code></td>
<td>Maps donor_id.</td>
</tr>
<tr>
<td><code>age</code></td>
<td><code>0..1</code></td>
<td><code>integer</code></td>
<td><a href="StructureDefinition-donor.html">donor</a></td>
<td><code>(derived)</code></td>
<td>Derived from Patient.birthDate</td>
</tr>
<tr>
<td><code>type</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-donor.html">donor</a></td>
<td><code>Patient.extension[donorType].valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>liverType</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-donor-liver-type-observation.html">donor-liver-type-observation</a></td>
<td><code>Observation.valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>bloodGroup</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-patient-abo-group-observation.html">patient-abo-group-observation</a></td>
<td><code>Observation.valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>rhFactor</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-patient-rh-factor-observation.html">patient-rh-factor-observation</a></td>
<td><code>Observation.valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>preKtxDialysisType</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-donor-pre-ktx-dialysis-type-observation.html">donor-pre-ktx-dialysis-type-observation</a></td>
<td><code>Observation.valueCodeableConcept</code></td>
<td></td>
</tr>
<tr>
<td><code>allograftHlaClassIAb</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-patient-hla-typing-class-i-observation.html">patient-hla-typing-class-i-observation</a></td>
<td><code>Observation.component</code></td>
<td></td>
</tr>
<tr>
<td><code>allograftHlaClassIiAb</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-patient-hla-typing-class-ii-observation.html">patient-hla-typing-class-ii-observation</a></td>
<td><code>Observation.component</code></td>
<td></td>
</tr>
</tbody></table>

## Visit logical model

Logical model: <a href="StructureDefinition-pc-visit-lm.html">visit-lm</a>
Primary FHIR profile: <a href="StructureDefinition-visit.html">visit</a> (Encounter)

<p>Logical model representing the PROTECT-CHILD data model entity `visit`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>visitId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.subject</code></td>
<td>Reference to PatientTransplant.</td>
</tr>
<tr>
<td><code>transplantId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[transplant_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>bioSampleId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[bio_sample_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>preMedicationId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[pre_medication_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>clinicalVariableId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[clinical_variable_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>concomitantEpisodeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[concomitant_episode_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>microbiologyId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[microbiology_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>patInstInvId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[pat_inst_inv_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>immIndPatId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[imm_ind_pat_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>immMainPatId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[imm_main_pat_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>labResultId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[lab_result_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>postEventId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[post_event_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>outcomeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.extension[outcome_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>date</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.period.start</code></td>
<td></td>
</tr>
<tr>
<td><code>visitType</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-visit.html">visit</a></td>
<td><code>Encounter.type[0]</code></td>
<td></td>
</tr>
</tbody></table>

## Transplant logical model

Logical model: <a href="StructureDefinition-pc-transplant-lm.html">transplant-lm</a>
Primary FHIR profile: <a href="StructureDefinition-transplant.html">transplant</a> (Encounter)

<p>Logical model representing the PROTECT-CHILD data model entity `transplant`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>transplantId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.subject</code></td>
<td>Reference to PatientTransplant.</td>
</tr>
<tr>
<td><code>donorId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[donor_id].valueReference</code></td>
<td>Reference to Donor.</td>
</tr>
<tr>
<td><code>dRWeightRation</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[d_r_weight_ration].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>vesselMismatchDR</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[vessel_mismatch_dr].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>coldIschemiaTime</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[cold_ischemia_time].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>txType</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.type[0]</code></td>
<td></td>
</tr>
<tr>
<td><code>dateTx</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.period.start</code></td>
<td></td>
</tr>
<tr>
<td><code>timeDiagToTx</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[time_diag_to_tx].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>1WarmIschemiaTime</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[1_warm_ischemia_time].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>2WarmIschemiaTime</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[2_warm_ischemia_time].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>vascularAnomalies</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[vascular_anomalies].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>typeSurgicalBiliaryAnastomosis</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[type_surgical_biliary_anastomosis].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>intraoperativeComplications</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[intraoperative_complications].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>intraoperativeComplicationsOther</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[intraoperative_complications_other].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>nephrectomyOriginalKidney</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[nephrectomy_original_kidney].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>kidneySide</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-transplant.html">transplant</a></td>
<td><code>Encounter.extension[kidney_side].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## BioSample logical model

Logical model: <a href="StructureDefinition-pc-bio-sample-lm.html">bio-sample-lm</a>
Primary FHIR profile: <a href="StructureDefinition-biosample.html">biosample</a> (Specimen)

<p>Logical model representing the PROTECT-CHILD data model entity `bio_sample`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>bioSampleId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.subject</code></td>
<td>Reference to PatientTransplant.</td>
</tr>
<tr>
<td><code>genomicTestId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.extension[genomic_test_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>epigenomeStudyId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.extension[epigenome_study_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>methylomicStudyId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.extension[methylomic_study_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>collectionDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.collection.collectedDateTime</code></td>
<td></td>
</tr>
<tr>
<td><code>sendIngemmDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.extension[send_ingemm_date].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>tissueType</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.type</code></td>
<td></td>
</tr>
<tr>
<td><code>dnaConcentration</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-biosample.html">biosample</a></td>
<td><code>Specimen.extension[dna_concentration].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## ReferenceGenome logical model

Logical model: <a href="StructureDefinition-pc-reference-genome-lm.html">reference-genome-lm</a>
Primary FHIR profile: <a href="StructureDefinition-reference-genome.html">reference-genome</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `reference_genome`.</p>

<table class="table table-bordered table-striped" xmlns="http://www.w3.org/1999/xhtml">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>referenceGenomeId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-reference-genome.html">reference-genome</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>buildName</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-reference-genome.html">reference-genome</a></td>
<td><code>Basic.code</code></td>
<td></td>
</tr>
<tr>
<td><code>fastaPath</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-reference-genome.html">reference-genome</a></td>
<td><code>Basic.extension[fasta_path].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## TargetRegion logical model

Logical model: <a href="StructureDefinition-pc-target-region-lm.html">target-region-lm</a>
Primary FHIR profile: <a href="StructureDefinition-target-region.html">target-region</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `target_region`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>targetRegionId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-target-region.html">target-region</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>genomicTestId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-target-region.html">target-region</a></td>
<td><code>Basic.extension[genomicTestId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>hgncId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-target-region.html">target-region</a></td>
<td><code>Basic.extension[hgncId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>hgncSymbol</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-target-region.html">target-region</a></td>
<td><code>Basic.extension[hgncSymbol].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>chromosomeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-target-region.html">target-region</a></td>
<td><code>Basic.extension[chromosomeId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>startPosition</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-target-region.html">target-region</a></td>
<td><code>Basic.extension[startPosition].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>endPosition</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-target-region.html">target-region</a></td>
<td><code>Basic.extension[endPosition].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## GenomicTest logical model

Logical model: <a href="StructureDefinition-pc-genomic-test-lm.html">genomic-test-lm</a>
Primary FHIR profile: <a href="StructureDefinition-genomic-test.html">genomic-test</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `genomic_test`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>genomicTestId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>referenceGenomeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[referenceGenomeId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>testName</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[testName].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>testVersion</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[testVersion].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>sequencingDevice</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[sequencingDevice].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>targetCapture</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[targetCapture].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>readType</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[readType].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>readLength</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[readLength].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>meanTargetCoverage</code></td>
<td><code>0..1</code></td>
<td><code>integer</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[meanTargetCoverage].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>perTargetBaseCover100x</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[perTargetBaseCover100x].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>alignmentTools</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[alignmentTools].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>variantCallingTools</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[variantCallingTools].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>chromosomeCorrdinate</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[chromosomeCorrdinate].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>annotationTools</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[annotationTools].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>annotationDatabases</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-genomic-test.html">genomic-test</a></td>
<td><code>Basic.extension[annotationDatabases].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## VariantOccurrence logical model

Logical model: <a href="StructureDefinition-pc-variant-occurrence-lm.html">variant-occurrence-lm</a>
Primary FHIR profile: <a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `variant_occurrence`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>variantOccurrenceId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>targetRegionId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[targetRegionId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>referenceSequence</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[referenceSequence].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>rsId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[rsId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>referenceAllele</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[referenceAllele].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>alternateAllele</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[alternateAllele].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>hgvsC</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[hgvsC].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>hgvsP</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[hgvsP].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>variantReadDepth</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[variantReadDepth].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>variantExonNumber</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[variantExonNumber].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>copyNumber</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[copyNumber].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>cnvLocus</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[cnvLocus].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>fusionBreakpoint</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[fusionBreakpoint].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>fusionSupportingReads</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[fusionSupportingReads].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>sequenceAlteration</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[sequenceAlteration].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>variantFeature</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[variantFeature].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>geneticOrigin</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[geneticOrigin].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>genotype</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-variant-occurrence.html">variant-occurrence</a></td>
<td><code>Basic.extension[genotype].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## VariantAnnotation logical model

Logical model: <a href="StructureDefinition-pc-variant-annotation-lm.html">variant-annotation-lm</a>
Primary FHIR profile: <a href="StructureDefinition-variant-annotation.html">variant-annotation</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `variant_annotation`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>variantAnnotationId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>variantOccurrenceId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.extension[variantOccurrenceId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>annotationDatabase</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.extension[annotationDatabase].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>variantOrigin</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.extension[variantOrigin].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>variantPathogeny</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.extension[variantPathogeny].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>variantClassLevel</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.extension[variantClassLevel].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>variantTierLevel</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.extension[variantTierLevel].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>alleleFrequency</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.extension[alleleFrequency].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>medication</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-variant-annotation.html">variant-annotation</a></td>
<td><code>Basic.extension[medication].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## EpigenomeStudy logical model

Logical model: <a href="StructureDefinition-pc-epigenome-study-lm.html">epigenome-study-lm</a>
Primary FHIR profile: <a href="StructureDefinition-epigenome-study.html">epigenome-study</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `epigenome_study`.</p>

<table class="table table-bordered table-striped" xmlns="http://www.w3.org/1999/xhtml">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>epigenomeStudyId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>genomicTestId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[genomicTestId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>bisulfiteReferenceKit</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[bisulfiteReferenceKit].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>bisulfiteDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[bisulfiteDate].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>ageAtDnaExtraction</code></td>
<td><code>0..1</code></td>
<td><code>integer</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[ageAtDNAExtraction].valueDecimal</code></td>
<td></td>
</tr>
<tr>
<td><code>arrayDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[arrayDate].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>snpReaderDevice</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[snpReaderDevice].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>sampleType</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[sampleType].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>poolId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[poolId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>sampleId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[sampleId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>sentrixBarcodearray</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[sentrixBarcodeArray].valueString</code></td>
<td></td>
</tr>
<tr>
<td><code>sentrixPosition</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[sentrixPosition].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>chipType</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[chipType].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>manifestNumber</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[manifestNumber].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>scanDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[scanDate].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>rawData</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[rawData].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>targetDiseaseId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-epigenome-study.html">epigenome-study</a></td>
<td><code>Basic.extension[targetDiseaseId].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## MethylomicStudy logical model

Logical model: <a href="StructureDefinition-pc-methylomic-study-lm.html">methylomic-study-lm</a>
Primary FHIR profile: <a href="StructureDefinition-methylomic-study.html">methylomic-study</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `methylomic_study`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>methylomicStudyId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-methylomic-study.html">methylomic-study</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>referenceGenomeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-methylomic-study.html">methylomic-study</a></td>
<td><code>Basic.extension[referenceGenomeId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>targetRegionId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-methylomic-study.html">methylomic-study</a></td>
<td><code>Basic.extension[targetRegionId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>betaValue</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-methylomic-study.html">methylomic-study</a></td>
<td><code>Basic.extension[betaValue].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>mValue</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-methylomic-study.html">methylomic-study</a></td>
<td><code>Basic.extension[mValue].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>detectionPValue</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-methylomic-study.html">methylomic-study</a></td>
<td><code>Basic.extension[detectionPValue].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>readCount</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-methylomic-study.html">methylomic-study</a></td>
<td><code>Basic.extension[readCount].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>methylatedReads</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-methylomic-study.html">methylomic-study</a></td>
<td><code>Basic.extension[methylatedReads].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## PreMedication logical model

Logical model: <a href="StructureDefinition-pc-pre-medication-lm.html">pre-medication-lm</a>
Primary FHIR profile: <a href="StructureDefinition-pre-medication.html">pre-medication</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `pre_medication`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>preMedicationId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-pre-medication.html">pre-medication</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-pre-medication.html">pre-medication</a></td>
<td><code>Basic.extension[patient_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>antihypertensiveTreatment</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-pre-medication.html">pre-medication</a></td>
<td><code>Basic.extension[antihypertensive_treatment].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>rituximab</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-pre-medication.html">pre-medication</a></td>
<td><code>Basic.extension[rituximab].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>antiviralPhrophylaxis</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-pre-medication.html">pre-medication</a></td>
<td><code>Basic.extension[antiviral_phrophylaxis].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>otherMedications</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-pre-medication.html">pre-medication</a></td>
<td><code>Basic.extension[other_medications].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## ClinicalVariable logical model

Logical model: <a href="StructureDefinition-pc-clinical-variable-lm.html">clinical-variable-lm</a>
Primary FHIR profile: <a href="StructureDefinition-clinical-variable.html">clinical-variable</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `clinical_variable`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>clinicalVariableId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[patientId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>date</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[date].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>weight</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[weight].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>height</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[height].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>systolicBloodPressure</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[systolicBloodPressure].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>diastolicBloodPressure</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[diastolicBloodPressure].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>heartRate</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[heartRate].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>oxygenSaturation</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[oxygenSaturation].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>temperature</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-clinical-variable.html">clinical-variable</a></td>
<td><code>Basic.extension[temperature].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## ConcomitantDisease logical model

Logical model: <a href="StructureDefinition-pc-concomitant-disease-lm.html">concomitant-disease-lm</a>
Primary FHIR profile: <a href="StructureDefinition-concomitant-disease.html">concomitant-disease</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `concomitant_disease`.</p>

<table class="table table-bordered table-striped" xmlns="http://www.w3.org/1999/xhtml">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>concomitantDiseaseId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-disease.html">concomitant-disease</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>name</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-disease.html">concomitant-disease</a></td>
<td><code>Basic.extension[concomitantDiseaseName].valueString</code></td>
<td></td>
</tr>
</tbody></table>

## ConcomitantMedication logical model

Logical model: <a href="StructureDefinition-pc-concomitant-medication-lm.html">concomitant-medication-lm</a>
Primary FHIR profile: <a href="StructureDefinition-concomitant-medication.html">concomitant-medication</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `concomitant_medication`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>concomitantMedicationId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-medication.html">concomitant-medication</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>concomitantEpisodeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-medication.html">concomitant-medication</a></td>
<td><code>Basic.extension[concomitantEpisodeId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>medication</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-medication.html">concomitant-medication</a></td>
<td><code>Basic.extension[medication].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## ConcomitantEpisode logical model

Logical model: <a href="StructureDefinition-pc-concomitant-episode-lm.html">concomitant-episode-lm</a>
Primary FHIR profile: <a href="StructureDefinition-concomitant-episode.html">concomitant-episode</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `concomitant_episode`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>concomitantEpisodeId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-episode.html">concomitant-episode</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>concomitantDiseaseId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-episode.html">concomitant-episode</a></td>
<td><code>Basic.extension[concomitantDiseaseId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-episode.html">concomitant-episode</a></td>
<td><code>Basic.extension[patientId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>date</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-concomitant-episode.html">concomitant-episode</a></td>
<td><code>Basic.extension[date].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>description</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-concomitant-episode.html">concomitant-episode</a></td>
<td><code>Basic.extension[description].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## Microbiology logical model

Logical model: <a href="StructureDefinition-pc-microbiology-lm.html">microbiology-lm</a>
Primary FHIR profile: <a href="StructureDefinition-microbiology.html">microbiology</a> (Observation)

<p>Logical model representing the PROTECT-CHILD data model entity `microbiology`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>microbiologyId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[patient_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>donorId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[donor_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>ebvDna</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[ebv_dna].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>ebvIgmAntiEa</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[ebv_igm_anti_ea].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>ebvIgmAntiVca</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[ebv_igm_anti_vca].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>ebvIggAntiVca</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[ebv_igg_anti_vca].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>ebvIggEbna</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[ebv_igg_ebna].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>cmvDna</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[cmv_dna].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>cmvIgm</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[cmv_igm].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>cmvIgg</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[cmv_igg].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>parvovirusB19Dna</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[parvovirus_b19_dna].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>parvovirusB19DnaIgg</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[parvovirus_b19_dna_igg].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>parvovirusB19DnaIgm</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[parvovirus_b19_dna_igm].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>hsvIgg</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[hsv_igg].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>hsvIgm</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[hsv_igm].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>adenovirusIgg</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[adenovirus_igg].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>adenovirusIgm</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[adenovirus_igm].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>vzvIgg</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[vzv_igg].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>vzvIgm</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[vzv_igm].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>bloodBkvDna</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[blood_bkv_dna].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>urineBkvDna</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[urine_bkv_dna].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>bkvDnaKidneyBiopsy</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[bkv_dna_kidney_biopsy].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>bkvFishKidneyBiopsy</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-microbiology.html">microbiology</a></td>
<td><code>Observation.extension[bkv_fish_kidney_biopsy].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## InstrumentalInvestigation logical model

Logical model: <a href="StructureDefinition-pc-instrumental-investigation-lm.html">instrumental-investigation-lm</a>
Primary FHIR profile: <a href="StructureDefinition-instrumental-investigation.html">instrumental-investigation</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `instrumental_investigation`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>instrumentalInvestigationId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-instrumental-investigation.html">instrumental-investigation</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>name</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-instrumental-investigation.html">instrumental-investigation</a></td>
<td><code>Basic.extension[name].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## PatInstInv logical model

Logical model: <a href="StructureDefinition-pc-pat-inst-inv-lm.html">pat-inst-inv-lm</a>
Primary FHIR profile: <a href="StructureDefinition-patient-instrumental-investigation.html">patient-instrumental-investigation</a> (Observation)

<p>Logical model representing the PROTECT-CHILD data model entity `pat_inst_inv`.</p>

<table class="table table-bordered table-striped" xmlns="http://www.w3.org/1999/xhtml">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>patInstInvId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-instrumental-investigation.html">patient-instrumental-investigation</a></td>
<td><code>Observation.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>instrumentalInvestigationId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-instrumental-investigation.html">patient-instrumental-investigation</a></td>
<td><code>Observation.extension[instrumental_investigation_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-instrumental-investigation.html">patient-instrumental-investigation</a></td>
<td><code>Observation.extension[patient_id].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>date</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-patient-instrumental-investigation.html">patient-instrumental-investigation</a></td>
<td><code>Observation.effectiveDateTime</code></td>
<td></td>
</tr>
<tr>
<td><code>result</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-instrumental-investigation.html">patient-instrumental-investigation</a></td>
<td><code>Observation.extension[result].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>observations</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-patient-instrumental-investigation.html">patient-instrumental-investigation</a></td>
<td><code>Observation.note.text</code></td>
<td></td>
</tr>
</tbody></table>

## Immunosuppressant logical model

Logical model: <a href="StructureDefinition-pc-immunosuppressant-lm.html">immunosuppressant-lm</a>
Primary FHIR profile: <a href="StructureDefinition-immunosuppressant.html">immunosuppressant</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `immunosuppressant`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>immId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressant.html">immunosuppressant</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>name</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressant.html">immunosuppressant</a></td>
<td><code>Basic.extension[name].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## ImmIndPat logical model

Logical model: <a href="StructureDefinition-pc-imm-ind-pat-lm.html">imm-ind-pat-lm</a>
Primary FHIR profile: <a href="StructureDefinition-immunosuppressive-induction-patient.html">immunosuppressive-induction-patient</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `imm_ind_pat`.</p>

<table class="table table-bordered table-striped" xmlns="http://www.w3.org/1999/xhtml">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>immIndPatId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressive-induction-patient.html">immunosuppressive-induction-patient</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>immId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressive-induction-patient.html">immunosuppressive-induction-patient</a></td>
<td><code>Basic.extension[immId].valueReference</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressive-induction-patient.html">immunosuppressive-induction-patient</a></td>
<td><code>Basic.extension[patientId].valueReference</code></td>
<td></td>
</tr>
<tr>
<td><code>dose</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-immunosuppressive-induction-patient.html">immunosuppressive-induction-patient</a></td>
<td><code>Basic.extension[dose].valueQuantity</code></td>
<td>Dose quantity (value + UCUM unit).</td>
</tr>
<tr>
<td><code>unit</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-immunosuppressive-induction-patient.html">immunosuppressive-induction-patient</a></td>
<td><code>Basic.extension[dose].valueQuantity.code</code></td>
<td>Unit is carried in the dose Quantity (UCUM code).</td>
</tr>
</tbody></table>

## ImmMainPat logical model

Logical model: <a href="StructureDefinition-pc-imm-main-pat-lm.html">imm-main-pat-lm</a>
Primary FHIR profile: <a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `imm_main_pat`.</p>

<table class="table table-bordered table-striped" xmlns="http://www.w3.org/1999/xhtml">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>immMainPatId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[patient_id].valueReference</code></td>
<td></td>
</tr>
<tr>
<td><code>immId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[immunosuppressant_id].valueReference</code></td>
<td></td>
</tr>
<tr>
<td><code>unitId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[dose].valueQuantity.code</code></td>
<td>Unit is carried in the dose Quantity (UCUM code).</td>
</tr>
<tr>
<td><code>dose</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[dose].valueQuantity</code></td>
<td>Dose quantity (value + UCUM unit).</td>
</tr>
<tr>
<td><code>preDoseLevel</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[pre_dose_level].valueQuantity</code></td>
<td><html><body>Pre-dose (trough) drug level as Quantity with UCUM unit.</body></html></td>
</tr>
<tr>
<td><code>csa2hPostDoseLevel</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[csa2h_post_dose_level].valueQuantity</code></td>
<td><html><body>2-hour post-dose drug level (C2), Quantity with UCUM unit.</body></html></td>
</tr>
<tr>
<td><code>auc</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[auc].valueQuantity</code></td>
<td><html><body>Pharmacokinetic AUC, Quantity with UCUM unit.</body></html></td>
</tr>
<tr>
<td><code>startDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[start_date].valueDate</code></td>
<td></td>
</tr>
<tr>
<td><code>endDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-immunosuppressive-maintenance-patient.html">immunosuppressive-maintenance-patient</a></td>
<td><code>Basic.extension[end_date].valueDate</code></td>
<td></td>
</tr>
</tbody></table>

## LabTest logical model

Logical model: <a href="StructureDefinition-pc-lab-test-lm.html">lab-test-lm</a>
Primary FHIR profile: <a href="StructureDefinition-lab-test.html">lab-test</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `lab_test`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>labTestId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-lab-test.html">lab-test</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>unitId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-lab-test.html">lab-test</a></td>
<td><code>Basic.extension[unitId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>name</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-lab-test.html">lab-test</a></td>
<td><code>Basic.extension[name].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## Unit logical model

Logical model: <a href="StructureDefinition-pc-unit-lm.html">unit-lm</a>
Primary FHIR profile: FHIR datatype: <a href="https://hl7.org/fhir/R4/datatypes.html#quantity">Quantity</a> (UCUM; system <a href="http://unitsofmeasure.org">http://unitsofmeasure.org</a>)

<p>Logical model representing the PROTECT-CHILD data model entity `unit`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>unitId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="https://hl7.org/fhir/R4/datatypes.html#quantity">Quantity</a></td>
<td><code>Quantity.code</code></td>
<td>Use UCUM where possible (code with system http://unitsofmeasure.org).</td>
</tr>
<tr>
<td><code>ucum</code></td>
<td><code>0..1</code></td>
<td><code>code</code></td>
<td><a href="https://hl7.org/fhir/R4/datatypes.html#quantity">Quantity</a></td>
<td><code>Quantity.system + Quantity.code</code></td>
<td>UCUM: system fixed to http://unitsofmeasure.org; code is the UCUM unit.</td>
</tr>
<tr>
<td><code>label</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="https://hl7.org/fhir/R4/datatypes.html#quantity">Quantity</a></td>
<td><code>Quantity.unit</code></td>
<td>Human-readable unit display (e.g., mg/kg).</td>
</tr>
</tbody></table>

## LabResult logical model

Logical model: <a href="StructureDefinition-pc-lab-result-lm.html">lab-result-lm</a>
Primary FHIR profile: <a href="StructureDefinition-lab-result-observation.html">lab-result-observation</a> (Observation)

<p>Logical model representing the PROTECT-CHILD data model entity `lab_result`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>labResultId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-lab-result-observation.html">lab-result-observation</a></td>
<td><code>Observation.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>labTestId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-lab-result-observation.html">lab-result-observation</a></td>
<td><code>Observation.extension[lab_test_id].valueReference</code></td>
<td>Reference to LabTest.</td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-lab-result-observation.html">lab-result-observation</a></td>
<td><code>Observation.extension[patient_id].valueReference</code></td>
<td>Reference to PatientTransplant.</td>
</tr>
<tr>
<td><code>unitId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-lab-result-observation.html">lab-result-observation</a></td>
<td><code>Observation.valueQuantity.code</code></td>
<td>From LabResultUnitVS (or UCUM/CodeSystem).</td>
</tr>
<tr>
<td><code>date</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-lab-result-observation.html">lab-result-observation</a></td>
<td><code>Observation.effectiveDateTime</code></td>
<td></td>
</tr>
<tr>
<td><code>value</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-lab-result-observation.html">lab-result-observation</a></td>
<td><code>Observation.valueQuantity.value</code></td>
<td></td>
</tr>
</tbody></table>

## MarkImmFunc logical model

Logical model: <a href="StructureDefinition-pc-mark-imm-func-lm.html">mark-imm-func-lm</a>
Primary FHIR profile: <a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `mark_imm_func`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>markImmFuncId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[patientId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>hlaAntibodyClass</code></td>
<td><code>0..1</code></td>
<td><code>CodeableConcept</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[hlaAntibodyClass].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>mfiValue</code></td>
<td><code>0..1</code></td>
<td><code>decimal</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[mfiValue].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>dsa</code></td>
<td><code>0..1</code></td>
<td><code>boolean</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[dsa].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>atr1</code></td>
<td><code>0..1</code></td>
<td><code>boolean</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[atr1].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>etar</code></td>
<td><code>0..1</code></td>
<td><code>boolean</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[etar].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>mica</code></td>
<td><code>0..1</code></td>
<td><code>boolean</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[mica].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>micb</code></td>
<td><code>0..1</code></td>
<td><code>boolean</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[micb].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>aecaOther</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-marker-immune-function.html">marker-immune-function</a></td>
<td><code>Basic.extension[aecaOther].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## PostEvent logical model

Logical model: <a href="StructureDefinition-pc-post-event-lm.html">post-event-lm</a>
Primary FHIR profile: <a href="StructureDefinition-post-event.html">post-event</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `post_event`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>postEventId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-post-event.html">post-event</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>postEventTypeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-post-event.html">post-event</a></td>
<td><code>Basic.extension[postEventTypeId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-post-event.html">post-event</a></td>
<td><code>Basic.extension[patientId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>onsetDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-post-event.html">post-event</a></td>
<td><code>Basic.extension[onsetDate].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>endDate</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-post-event.html">post-event</a></td>
<td><code>Basic.extension[endDate].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>description</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-post-event.html">post-event</a></td>
<td><code>Basic.extension[description].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## PostEventType logical model

Logical model: <a href="StructureDefinition-pc-post-event-type-lm.html">post-event-type-lm</a>
Primary FHIR profile: <a href="StructureDefinition-post-event-type.html">post-event-type</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `post_event_type`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>postEventTypeId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-post-event-type.html">post-event-type</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>name</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-post-event-type.html">post-event-type</a></td>
<td><code>Basic.extension[name].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## OutcomeType logical model

Logical model: <a href="StructureDefinition-pc-outcome-type-lm.html">outcome-type-lm</a>
Primary FHIR profile: <a href="StructureDefinition-outcome-type.html">outcome-type</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `outcome_type`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>outcomeTypeId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome-type.html">outcome-type</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>name</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome-type.html">outcome-type</a></td>
<td><code>Basic.extension[name].value[x]</code></td>
<td></td>
</tr>
</tbody></table>

## Outcome logical model

Logical model: <a href="StructureDefinition-pc-outcome-lm.html">outcome-lm</a>
Primary FHIR profile: <a href="StructureDefinition-outcome.html">outcome</a> (Basic)

<p>Logical model representing the PROTECT-CHILD data model entity `outcome`.</p>

<table xmlns="http://www.w3.org/1999/xhtml" class="table table-bordered table-striped">
<thead><tr>
<th style="width:20%">Logical element</th>
<th style="width:12%">Card.</th>
<th style="width:16%">Logical type</th>
<th style="width:22%">FHIR profile</th>
<th style="width:20%">FHIR element path</th>
<th style="width:10%">Notes</th>
</tr></thead>
<tbody>
<tr>
<td><code>outcomeId</code></td>
<td><code>1..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.identifier.value</code></td>
<td></td>
</tr>
<tr>
<td><code>outcomeTypeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[outcomeTypeId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>patientId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[patientId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>date</code></td>
<td><code>0..1</code></td>
<td><code>dateTime</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[date].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>preMedication</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[preMedicationId].valueReference</code></td>
<td>Reference to <a href=\"StructureDefinition-pre-medication.html\">pre-medication</a> (Basic).</td>
</tr>
<tr>
<td><code>clinicalVariableId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[clinicalVariableId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>concomitantEpisodeId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[concomitantEpisodeId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>microbiologyId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[microbiologyId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>patInstInvId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[patInstInvId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>labTestId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[labTestId].value[x]</code></td>
<td></td>
</tr>
<tr>
<td><code>postEventId</code></td>
<td><code>0..1</code></td>
<td><code>string</code></td>
<td><a href="StructureDefinition-outcome.html">outcome</a></td>
<td><code>Basic.extension[postEventId].value[x]</code></td>
<td></td>
</tr>
</tbody></table>
