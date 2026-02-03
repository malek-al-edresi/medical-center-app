import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'core/theme/app_theme.dart';
import 'core/localization/app_localizations.dart';
import 'core/constants/app_strings.dart';

import 'data/datasources/remote/medical_api_service.dart';
import 'data/repositories/medical_repository_impl.dart';

import 'domain/usecases/get_patient_by_invoice.dart';
import 'domain/usecases/get_lab_results.dart';
import 'domain/usecases/get_radiology_results.dart';
import 'domain/usecases/get_diagnosis.dart';
import 'domain/usecases/get_treatment.dart';

import 'presentation/blocs/language/language_cubit.dart';
import 'presentation/blocs/language/language_state.dart';
import 'presentation/blocs/patient/patient_cubit.dart';

import 'presentation/routes/app_routes.dart';
import 'core/network/my_http_overrides.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Dependency Injection setup
    final http.Client httpClient = http.Client();
    final apiService = MedicalApiService(client: httpClient);
    final repository = MedicalRepositoryImpl(apiService);

    final getPatient = GetPatientByInvoice(repository);
    final getLabResults = GetLabResults(repository);
    final getRadiologyResults = GetRadiologyResults(repository);
    final getDiagnosis = GetDiagnosis(repository);
    final getTreatment = GetTreatment(repository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(
          create: (_) => PatientCubit(
            getPatient: getPatient,
            getLabResults: getLabResults,
            getRadiologyResults: getRadiologyResults,
            getDiagnosis: getDiagnosis,
            getTreatment: getTreatment,
          ),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,

            // Theme
            theme: AppTheme.lightTheme,

            // Localization
            locale: languageState.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) return supportedLocales.first;
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },

            // Navigation
            initialRoute: AppRoutes.home,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
