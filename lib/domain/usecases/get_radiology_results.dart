
import '../entities/radiology_result.dart';
import '../repositories/radiology_result_repository.dart';

class GetRadiologyResults {
  final RadiologyResultRepository repository;

  GetRadiologyResults(this.repository);

  Future<List<RadiologyResult>> call(String invoiceId) async {
    return await repository.getRadiologyResults(invoiceId);
  }
}
