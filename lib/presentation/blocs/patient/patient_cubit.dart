import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/patient_entity.dart';
import '../../../domain/entities/lab_result_entity.dart';
import '../../../domain/entities/radiology_entity.dart';
import '../../../domain/entities/diagnosis_entity.dart';
import '../../../domain/entities/treatment_entity.dart';
import '../../../domain/usecases/get_patient_by_invoice.dart';
import '../../../domain/usecases/get_lab_results.dart';
import '../../../domain/usecases/get_radiology_results.dart';
import '../../../domain/usecases/get_diagnosis.dart';
import '../../../domain/usecases/get_treatment.dart';
import 'patient_state.dart';

/// Cubit for managing patient medical data.
///
/// Depends only on Domain UseCases.
/// Does NOT contain UI logic, call APIs directly, or depend on Flutter widgets.
class PatientCubit extends Cubit<PatientState> {
  final GetPatientByInvoice _getPatient;
  final GetLabResults _getLabResults;
  final GetRadiologyResults _getRadiologyResults;
  final GetDiagnosis _getDiagnosis;
  final GetTreatment _getTreatment;

  PatientCubit({
    required GetPatientByInvoice getPatient,
    required GetLabResults getLabResults,
    required GetRadiologyResults getRadiologyResults,
    required GetDiagnosis getDiagnosis,
    required GetTreatment getTreatment,
  }) : _getPatient = getPatient,
       _getLabResults = getLabResults,
       _getRadiologyResults = getRadiologyResults,
       _getDiagnosis = getDiagnosis,
       _getTreatment = getTreatment,
       super(const PatientInitial());

  /// Loads patient data and all associated medical records by invoice ID.
  Future<void> loadPatient(String invoiceId) async {
    debugPrint('PatientCubit.loadPatient called with invoiceId: $invoiceId');

    emit(const PatientLoading());

    final patientResult = await _getPatient(invoiceId);

    patientResult.fold(
      onSuccess: (patient) async {
        debugPrint('PatientCubit.loadPatient success: Patient found');

        // Emit loaded state with patient, then fetch additional data
        emit(PatientLoaded(patient: patient));

        // Fetch additional data in parallel
        await _fetchAdditionalData(invoiceId, patient);
      },
      onFailure: (error) {
        debugPrint('PatientCubit.loadPatient failed: ${error.message}');
        emit(PatientError(error.message));
      },
    );
  }

  /// Fetches lab results, radiology, diagnosis, and treatment in parallel.
  Future<void> _fetchAdditionalData(
    String invoiceId,
    PatientEntity patient,
  ) async {
    debugPrint('PatientCubit._fetchAdditionalData started');

    final results = await Future.wait([
      _getLabResults(invoiceId),
      _getRadiologyResults(invoiceId),
      _getDiagnosis(invoiceId),
      _getTreatment(invoiceId),
    ]);

    List<LabResultEntity> labResults = [];
    List<RadiologyEntity> radiologyResults = [];
    List<DiagnosisEntity> diagnosis = [];
    List<TreatmentEntity> treatment = [];

    // Process lab results
    (results[0] as Result<List<LabResultEntity>, Exception>).fold(
      onSuccess: (data) => labResults = data,
      onFailure: (_) => labResults = [],
    );

    // Process radiology results
    (results[1] as Result<List<RadiologyEntity>, Exception>).fold(
      onSuccess: (data) => radiologyResults = data,
      onFailure: (_) => radiologyResults = [],
    );

    // Process diagnosis
    (results[2] as Result<List<DiagnosisEntity>, Exception>).fold(
      onSuccess: (data) => diagnosis = data,
      onFailure: (_) => diagnosis = [],
    );

    // Process treatment
    (results[3] as Result<List<TreatmentEntity>, Exception>).fold(
      onSuccess: (data) => treatment = data,
      onFailure: (_) => treatment = [],
    );

    emit(
      PatientLoaded(
        patient: patient,
        labResults: labResults,
        radiologyResults: radiologyResults,
        diagnosis: diagnosis,
        treatment: treatment,
      ),
    );
  }

  /// Clears all patient data and returns to initial state.
  void clearData() {
    debugPrint('PatientCubit.clearData called');
    emit(const PatientInitial());
  }
}
