import '../../domain/entities/diagnosis_result.dart';

class DiagnosisResultModel extends DiagnosisResult {
  DiagnosisResultModel({
    required super.patientName,
    required super.patientPhone,
    required super.gender,
    required super.appointmentId,
    required super.dateStart,
    required super.doctorName,
    required super.clinicName,
    required super.diagnosisDate,
    required super.fullNameRadiology,
    required super.diagnosisDescription,
    required super.invoiceId,
    required super.fullNameTest,
    required super.testType,
    required super.fullReadyDiag,
    required super.details,
    required super.doctorNotes,
  });

  factory DiagnosisResultModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisResultModel(
      patientName: json['patient_name'] ?? '',
      patientPhone: json['patient_phone'] ?? '',
      gender: json['gender'] ?? '',
      appointmentId: json['appointmentid'] ?? '',
      dateStart: json['date_start'] ?? '',
      doctorName: json['doctor_name'] ?? '',
      clinicName: json['clinic_name'] ?? '',
      diagnosisDate: json['diagnosisdate'] ?? '',
      fullNameRadiology: json['full_name_radiology'] ?? '',
      diagnosisDescription: json['diagnosis_description'] ?? '',
      invoiceId: json['invoiceid'] ?? '',
      fullNameTest: json['full_name_test'] ?? '',
      testType: json['test_type'] ?? '',
      fullReadyDiag: json['full_ready_diag'] ?? '',
      details: json['details'] ?? '',
      doctorNotes: json['doctor_notes'] ?? '',
    );
  }
}
