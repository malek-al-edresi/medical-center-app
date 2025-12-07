
import '../../domain/entities/radiology_result.dart';
import '../../domain/repositories/radiology_result_repository.dart';
import '../services/radiology_result_service.dart';

class RadiologyResultRepositoryImpl implements RadiologyResultRepository {
  final RadiologyResultService service;

  RadiologyResultRepositoryImpl(this.service);

  @override
  Future<List<RadiologyResult>> getRadiologyResults(String invoiceId) {
    return service.fetchRadiologyResults(invoiceId);
  }
}
