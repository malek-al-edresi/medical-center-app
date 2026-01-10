import '../../domain/entities/patient_entity.dart';

class PatientModel extends PatientEntity {
  const PatientModel({
    required super.patientId,
    required super.fullName,
    required super.phone,
    required super.address,
    required super.email,
    required super.gender,
    required super.birthDate,
    required super.maritalStatus,
    required super.bloodType,
    required super.hobbyTypeId,
    required super.personalNumberId,
    required super.emergencyName,
    required super.emergencyPhone,
    required super.allergies,
    required super.chronicDiseases,
    required super.medications,
    required super.surgeries,
    required super.medicalHistory,
    required super.photo,
    required super.invoiceCount,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      patientId: json['patientid']?.toString() ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone_primary'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      birthDate: json['dateofbirth'] ?? '',
      maritalStatus: json['maritalstatus'] ?? '',
      bloodType: json['bloodtype'] ?? '',
      hobbyTypeId: json['personalhobbytypeid']?.toString() ?? '',
      personalNumberId: json['personalnumberid'] ?? '',
      emergencyName: json['emergencycontactname'] ?? '',
      emergencyPhone: json['emergencycontactphone'] ?? '',
      allergies: json['allergies'] ?? '',
      chronicDiseases: json['chronicdiseases'] ?? '',
      medications: json['currentmedications'] ?? '',
      surgeries: json['previoussurgeries'] ?? '',
      medicalHistory: json['medicalhistory'] ?? '',
      photo: json['photo_patient'] ?? '',
      invoiceCount:
          int.tryParse(json['count_invoiceid']?.toString() ?? '') ?? 0,
    );
  }
}
