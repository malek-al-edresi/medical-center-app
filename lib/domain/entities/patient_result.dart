
class PatientResult {
  final String patientId;
  final String fullName;
  final String phone;
  final String address;
  final String email;
  final String gender;
  final String birthDate;
  final String maritalStatus;
  final String bloodType;
  final String hobbyTypeId;
  final String personalNumberId;
  final String emergencyName;
  final String emergencyPhone;
  final String allergies;
  final String chronicDiseases;
  final String medications;
  final String surgeries;
  final String medicalHistory;
  final String photo;
  final int invoiceCount;

  PatientResult({
    required this.patientId,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.maritalStatus,
    required this.bloodType,
    required this.hobbyTypeId,
    required this.personalNumberId,
    required this.emergencyName,
    required this.emergencyPhone,
    required this.allergies,
    required this.chronicDiseases,
    required this.medications,
    required this.surgeries,
    required this.medicalHistory,
    required this.photo,
    required this.invoiceCount,
  });
}
