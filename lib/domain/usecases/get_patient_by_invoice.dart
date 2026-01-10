import 'package:flutter/foundation.dart';
import '../../core/utils/result.dart';
import '../../core/error/exceptions.dart';
import '../repositories/medical_repository.dart';
import '../entities/patient_entity.dart';

class GetPatientByInvoice {
  final MedicalRepository repository;

  GetPatientByInvoice(this.repository);

  Future<Result<PatientEntity, AppException>> call(String invoiceId) async {
    debugPrint('GetPatientByInvoice UseCase called with invoiceId: $invoiceId');
    return await repository.getPatientByInvoice(invoiceId);
  }
}
