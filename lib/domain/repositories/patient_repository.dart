import '../entities/patient_result.dart';

abstract class PatientRepository {
  Future<List<PatientResult>> getAllPatients(String invoiceId);
}
