import '../../core/utils/result.dart';
import '../../core/error/exceptions.dart';
import '../entities/patient_entity.dart';
import '../entities/lab_result_entity.dart';
import '../entities/radiology_entity.dart';
import '../entities/diagnosis_entity.dart';
import '../entities/treatment_entity.dart';

abstract class MedicalRepository {
  Future<Result<PatientEntity, AppException>> getPatientByInvoice(
    String invoiceId,
  );
  Future<Result<List<LabResultEntity>, AppException>> getLabResults(
    String invoiceId,
  );
  Future<Result<List<RadiologyEntity>, AppException>> getRadiologyResults(
    String invoiceId,
  );
  Future<Result<List<DiagnosisEntity>, AppException>> getDiagnosis(
    String invoiceId,
  );
  Future<Result<List<TreatmentEntity>, AppException>> getTreatment(
    String invoiceId,
  );
}
