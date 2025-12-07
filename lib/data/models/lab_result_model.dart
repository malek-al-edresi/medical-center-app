
import '../../domain/entities/lab_result.dart';

class LabResultModel extends LabResult {
  LabResultModel({
    required String resultDate,
    required String valueResult,
    required String valueName,
    required String valueMaximum,
    required String valueMinimum,
    required String unitName,
    required String testName,
    required String patientName,
    required String doctorName,
    required String clinicName,
    required String diagnosisDate,

    required String fullDiagnosis,
  }) : super(
    resultDate: resultDate,
    valueResult: valueResult,
    valueName: valueName,
    valueMaximum: valueMaximum,
    valueMinimum: valueMinimum,
    unitName: unitName,
    testName: testName,
    patientName: patientName,
    doctorName: doctorName,
    clinicName: clinicName,
    diagnosisDate: diagnosisDate,
    fullDiagnosis: fullDiagnosis,
  );

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
