
import '../../domain/entities/diagnosis_result.dart';
import '../../domain/repositories/diagnosis_result_repository.dart';
import '../services/diagnosis_result_service.dart';

class DiagnosisResultRepositoryImpl implements DiagnosisResultRepository {
  final DiagnosisResultService service;

  DiagnosisResultRepositoryImpl(this.service);

  @override
  Future<List<DiagnosisResult>> getDiagnosisResults(String invoiceId) {
    return service.fetchDiagnosisResults(invoiceId);
  }
}
