class LabResultEntity {
  final String resultDate;
  final String valueResult;
  final String valueName;
  final String valueMaximum;
  final String valueMinimum;
  final String unitName;
  final String testName;
  final String patientName;
  final String doctorName;
  final String clinicName;
  final String diagnosisDate;
  final String fullDiagnosis;

  const LabResultEntity({
    required this.resultDate,
    required this.valueResult,
    required this.valueName,
    required this.valueMaximum,
    required this.valueMinimum,
    required this.unitName,
    required this.testName,
    required this.patientName,
    required this.doctorName,
    required this.clinicName,
    required this.diagnosisDate,
    required this.fullDiagnosis,
  });
}
