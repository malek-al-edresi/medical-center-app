import '../entities/patient_entity.dart';

abstract class PatientRepository {
  Future<List<PatientEntity>> getAllPatients(String invoiceId);
}
