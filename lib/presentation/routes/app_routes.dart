import 'package:flutter/material.dart';

import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/patient_screen.dart' as patient;
import '../screens/examination_result_screen.dart';
import '../screens/lab_result_screen.dart';
import '../screens/radiology_result_screen.dart' as radiology;
import '../screens/treatment_result_screen.dart';
import '../screens/diagnosis_screen.dart';
import '../screens/register_data_patient_screen.dart';

import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) =>
              args is String ? LoginScreen(invoiceId: args) : _errorPage(),
        );
      case RouteNames.patient:
        return MaterialPageRoute(
          builder: (_) => args is String
              ? patient.PatientScreen(invoiceId: args)
              : _errorPage(),
        );
      case RouteNames.examination:
        return MaterialPageRoute(
          builder: (_) => args is String
              ? ExaminationResultScreen(invoiceId: args)
              : _errorPage(),
        );
      case RouteNames.lab:
        return MaterialPageRoute(
          builder: (_) =>
              args is String ? LabResultScreen(invoiceId: args) : _errorPage(),
        );
      case RouteNames.radiology:
        return MaterialPageRoute(
          builder: (_) => args is String
              ? radiology.RadiologyResultScreen(invoiceId: args)
              : _errorPage(),
        );
      case RouteNames.treatment:
        return MaterialPageRoute(
          builder: (_) => args is String
              ? TreatmentResultScreen(invoiceId: args)
              : _errorPage(),
        );
      case RouteNames.diagnosis:
        return MaterialPageRoute(
          builder: (_) =>
              args is String ? DiagnosisScreen(invoiceId: args) : _errorPage(),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) =>
              args is String ? HomeScreen(invoiceId: args) : _errorPage(),
        );
      case RouteNames.registerPatient:
        return MaterialPageRoute(
          builder: (_) =>  const RegisterDataPatientScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) => _errorPage());
    }
  }

  static Widget _errorPage() =>
      const Scaffold(body: Center(child: Text('حدث خطأ أثناء التوجيه')));
}
