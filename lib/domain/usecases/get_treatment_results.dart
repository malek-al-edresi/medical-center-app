
import '../entities/treatment_result.dart';
import '../repositories/treatment_result_repository.dart';

class GetTreatmentResults {
  final TreatmentResultRepository repository;

  GetTreatmentResults(this.repository);

  Future<List<TreatmentResult>> call(String invoiceId) {
    return repository.getTreatmentResults(invoiceId);
  }
}
