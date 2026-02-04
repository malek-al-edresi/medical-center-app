import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/localization/app_localizations.dart';
import '../../domain/entities/diagnosis_entity.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';
import '../shared/widgets/app_card.dart';
import '../layout/app_scaffold.dart';

/// Screen displaying patient diagnosis records.
///
/// Consumes [PatientCubit] state — does NOT contain business logic.
class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return AppScaffold(
      title: localization?.translate('diagnosis') ?? 'Diagnosis',
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
          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.md),
            itemCount: diagnosisList.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppDimensions.md),
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

    return AppCard(
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
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  ),
                  child: Text(
                    diagnosis.diagnosisDate.split(' ').first,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppDimensions.sm),

          // Description
          if (diagnosis.diagnosisDescription.isNotEmpty) ...[
            Text(
              diagnosis.diagnosisDescription,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.md),
          ],

          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: AppDimensions.md),

          // Doctor and Clinic info
          Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.background,
                child: Icon(
                  Icons.person,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  diagnosis.doctorName.isNotEmpty
                      ? diagnosis.doctorName
                      : 'Unknown Doctor',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          if (diagnosis.clinicName.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.background,
                  child: Icon(
                    Icons.local_hospital,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  diagnosis.clinicName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],

          // Doctor notes (if available)
          if (diagnosis.doctorNotes.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.md),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Doctor Notes:',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    diagnosis.doctorNotes,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
