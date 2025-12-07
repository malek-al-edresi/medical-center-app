import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/diagnosis_result_model.dart';
import '../../core/constants.dart';

class DiagnosisResultService {
  Future<List<DiagnosisResultModel>> fetchDiagnosisResults(String invoiceId) async {
    try {
      final url = Uri.parse(ApiConstSystemAll.baseDiagnosisUrl + invoiceId);
      final response = await http.get(url);

      print("Requested Diagnosis URL: $url");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Raw Diagnosis Response Body: $data");

        if (data['items'] != null && data['items'] is List && data['items'].isNotEmpty) {
          final items = data['items'];
          print("Diagnosis Results Count: ${items.length}");
          return items.map<DiagnosisResultModel>((item) {
            print("Diagnosis Result Item: $item");
            return DiagnosisResultModel.fromJson(item);
          }).toList();
        } else {
          print("⚠No diagnosis results found in items[]");
          return [];
        }
      } else {
        print("❌ Server responded with status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("🚨 Exception caught in fetchDiagnosisResults: $e");
      return [];
    }
  }

}
