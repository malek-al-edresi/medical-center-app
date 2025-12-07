class PatientRegisterEntity {
  final String firstName;
  final String midName;
  final String lastName;
  final String gender;
  final String phone;
  final String address;
  final String email;
  final String dob;
  final String maritalStatus;
  final int bloodId;
  final int hobbyId;
  final String personalId;
  final String emergencyName;
  final String emergencyPhone;
  final String allergies;
  final String diseases;
  final String medications;
  final String surgeries;
  final String history;

  PatientRegisterEntity({
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.gender,
    required this.phone,
    required this.address,
    required this.email,
    required this.dob,
    required this.maritalStatus,
    required this.bloodId,
    required this.hobbyId,
    required this.personalId,
    required this.emergencyName,
    required this.emergencyPhone,
    required this.allergies,
    required this.diseases,
    required this.medications,
    required this.surgeries,
    required this.history,
  });
}