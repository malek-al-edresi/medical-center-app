
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lab_result_model.dart';
import '../../core/constants.dart';

class LabResultService {
  Future<List<LabResultModel>> fetchLabResults(String invoiceId) async {
    try {
      final url = Uri.parse(ApiConstSystemAll.baseLabResultUrl + invoiceId);
      final response = await http.get(url);

      print("🔗 Requested Lab URL: $url");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("📥 Raw Lab Response Body: $data");

        if (data['items'] != null && data['items'] is List && data['items'].isNotEmpty) {
          final items = data['items'];
          print("✅ Lab Results Count: ${items.length}");
          return items.map<LabResultModel>((item) {
            print("🧪 Lab Result Item: $item");
            return LabResultModel.fromJson(item);
          }).toList();
        } else {
          print("⚠️ No lab results found in items[]");
        }
      } else {
        print("❌ Server responded with status code: ${response.statusCode}");
      }

      return [];
    } catch (e) {
      print("🚨 Exception caught in fetchLabResults: $e");
      return [];
    }
  }
}
