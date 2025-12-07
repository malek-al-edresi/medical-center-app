import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';

import '../models/preregistration_model.dart';

class RegisterPatientService {
  Future<bool> submitPatientData(PatientRegisterModel model) async {
    try {
      final url = Uri.parse(ApiConstSystemAll.basePreregistrationUrl);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()),
      );

      print("📤 POST to $url");
      print("📦 Request Body: ${jsonEncode(model.toJson())}");
      print("📡 Status Code: ${response.statusCode}");
      print("📥 Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['message'] == 'SUCCESS') {
          return true;
        }
      }
      return false;
    } catch (e) {
      print("🚨 Exception: $e");
      return false;
    }
  }
}
