class DiagnosisEntity {
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

  const DiagnosisEntity({
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
}
