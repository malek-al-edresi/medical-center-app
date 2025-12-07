
import 'package:flutter/material.dart';
import '../../domain/entities/treatment_result.dart';
import '../../domain/usecases/get_treatment_results.dart';

class TreatmentResultProvider with ChangeNotifier {
  final GetTreatmentResults getTreatmentResults;

  TreatmentResultProvider(this.getTreatmentResults);

  List<TreatmentResult> _results = [];
  bool _isLoading = false;

  List<TreatmentResult> get results => _results;
  bool get isLoading => _isLoading;

  Future<void> fetchResults(String invoiceId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _results = await getTreatmentResults(invoiceId);
    } catch (e) {
      print("❌ Error fetching treatment results: \$e");
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
