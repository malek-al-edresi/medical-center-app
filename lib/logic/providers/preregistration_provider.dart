import 'package:flutter/material.dart';
import '../../domain/entities/preregistration_result.dart';
import '../../core/exceptions/app_exception.dart';

import '../../domain/usecases/get_preregistration.dart';

class PatientRegisterProvider with ChangeNotifier {
  final RegisterPatientUseCase _registerPatientUseCase;

  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = '';
  AppException? _exception;

  PatientRegisterProvider(this._registerPatientUseCase);

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String get errorMessage => _errorMessage;
  AppException? get exception => _exception;

  Future<void> registerPatient(PatientRegisterEntity patient) async {
    _isLoading = true;
    _isSuccess = false;
    _errorMessage = '';
    _exception = null;
    notifyListeners();

    try {
      final bool result = await _registerPatientUseCase(patient);

      _isSuccess = result;
      if (!result) {
        _errorMessage = 'Failed to register patient';
      }
    } on AppException catch (e) {
      _isSuccess = false;
      _errorMessage = e.toString();
      _exception = e;
    } catch (e) {
      _isSuccess = false;
      _errorMessage = 'An unexpected error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isSuccess = false;
    _errorMessage = '';
    _exception = null;
    _isLoading = false;
    notifyListeners();
  }
}