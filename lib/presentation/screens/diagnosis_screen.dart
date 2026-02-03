import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/localization/app_localizations.dart';
import '../../domain/entities/diagnosis_entity.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';

/// Screen displaying patient diagnosis records.
///
/// Consumes [PatientCubit] state — does NOT contain business logic.
class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization?.translate('diagnosis') ?? 'Diagnosis'),
      ),
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          // Loading state
          if (state is PatientLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error or non-loaded states
          if (state is! PatientLoaded) {
            return EmptyState(
              message: localization?.translate('noData') ?? 'No Diagnosis Data',
              icon: Icons.assignment_outlined,
            );
          }

          final diagnosisList = state.diagnosis;

          // Empty data state
          if (diagnosisList.isEmpty) {
            return EmptyState(
              message:
                  localization?.translate('noData') ?? 'No Diagnosis Records',
              icon: Icons.assignment_outlined,
            );
          }

          // Loaded state with data
          return ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            itemCount: diagnosisList.length,
            itemBuilder: (context, index) {
              final diagnosis = diagnosisList[index];
              return _DiagnosisCard(diagnosis: diagnosis);
            },
          );
        },
      ),
    );
  }
}

/// Card widget displaying individual diagnosis information.
class _DiagnosisCard extends StatelessWidget {
  final DiagnosisEntity diagnosis;

  const _DiagnosisCard({required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Diagnosis title and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    diagnosis.fullReadyDiag.isNotEmpty
                        ? diagnosis.fullReadyDiag
                        : 'Diagnosis',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                if (diagnosis.diagnosisDate.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      diagnosis.diagnosisDate.split(' ').first,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingS),

            // Description
            if (diagnosis.diagnosisDescription.isNotEmpty) ...[
              Text(
                diagnosis.diagnosisDescription,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppDimensions.paddingS),
            ],

            const Divider(),

            // Doctor and Clinic info
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    diagnosis.doctorName.isNotEmpty
                        ? diagnosis.doctorName
                        : 'Unknown Doctor',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                if (diagnosis.clinicName.isNotEmpty) ...[
                  const Icon(
                    Icons.local_hospital,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(diagnosis.clinicName, style: theme.textTheme.bodySmall),
                ],
              ],
            ),

            // Doctor notes (if available)
            if (diagnosis.doctorNotes.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.paddingS),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doctor Notes:',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      diagnosis.doctorNotes,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Additional details (if available)
            if (diagnosis.details.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.paddingS),
              Text(
                'Details: ${diagnosis.details}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
