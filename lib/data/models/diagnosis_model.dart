import '../../domain/entities/diagnosis_entity.dart';

class DiagnosisModel extends DiagnosisEntity {
  const DiagnosisModel({
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

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      patientName: json['PATIENT_NAME'] ?? '',
      patientPhone: json['PATIENT_PHONE'] ?? '',
      gender: json['GENDER'] ?? '',
      appointmentId: json['APPOINTMENTID'] ?? '',
      dateStart: json['DATE_START'] ?? '',
      doctorName: json['DOCTOR_NAME'] ?? '',
      clinicName: json['CLINIC_NAME'] ?? '',
      diagnosisDate: json['DIAGNOSISDATE'] ?? '',
      fullNameRadiology: json['FULL_NAME_RADIOLOGY'] ?? '',
      diagnosisDescription: json['DIAGNOSIS_DESCRIPTION'] ?? '',
      invoiceId: json['INVOICEID'] ?? '',
      fullNameTest: json['FULL_NAME_TEST'] ?? '',
      testType: json['TEST_TYPE'] ?? '',
      fullReadyDiag: json['FULL_READY_DIAG'] ?? '',
      details: json['DETAILS'] ?? '',
      doctorNotes: json['DOCTOR_NOTES'] ?? '',
    );
  }
}
