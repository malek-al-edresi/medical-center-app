
class DiagnosisResult {
  final String patientName;
  final String patientPhone;
  final String gender;
  final String appointmentId;
  final String dateStart;
  final String doctorName;
  final String clinicName;
  final String diagnosisDate;
  final String fullNameRadiology;
  final String diagnosisDescription;
  final String invoiceId;
  final String fullNameTest;
  final String testType;
  final String fullReadyDiag;
  final String details;
  final String doctorNotes;

  DiagnosisResult({
    required this.patientName,
    required this.patientPhone,
    required this.gender,
    required this.appointmentId,
    required this.dateStart,
    required this.doctorName,
    required this.clinicName,
    required this.diagnosisDate,
    required this.fullNameRadiology,
    required this.diagnosisDescription,
    required this.invoiceId,
    required this.fullNameTest,
    required this.testType,
    required this.fullReadyDiag,
    required this.details,
    required this.doctorNotes,
  });

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) {
    return DiagnosisResult(
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
