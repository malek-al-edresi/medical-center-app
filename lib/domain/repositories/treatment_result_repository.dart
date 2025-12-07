
import '../entities/treatment_result.dart';

abstract class TreatmentResultRepository {
  Future<List<TreatmentResult>> getTreatmentResults(String invoiceId);
}
