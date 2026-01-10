import 'package:flutter/foundation.dart';
import '../../../core/utils/result.dart';
import '../../../core/error/exceptions.dart';
import '../../../domain/entities/patient_entity.dart';
import '../../../domain/entities/lab_result_entity.dart';
import '../../../domain/entities/radiology_entity.dart';
import '../../../domain/entities/diagnosis_entity.dart';
import '../../../domain/entities/treatment_entity.dart';
import '../../../domain/repositories/medical_repository.dart';
import '../datasources/remote/medical_api_service.dart';

class MedicalRepositoryImpl implements MedicalRepository {
  final MedicalApiService apiService;

  MedicalRepositoryImpl(this.apiService);

  @override
  Future<Result<PatientEntity, AppException>> getPatientByInvoice(
    String invoiceId,
  ) async {
    debugPrint(
      'MedicalRepositoryImpl.getPatientByInvoice called with invoiceId: $invoiceId',
    );
    try {
      final patients = await apiService.getPatient(invoiceId);
      if (patients.isNotEmpty) {
        debugPrint(
          'MedicalRepositoryImpl.getPatientByInvoice success: found ${patients.length} patients',
        );
        return Success(patients.first);
      }
      debugPrint(
        'MedicalRepositoryImpl.getPatientByInvoice failed: Patient not found',
      );
      return const Failure(NotFoundException('Patient not found'));
    } on AppException catch (e) {
      debugPrint('MedicalRepositoryImpl.getPatientByInvoice error: $e');
      return Failure(e);
    } catch (e) {
      debugPrint(
        'MedicalRepositoryImpl.getPatientByInvoice unexpected error: $e',
      );
      return Failure(ServerException(e.toString()));
    }
  }

  @override
  Future<Result<List<LabResultEntity>, AppException>> getLabResults(
    String invoiceId,
  ) async {
    return _wrapExecution(() => apiService.getLabResults(invoiceId));
  }

  @override
  Future<Result<List<RadiologyEntity>, AppException>> getRadiologyResults(
    String invoiceId,
  ) async {
    return _wrapExecution(() => apiService.getRadiologyResults(invoiceId));
  }

  @override
  Future<Result<List<DiagnosisEntity>, AppException>> getDiagnosis(
    String invoiceId,
  ) async {
    return _wrapExecution(() => apiService.getDiagnosis(invoiceId));
  }

  @override
  Future<Result<List<TreatmentEntity>, AppException>> getTreatment(
    String invoiceId,
  ) async {
    return _wrapExecution(() => apiService.getTreatment(invoiceId));
  }

  Future<Result<T, AppException>> _wrapExecution<T>(
    Future<T> Function() call,
  ) async {
    debugPrint('MedicalRepositoryImpl performing generic request...');
    try {
      final result = await call();
      debugPrint('MedicalRepositoryImpl request success: $result');
      return Success(result);
    } on AppException catch (e) {
      debugPrint('MedicalRepositoryImpl request error: $e');
      return Failure(e);
    } catch (e) {
      debugPrint('MedicalRepositoryImpl request unexpected error: $e');
      return Failure(ServerException(e.toString()));
    }
  }
}
