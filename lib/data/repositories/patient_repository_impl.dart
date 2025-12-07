
import '../../domain/repositories/patient_repository.dart';
import '../../domain/entities/patient_result.dart';
import '../services/patient_service.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientService service;

  PatientRepositoryImpl(this.service);

  @override
  Future<List<PatientResult>> getAllPatients(String invoiceId) async {
    return await service.fetchPatientResult(invoiceId);
  }
}
