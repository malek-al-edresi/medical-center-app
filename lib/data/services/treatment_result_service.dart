import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/treatment_result_model.dart';
import '../../core/constants.dart';

class TreatmentResultService {
  Future<List<TreatmentResultModel>> fetchTreatmentResults(String invoiceId) async {
    try {
      final url = Uri.parse(ApiConstSystemAll.baseTreatmentUrl + invoiceId);
      final response = await http.get(url);

      print("🔗 Requested Diagnosis URL: $url");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("📥 Raw Diagnosis Response Body: $data");

        if (data['items'] != null && data['items'] is List && data['items'].isNotEmpty) {
          final items = data['items'];
          print("✅ Diagnosis Results Count: ${items.length}");
          return items.map<TreatmentResultModel>((item) {
            print("💊 Treatment Result Item: $item");
            return TreatmentResultModel.fromJson(item);
          }).toList();
        } else {
          print("⚠️ No treatment results found in items[]");
        }
      } else {
        print("❌ Server responded with status code: ${response.statusCode}");
      }
      return [];
    } catch (e) {
      print("🚨 Exception caught in fetchTreatmentResults: $e");
      return [];
    }
  }
}
