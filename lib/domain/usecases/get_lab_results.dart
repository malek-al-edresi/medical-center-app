
import '../entities/lab_result.dart';
import '../repositories/lab_result_repository.dart';

class GetLabResults {
  final LabResultRepository repository;

  GetLabResults(this.repository);

  Future<List<LabResult>> call(String invoiceId) async {
    return await repository.getLabResults(invoiceId);
  }
}
