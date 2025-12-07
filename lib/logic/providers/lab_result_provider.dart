
import 'package:flutter/material.dart';
import '../../domain/entities/lab_result.dart';
import '../../domain/usecases/get_lab_results.dart';

class LabResultProvider with ChangeNotifier {
  final GetLabResults getLabResultsUseCase;

  LabResultProvider(this.getLabResultsUseCase);

  List<LabResult> _labResults = [];
  bool _isLoading = false;

  List<LabResult> get labResults => _labResults;
  bool get isLoading => _isLoading;

  Future<void> fetchResults(String invoiceId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _labResults = await getLabResultsUseCase.call(invoiceId);
    } catch (e) {
      _labResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
