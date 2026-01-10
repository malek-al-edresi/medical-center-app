import 'package:flutter/foundation.dart';
import '../../core/utils/result.dart';
import '../../core/error/exceptions.dart';
import '../repositories/medical_repository.dart';
import '../entities/lab_result_entity.dart';

class GetLabResults {
  final MedicalRepository repository;

  GetLabResults(this.repository);

  Future<Result<List<LabResultEntity>, AppException>> call(
    String invoiceId,
  ) async {
    debugPrint('GetLabResults UseCase called with invoiceId: $invoiceId');
    return await repository.getLabResults(invoiceId);
  }
}
