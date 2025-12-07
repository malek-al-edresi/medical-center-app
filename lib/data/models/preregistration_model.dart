import '../../domain/entities/preregistration_result.dart';

class PatientRegisterModel extends PatientRegisterEntity {
  PatientRegisterModel({
    required super.firstName,
    required super.midName,
    required super.lastName,
    required super.gender,
    required super.phone,
    required super.address,
    required super.email,
    required super.dob,
    required super.maritalStatus,
    required super.bloodId,
    required super.hobbyId,
    required super.personalId,
    required super.emergencyName,
    required super.emergencyPhone,
    required super.allergies,
    required super.diseases,
    required super.medications,
    required super.surgeries,
    required super.history,
  });

  // ✅ Factory: Parse JSON with 'l_' prefixed keys
  factory PatientRegisterModel.fromJson(Map<String, dynamic> json) =>
      PatientRegisterModel(
        firstName: json['l_first_name']?.toString() ?? '-',
        midName: json['l_mid_name']?.toString() ?? '-',
        lastName: json['l_last_name']?.toString() ?? '-',
        gender: json['l_gender']?.toString() ?? 'M',
        phone: json['l_phone_primary']?.toString() ?? '-',
        address: json['l_address']?.toString() ?? '-',
        email: json['l_email']?.toString() ?? '-',
        dob: json['l_date_of_birth']?.toString() ?? '-',
        maritalStatus: json['l_marital_status']?.toString() ?? '-',
        bloodId: _parseInt(json['l_bloodid']),
        hobbyId: _parseInt(json['l_personal_hobby_id']),
        personalId: json['l_personal_numberid']?.toString() ?? '-',
        emergencyName: json['l_emergency_name']?.toString() ?? '-',
        emergencyPhone: json['l_emergency_phone']?.toString() ?? '-',
        allergies: json['l_allergies']?.toString() ?? '-',
        diseases: json['l_diseases']?.toString() ?? '-',
        medications: json['l_medications']?.toString() ?? '-',
        surgeries: json['l_surgeries']?.toString() ?? '-',
        history: json['l_history']?.toString() ?? '-',
      );

  // ✅ Helper to safely parse int from int or string
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  // ✅ Convert back to JSON with same 'l_' structure
  Map<String, dynamic> toJson() {
    String formattedDob = _convertToISOFormat(dob);

    return {
      'l_first_name': firstName,
      'l_mid_name': midName,
      'l_last_name': lastName,
      'l_gender': gender,
      'l_phone_primary': phone,
      'l_address': address,
      'l_email': email,
      'l_date_of_birth': formattedDob,
      'l_marital_status': maritalStatus,
      'l_bloodid': bloodId,
      'l_personal_hobby_id': hobbyId,
      'l_personal_numberid': personalId,
      'l_emergency_name': emergencyName,
      'l_emergency_phone': emergencyPhone,
      'l_allergies': allergies,
      'l_diseases': diseases,
      'l_medications': medications,
      'l_surgeries': surgeries,
      'l_history': history,
    };
  }

  // ✅ تحويل من dd-MM-yyyy إلى yyyy-MM-dd للإرسال
  static String _convertToISOFormat(String input) {
    try {
      List<String> parts = input.split('-');
      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);

        return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
      }
    } catch (e) {
      // إذا فشل التحويل، نعيد التاريخ كما هو
      return input;
    }
    return input;
  }

  // Convert Format Data Form YYYY-MM-DD For DD-MM-YYYY
  static String formatForDisplay(String isoDate) {
    try {
      List<String> parts = isoDate.split('-');
      if (parts.length == 3) {
        int year = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int day = int.parse(parts[2]);

        return '${day.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}-$year';
      }
    } catch (e) {
      return isoDate;
    }
    return isoDate;
  }
}