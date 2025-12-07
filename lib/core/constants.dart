// Add your constants here
import 'package:flutter/material.dart';



class ApiConstSystemAll{
  static String basePatientUrl =
      "http://engmalek:8443/ords/medical_sys_api/basic_sec_api/basic_sec_view_r_profile_patient/";
  static String baseLabResultUrl =
      'http://engmalek:8443/ords/medical_sys_api/lab_sec_api/lab_sec_view_r_results_test_patient/';
  static String baseRadiologyResultUrl =
      'http://engmalek:8443/ords/medical_sys_api/raiology_sec_api/radiology_sec_view_r_result_patient/';
  static String baseDiagnosisUrl =
      'http://engmalek:8443/ords/medical_sys_api/basic_sec_api/basic_sec_view_r_diagnosis/';
  static String baseTreatmentUrl =
      'http://engmalek:8443/ords/medical_sys_api/basic_sec_api/basic_sec_view_r_treatment/';
  static String basePreregistrationUrl =
      'http://engmalek:8443/ords/medical_sys_api/basic_sec_api/register_data_patient';
}


// Color usd for All app
const MaterialColor kPrimaryColor = Colors.teal;
const Color kSecondaryColor = Color(0xFF00ACC1);
const Color kBackgroundColor = Color(0xFFF5F5F5);
const Color kTextColor = Colors.black87;

// Font Arabic Style
const String kArabicFont = 'Cairo';

// Format Others as padding, radius, etc
const double kDefaultPadding = 16.0;
const double kBorderRadius = 12.0;
const double kCardElevation = 3.0;


