import 'package:flutter/material.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/lab_result_entity.dart';
import '../../domain/entities/radiology_entity.dart';
import '../../domain/entities/diagnosis_entity.dart';
import '../../domain/entities/treatment_entity.dart';
import '../../domain/usecases/get_patient_by_invoice.dart';
import '../../domain/usecases/get_lab_results.dart';
import '../../domain/usecases/get_radiology_results.dart';
import '../../domain/usecases/get_diagnosis.dart';
import '../../domain/usecases/get_treatment.dart';

enum ViewState { initial, loading, loaded, error, empty }

class PatientProvider extends ChangeNotifier {
  final GetPatientByInvoice getPatient;
  final GetLabResults getLabResults;
  final GetRadiologyResults getRadiologyResults;
  final GetDiagnosis getDiagnosis;
  final GetTreatment getTreatment;

  PatientProvider({
    required this.getPatient,
    required this.getLabResults,
    required this.getRadiologyResults,
    required this.getDiagnosis,
    required this.getTreatment,
  });

  // ===================== STATE =====================
  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ===================== DATA =====================
  PatientEntity? _patient;
  PatientEntity? get patient => _patient;

  List<LabResultEntity> _labResults = [];
  List<LabResultEntity> get labResults => _labResults;

  List<RadiologyEntity> _radiologyResults = [];
  List<RadiologyEntity> get radiologyResults => _radiologyResults;

  List<DiagnosisEntity> _diagnosis = [];
  List<DiagnosisEntity> get diagnosis => _diagnosis;

  List<TreatmentEntity> _treatment = [];
  List<TreatmentEntity> get treatment => _treatment;

  // ===================== PUBLIC API =====================
  Future<void> fetchMedicalData(String invoiceId) async {
    debugPrint(
      'PatientProvider.fetchMedicalData called with invoiceId: $invoiceId',
    );

    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    final patientResult = await getPatient(invoiceId);

    patientResult.fold(
      onSuccess: (patientData) {
        debugPrint(
          'PatientProvider.fetchMedicalData success: Patient found',
        );

        _patient = patientData;

        _state = ViewState.loaded;
        notifyListeners();

        _fetchAdditionalData(invoiceId);
      },
      onFailure: (error) {
        debugPrint(
          'PatientProvider.fetchMedicalData failed: ${error.message}',
        );

        _state = ViewState.error;
        _errorMessage = error.message;
        notifyListeners();
      },
    );
  }

  // ===================== BACKGROUND FETCH =====================
  Future<void> _fetchAdditionalData(String invoiceId) async {
    debugPrint(
      'PatientProvider._fetchAdditionalData started for invoiceId: $invoiceId',
    );

    final results = await Future.wait([
      getLabResults(invoiceId),
      getRadiologyResults(invoiceId),
      getDiagnosis(invoiceId),
      getTreatment(invoiceId),
    ]);

    // -------- LAB RESULTS --------
    (results[0] as Result<List<LabResultEntity>, Exception>).fold(
      onSuccess: (data) => _labResults = data,
      onFailure: (_) => _labResults = [],
    );

    // -------- RADIOLOGY --------
    (results[1] as Result<List<RadiologyEntity>, Exception>).fold(
      onSuccess: (data) => _radiologyResults = data,
      onFailure: (_) => _radiologyResults = [],
    );

    // -------- DIAGNOSIS --------
    (results[2] as Result<List<DiagnosisEntity>, Exception>).fold(
      onSuccess: (data) => _diagnosis = data,
      onFailure: (_) => _diagnosis = [],
    );

    // -------- TREATMENT --------
    (results[3] as Result<List<TreatmentEntity>, Exception>).fold(
      onSuccess: (data) => _treatment = data,
      onFailure: (_) => _treatment = [],
    );

    notifyListeners();
  }

  // ===================== RESET =====================
  void clearData() {
    debugPrint('PatientProvider.clearData called');

    _patient = null;
    _labResults = [];
    _radiologyResults = [];
    _diagnosis = [];
    _treatment = [];
    _state = ViewState.initial;
    _errorMessage = null;

    notifyListeners();
  }
}
