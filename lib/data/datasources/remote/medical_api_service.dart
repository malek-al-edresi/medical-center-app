import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../models/patient_model.dart';
import '../../models/lab_result_model.dart';
import '../../models/radiology_model.dart';
import '../../models/diagnosis_model.dart';
import '../../models/treatment_model.dart';

class MedicalApiService {
  final http.Client _client;

  MedicalApiService({http.Client? client})
      : _client = client ?? http.Client();

  // ===================== PATIENT =====================
  Future<List<PatientModel>> getPatient(String invoiceId) async {
    final uri = Uri.parse(ApiConstants.patientProfile)
        .replace(pathSegments: [
      ...Uri.parse(ApiConstants.patientProfile).pathSegments,
      invoiceId,
    ]);

    return _getList(uri, PatientModel.fromJson);
  }

  // ===================== LAB =====================
  Future<List<LabResultModel>> getLabResults(String invoiceId) async {
    final uri = Uri.parse(ApiConstants.labResults)
        .replace(pathSegments: [
      ...Uri.parse(ApiConstants.labResults).pathSegments,
      invoiceId,
    ]);

    return _getList(uri, LabResultModel.fromJson);
  }

  // ===================== RADIOLOGY =====================
  Future<List<RadiologyModel>> getRadiologyResults(String invoiceId) async {
    final uri = Uri.parse(ApiConstants.radiologyResults)
        .replace(pathSegments: [
      ...Uri.parse(ApiConstants.radiologyResults).pathSegments,
      invoiceId,
    ]);

    return _getList(uri, RadiologyModel.fromJson);
  }

  // ===================== DIAGNOSIS =====================
  Future<List<DiagnosisModel>> getDiagnosis(String invoiceId) async {
    final uri = Uri.parse(ApiConstants.diagnosis)
        .replace(pathSegments: [
      ...Uri.parse(ApiConstants.diagnosis).pathSegments,
      invoiceId,
    ]);

    return _getList(uri, DiagnosisModel.fromJson);
  }

  // ===================== TREATMENT =====================
  Future<List<TreatmentModel>> getTreatment(String invoiceId) async {
    final uri = Uri.parse(ApiConstants.treatment)
        .replace(pathSegments: [
      ...Uri.parse(ApiConstants.treatment).pathSegments,
      invoiceId,
    ]);

    return _getList(uri, TreatmentModel.fromJson);
  }

  // ===================== CORE GET =====================
  Future<List<T>> _getList<T>(
    Uri uri,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw ServerException(
            'Server error: ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body);

      if (decoded['items'] == null || decoded['items'] is! List) {
        return [];
      }

      return (decoded['items'] as List)
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw const NetworkException();
    } on FormatException catch (e) {
      throw DataParsingException(e.message);
    }
  }

  void dispose() {
    _client.close();
  }
}
