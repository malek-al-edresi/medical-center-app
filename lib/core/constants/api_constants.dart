class ApiConstants {
  static const String _baseUrl =
      "https://192.168.0.136:8443/ords/medical_sys_api";

  static const String patientProfile =
      "$_baseUrl/basic_sec_api/basic_sec_view_r_profile_patient";
  static const String labResults =
      "$_baseUrl/lab_sec_api/lab_sec_view_r_results_test_patient";
  static const String radiologyResults =
      "$_baseUrl/radiology_sec_api/radiology_sec_view_r_result_patient";
  static const String diagnosis =
      "$_baseUrl/basic_sec_api/basic_sec_view_r_diagnosis";
  static const String treatment =
      "$_baseUrl/basic_sec_api/basic_sec_view_r_treatment";
  static const String preregistration =
      "$_baseUrl/basic_sec_api/register_data_patient";
}
