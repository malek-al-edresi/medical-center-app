import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/preregistration_repository_impl.dart';
import 'data/services/navigation_service.dart';

// Services
import 'data/services/patient_service.dart';
import 'data/services/lab_result_service.dart';
import 'data/services/preregistration_service.dart';
import 'data/services/radiology_result_service.dart';
import 'data/services/diagnosis_result_service.dart';
import 'data/services/treatment_result_service.dart';

// Repositories
import 'data/repositories/patient_repository_impl.dart';
import 'data/repositories/lab_result_repository_impl.dart';
import 'data/repositories/radiology_result_repository_impl.dart';
import 'data/repositories/diagnosis_result_repository_impl.dart';
import 'data/repositories/treatment_result_repository_impl.dart';

// Use Cases
import 'domain/usecases/get_all_patients.dart';
import 'domain/usecases/get_lab_results.dart';
import 'domain/usecases/get_radiology_results.dart';
import 'domain/usecases/get_diagnosis_results.dart';
import 'domain/usecases/get_treatment_results.dart';

// Routing
import 'domain/usecases/register_patient_usecase_impl.dart';
import 'logic/providers/preregistration_provider.dart';
import 'presentation/routes/app_routes.dart';

// Providers
import 'logic/providers/patient_provider.dart';
import 'logic/providers/lab_result_provider.dart';
import 'logic/providers/radiology_result_provider.dart';
import 'logic/providers/diagnosis_result_provider.dart';
import 'logic/providers/treatment_result_provider.dart';

void main() {
  runApp(const MedicalCenterApp());
}

class MedicalCenterApp extends StatelessWidget {
  const MedicalCenterApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Services
    final patientService = PatientService();
    final labService = LabResultService();
    final radiologyService = RadiologyResultService();
    final diagnosisService = DiagnosisResultService();
    final treatmentService = TreatmentResultService();
    final preregistrationService = RegisterPatientService();


    // Repositories
    final patientRepo = PatientRepositoryImpl(patientService);
    final labRepo = LabResultRepositoryImpl(labService);
    final radiologyRepo = RadiologyResultRepositoryImpl(radiologyService);
    final diagnosisRepo = DiagnosisResultRepositoryImpl(diagnosisService);
    final treatmentRepo = TreatmentResultRepositoryImpl(treatmentService);
    final preregistrationRepo = PreregistrationRepositoryImpl(preregistrationService);


    // Use Cases
    final getAllPatients = GetAllPatients(patientRepo);
    final getLabResults = GetLabResults(labRepo);
    final getRadiologyResults = GetRadiologyResults(radiologyRepo);
    final getDiagnosisResults = GetDiagnosisResults(diagnosisRepo);
    final getTreatmentResults = GetTreatmentResults(treatmentRepo);
    final registerPatientUseCase = RegisterPatientUseCaseImpl(preregistrationRepo);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider(getAllPatients)),
        ChangeNotifierProvider(create: (_) => LabResultProvider(getLabResults)),
        ChangeNotifierProvider(
          create: (_) => RadiologyResultProvider(getRadiologyResults),
        ),
        ChangeNotifierProvider(
          create: (_) => DiagnosisResultProvider(getDiagnosisResults),
        ),
        ChangeNotifierProvider(
          create: (_) => TreatmentResultProvider(getTreatmentResults),
        ),
        ChangeNotifierProvider(
          create: (_) => PatientRegisterProvider(registerPatientUseCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medical Center',
        theme: AppTheme.lightTheme,
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/welcome',
        onGenerateRoute: AppRoutes.generateRoute,
        locale: const Locale('ar'),
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
