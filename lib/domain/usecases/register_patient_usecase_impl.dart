import '../../domain/entities/preregistration_result.dart';
import '../../domain/repositories/preregistration_repository.dart';
import '../../domain/usecases/get_preregistration.dart';
import '../../core/resource/data_state.dart';

class RegisterPatientUseCaseImpl implements RegisterPatientUseCase {
  final PreregistrationRepository _repository;

  RegisterPatientUseCaseImpl(this._repository);

  @override
  Future<bool> call(PatientRegisterEntity patient) async {
    try {
      final DataState<bool> result = await _repository.registerPatient(patient);
      if (result is DataSuccess<bool>) {
        return result.data;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}