import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patient_model.dart';
import '../../core/constants.dart';

class PatientService {
  Future<List<PatientModel>> fetchPatientResult(String invoiceId) async {
    try {
      final url = Uri.parse(ApiConstSystemAll.basePatientUrl + invoiceId);
      final response = await http.get(url);

      print("🔗 Requested URL: $url");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("📥 Raw Response Body: $data");

        if (data['items'] != null && data['items'] is List && data['items'].isNotEmpty) {
          final List<dynamic> items = data['items'];

          final patients = items.map((json) => PatientModel.fromJson(json)).toList();

          print("✅ Fetched ${patients.length} patients");
          return patients;
        } else {
          print("⚠️ No patient data found in items[]");
          return [];
        }
      } else {
        print("❌ Server responded with status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("🚨 Exception caught in fetchPatient: $e");
      throw http.ClientException("Error in PatientService.fetchPatient: ${e.toString()}");
    }
  }

}
