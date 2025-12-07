
import '../../domain/entities/lab_result.dart';
import '../../domain/repositories/lab_result_repository.dart';
import '../services/lab_result_service.dart';

class LabResultRepositoryImpl implements LabResultRepository {
  final LabResultService service;

  LabResultRepositoryImpl(this.service);

  @override
  Future<List<LabResult>> getLabResults(String invoiceId) async {
    return await service.fetchLabResults(invoiceId);
  }
}
