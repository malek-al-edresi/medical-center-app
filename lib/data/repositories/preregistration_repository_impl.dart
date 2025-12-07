import '../../domain/entities/preregistration_result.dart';
import '../../domain/repositories/preregistration_repository.dart';
import '../../data/services/preregistration_service.dart';
import '../../data/models/preregistration_model.dart';
import '../../core/exceptions/app_exception.dart';

import '../../core/exceptions/exception_handler.dart';
import '../../core/resource/data_state.dart';

class PreregistrationRepositoryImpl implements PreregistrationRepository {
  final RegisterPatientService _registerPatientService;

  PreregistrationRepositoryImpl(this._registerPatientService);

  @override
  Future<DataState<bool>> registerPatient(PatientRegisterEntity patient) async {
    try {
      // Convert Entity to Model
      final model = PatientRegisterModel(
        firstName: patient.firstName,
        midName: patient.midName,
        lastName: patient.lastName,
        gender: patient.gender,
        phone: patient.phone,
        address: patient.address,
        email: patient.email,
        dob: patient.dob,
        maritalStatus: patient.maritalStatus,
        bloodId: patient.bloodId,
        hobbyId: patient.hobbyId,
        personalId: patient.personalId,
        emergencyName: patient.emergencyName,
        emergencyPhone: patient.emergencyPhone,
        allergies: patient.allergies,
        diseases: patient.diseases,
        medications: patient.medications,
        surgeries: patient.surgeries,
        history: patient.history,
      );

      final result = await _registerPatientService.submitPatientData(model);

      if (result) {
        return const DataSuccess(true);
      } else {
        return const DataFailed('Failed to register patient');
      }
    } on AppException catch (e) {
      return DataFailed(e.toString());
    } catch (e) {
      final appException = ExceptionHandler.handle(e);
      return DataFailed(appException.toString());
    }
  }
}