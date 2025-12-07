
import '../entities/diagnosis_result.dart';
import '../repositories/diagnosis_result_repository.dart';

class GetDiagnosisResults {
  final DiagnosisResultRepository repository;

  GetDiagnosisResults(this.repository);

  Future<List<DiagnosisResult>> call(String invoiceId) {
    return repository.getDiagnosisResults(invoiceId);
  }
}
