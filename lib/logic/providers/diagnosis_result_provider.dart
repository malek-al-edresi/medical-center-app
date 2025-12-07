
import 'package:flutter/material.dart';
import '../../domain/entities/diagnosis_result.dart';
import '../../domain/usecases/get_diagnosis_results.dart';

class DiagnosisResultProvider with ChangeNotifier {
  final GetDiagnosisResults getDiagnosisResults;

  DiagnosisResultProvider(this.getDiagnosisResults);

  List<DiagnosisResult> _results = [];
  bool _isLoading = false;

  List<DiagnosisResult> get results => _results;
  bool get isLoading => _isLoading;

  Future<void> fetchResults(String invoiceId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _results = await getDiagnosisResults(invoiceId);
    } catch (e) {
      print("❌ Error fetching diagnosis results: \$e");
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
