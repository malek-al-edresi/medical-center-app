import 'package:flutter/foundation.dart';
import '../../core/utils/result.dart';
import '../../core/error/exceptions.dart';
import '../repositories/medical_repository.dart';
import '../entities/diagnosis_entity.dart';

class GetDiagnosis {
  final MedicalRepository repository;

  GetDiagnosis(this.repository);

  Future<Result<List<DiagnosisEntity>, AppException>> call(
    String invoiceId,
  ) async {
    debugPrint('GetDiagnosis UseCase called with invoiceId: $invoiceId');
    return await repository.getDiagnosis(invoiceId);
  }
}
