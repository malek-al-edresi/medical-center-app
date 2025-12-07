import 'package:flutter/material.dart';
import '../../../domain/entities/patient_result.dart';
import '../../../domain/usecases/get_all_patients.dart';

class PatientProvider with ChangeNotifier {
  final GetAllPatients getAllPatientsUseCase;

  PatientProvider(this.getAllPatientsUseCase);

  List<PatientResult> _patients = [];
  bool _isLoading = false;

  List<PatientResult> get patients => _patients;
  bool get isLoading => _isLoading;

  Future<void> fetchResults(String invoiceId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _patients = await getAllPatientsUseCase.call(invoiceId);
    } catch (e) {
      debugPrint('Error fetching patients: \$e');
      _patients = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
