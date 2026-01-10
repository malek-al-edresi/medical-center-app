import '../../domain/entities/radiology_entity.dart';

class RadiologyModel extends RadiologyEntity {
  const RadiologyModel({
    required super.resultDate,
    required super.testName,
    required super.readyResultDescription,
    required super.resultSummary,
    required super.screeningDevice,
    required super.resultDescription,
    required super.patientName,
    required super.employeeName,
  });

  factory RadiologyModel.fromJson(Map<String, dynamic> json) {
    return RadiologyModel(
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
