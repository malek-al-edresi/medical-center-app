
import '../../domain/entities/treatment_result.dart';
import '../../domain/repositories/treatment_result_repository.dart';
import '../services/treatment_result_service.dart';

class TreatmentResultRepositoryImpl implements TreatmentResultRepository {
  final TreatmentResultService service;

  TreatmentResultRepositoryImpl(this.service);

  @override
  Future<List<TreatmentResult>> getTreatmentResults(String invoiceId) {
    return service.fetchTreatmentResults(invoiceId);
  }
}
