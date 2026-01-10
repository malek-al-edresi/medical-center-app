import 'package:flutter/foundation.dart';
import '../../core/utils/result.dart';
import '../../core/error/exceptions.dart';
import '../repositories/medical_repository.dart';
import '../entities/treatment_entity.dart';

class GetTreatment {
  final MedicalRepository repository;

  GetTreatment(this.repository);

  Future<Result<List<TreatmentEntity>, AppException>> call(
    String invoiceId,
  ) async {
    debugPrint('GetTreatment UseCase called with invoiceId: $invoiceId');
    return await repository.getTreatment(invoiceId);
  }
}
