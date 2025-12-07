import '../entities/preregistration_result.dart';

abstract class RegisterPatientUseCase {
  Future<bool> call(PatientRegisterEntity patient);
}