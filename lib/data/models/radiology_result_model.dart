
import '../../domain/entities/radiology_result.dart';

class RadiologyResultModel extends RadiologyResult {
  RadiologyResultModel({
    required String resultDate,
    required String testName,
    required String readyResultDescription,
    required String resultSummary,
    required String screeningDevice,
    required String resultDescription,
    required String patientName,
    required String employeeName,
  }) : super(
    resultDate: resultDate,
    testName: testName,
    readyResultDescription: readyResultDescription,
    resultSummary: resultSummary,
    screeningDevice: screeningDevice,
    resultDescription: resultDescription,
    patientName: patientName,
    employeeName: employeeName,
  );

  factory RadiologyResultModel.fromJson(Map<String, dynamic> json) {
    return RadiologyResultModel(
      resultDate: json['result_date'] ?? '',
      testName: json['full_name_radiology_test'] ?? '',
      readyResultDescription: json['ready_result_description'] ?? '',
      resultSummary: json['result_summary'] ?? '',
      screeningDevice: json['screening_device'] ?? '',
      resultDescription: json['result_description'] ?? '',
      patientName: json['full_name_patient'] ?? '',
      employeeName: json['full_name_employee'] ?? '',
    );
  }
}
