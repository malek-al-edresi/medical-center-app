import '../../domain/entities/preregistration_result.dart';
import '../../core/resource/data_state.dart';

abstract class PreregistrationRepository {
  Future<DataState<bool>> registerPatient(PatientRegisterEntity patient);
}