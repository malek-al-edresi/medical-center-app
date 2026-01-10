import 'package:flutter/foundation.dart';
import '../../core/utils/result.dart';
import '../../core/error/exceptions.dart';
import '../repositories/medical_repository.dart';
import '../entities/radiology_entity.dart';

class GetRadiologyResults {
  final MedicalRepository repository;

  GetRadiologyResults(this.repository);

  Future<Result<List<RadiologyEntity>, AppException>> call(
    String invoiceId,
  ) async {
    debugPrint('GetRadiologyResults UseCase called with invoiceId: $invoiceId');
    return await repository.getRadiologyResults(invoiceId);
  }
}
