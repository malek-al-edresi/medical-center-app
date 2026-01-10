import '../../domain/entities/lab_result_entity.dart';

class LabResultModel extends LabResultEntity {
  const LabResultModel({
    required super.resultDate,
    required super.valueResult,
    required super.valueName,
    required super.valueMaximum,
    required super.valueMinimum,
    required super.unitName,
    required super.testName,
    required super.patientName,
    required super.doctorName,
    required super.clinicName,
    required super.diagnosisDate,
    required super.fullDiagnosis,
  });

  factory LabResultModel.fromJson(Map<String, dynamic> json) {
    return LabResultModel(
      resultDate: json['result_date']?.toString() ?? '',
      valueResult: json['valueresult']?.toString() ?? '',
      valueName: json['valuename']?.toString() ?? '',
      valueMaximum: json['valuemaximum']?.toString() ?? '',
      valueMinimum: json['valueminumum']?.toString() ?? '',
      unitName: json['unitname']?.toString() ?? '',
      testName: json['test_name']?.toString() ?? '',
      patientName: json['full_name_patinet']?.toString() ?? '',
      doctorName: json['full_name_doctor']?.toString() ?? '',
      clinicName: json['clinic_name']?.toString() ?? '',
      diagnosisDate: json['diagnosis_date']?.toString() ?? '',
      fullDiagnosis: json['full_diagnosis']?.toString() ?? '',
    );
  }
}
