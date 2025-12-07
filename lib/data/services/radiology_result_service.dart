
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/radiology_result_model.dart';
import '../../core/constants.dart';

class RadiologyResultService {
  Future<List<RadiologyResultModel>> fetchRadiologyResults(String invoiceId) async {
    try {
      final url = Uri.parse(ApiConstSystemAll.baseRadiologyResultUrl + invoiceId);
      final response = await http.get(url);


      print("🔗 Requested Radiology URL: $url");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("📥 Raw Radiology Response Body: $data");

        if (data['items'] != null && data['items'] is List && data['items'].isNotEmpty) {
          final items = data['items'];
          print("✅ Radiology Results Count: ${items.length}");
          return items.map<RadiologyResultModel>((item) {
            print("🖼 Radiology Result Item: $item");
            return RadiologyResultModel.fromJson(item);
          }).toList();
        } else {
          print("⚠️ No radiology results found in items[]");
        }
      } else {
        print("❌ Server responded with status code: ${response.statusCode}");
      }
      return [];
    } catch (e) {
      print("🚨 Exception caught in fetchRadiologyResults: \$e");
      return [];
    }
  }
}
