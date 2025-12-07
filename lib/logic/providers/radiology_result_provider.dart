
import 'package:flutter/material.dart';
import '../../domain/entities/radiology_result.dart';
import '../../domain/usecases/get_radiology_results.dart';

class RadiologyResultProvider with ChangeNotifier {
  final GetRadiologyResults getRadiologyResultsUseCase;

  RadiologyResultProvider(this.getRadiologyResultsUseCase);

  List<RadiologyResult> _results = [];
  bool _isLoading = false;

  List<RadiologyResult> get results => _results;
  bool get isLoading => _isLoading;

  Future<void> fetchResults(String invoiceId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _results = await getRadiologyResultsUseCase.call(invoiceId);
    } catch (e) {
      _results = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
