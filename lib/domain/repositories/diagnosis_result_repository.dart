
import '../entities/diagnosis_result.dart';

abstract class DiagnosisResultRepository {
  Future<List<DiagnosisResult>> getDiagnosisResults(String invoiceId);
}
