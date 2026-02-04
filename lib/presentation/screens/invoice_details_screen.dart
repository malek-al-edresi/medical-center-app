import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/localization/app_localizations.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';
import '../routes/app_routes.dart';
import '../shared/widgets/patient_info_card.dart';
import '../shared/widgets/section_card.dart';
import '../../core/widgets/empty_state.dart';
import '../layout/app_scaffold.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return BlocBuilder<PatientCubit, PatientState>(
      builder: (context, state) {
        // Handle non-loaded states
        if (state is! PatientLoaded) {
          return const AppScaffold(
            title: 'Error',
            body: EmptyState(message: 'No patient data loaded'),
          );
        }

        final patient = state.patient;

        return AppScaffold(
          title:
              '${localization?.translate('patientId')}: ${patient.patientId}',
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.md,
                    vertical: AppDimensions.sm,
                  ),
                  child: PatientInfoCard(patient: patient),
                ).animate().fadeIn().slideY(begin: 0.1, end: 0),

                const SizedBox(height: AppDimensions.md),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.xs,
                              vertical: AppDimensions.xs,
                            ),
                            child: Text(
                              "Clinical Records",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .slideX(begin: -0.1, end: 0),
                      const SizedBox(height: AppDimensions.sm),

                      // Diagnosis Section
                      SectionCard(
                            title:
                                localization?.translate('diagnosis') ??
                                'Diagnosis',
                            subtitle: '${state.diagnosis.length} Records',
                            icon: Icons.assignment_outlined,
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.diagnosis);
                            },
                            iconColor: Colors.orange,
                          )
                          .animate()
                          .fadeIn(delay: 300.ms)
                          .slideX(begin: 0.1, end: 0),

                      // Treatment Section
                      SectionCard(
                            title:
                                localization?.translate('treatment') ??
                                'Treatment',
                            subtitle: '${state.treatment.length} Records',
                            icon: Icons.medication_outlined,
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.treatment);
                            },
                            iconColor: Colors.teal,
                          )
                          .animate()
                          .fadeIn(delay: 400.ms)
                          .slideX(begin: 0.1, end: 0),

                      const SizedBox(height: AppDimensions.md),

                      Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.xs,
                              vertical: AppDimensions.xs,
                            ),
                            child: Text(
                              "Test Results",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 500.ms)
                          .slideX(begin: -0.1, end: 0),
                      const SizedBox(height: AppDimensions.sm),

                      // Lab Results Section
                      SectionCard(
                            title:
                                localization?.translate('labResults') ??
                                'Lab Results',
                            subtitle: '${state.labResults.length} Records',
                            icon: Icons.science_outlined,
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.labResults,
                            ),
                            iconColor: AppColors.primary,
                          )
                          .animate()
                          .fadeIn(delay: 600.ms)
                          .slideX(begin: 0.1, end: 0),

                      // Radiology Section
                      SectionCard(
                            title:
                                localization?.translate('radiology') ??
                                'Radiology',
                            subtitle: '${state.radiologyResults.length} Images',
                            icon: Icons.image_outlined,
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.radiology,
                            ),
                            iconColor: Colors.purple,
                          )
                          .animate()
                          .fadeIn(delay: 700.ms)
                          .slideX(begin: 0.1, end: 0),

                      const SizedBox(height: AppDimensions.xxl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
