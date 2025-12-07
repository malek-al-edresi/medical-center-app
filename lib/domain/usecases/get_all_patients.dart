
import '../entities/patient_result.dart';
import '../repositories/patient_repository.dart';

class GetAllPatients {
  final PatientRepository repository;

  GetAllPatients(this.repository);

  Future<List<PatientResult>> call(String invoiceId) async {
    return await repository.getAllPatients(invoiceId);
  }
}
