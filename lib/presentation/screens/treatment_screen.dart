import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/localization/app_localizations.dart';
import '../../domain/entities/treatment_entity.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';
import '../widgets/app_card.dart';
import '../layout/app_scaffold.dart';

/// Screen displaying patient treatment records.
///
/// Consumes [PatientCubit] state — does NOT contain business logic.
class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return AppScaffold(
      title: localization?.translate('treatment') ?? 'Treatment',
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          // Loading state
          if (state is PatientLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error or non-loaded states
          if (state is! PatientLoaded) {
            return EmptyState(
              message: localization?.translate('noData') ?? 'No Treatment Data',
              icon: Icons.medication_outlined,
            );
          }

          final treatmentList = state.treatment;

          // Empty data state
          if (treatmentList.isEmpty) {
            return EmptyState(
              message:
                  localization?.translate('noData') ?? 'No Treatment Records',
              icon: Icons.medication_outlined,
            );
          }

          // Loaded state with data
          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.md),
            itemCount: treatmentList.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppDimensions.md),
            itemBuilder: (context, index) {
              final treatment = treatmentList[index];
              return _TreatmentCard(treatment: treatment);
            },
          );
        },
      ),
    );
  }
}

/// Card widget displaying individual treatment/medication information.
class _TreatmentCard extends StatelessWidget {
  final TreatmentEntity treatment;

  const _TreatmentCard({required this.treatment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Drug name and brand
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      treatment.drugName.isNotEmpty
                          ? treatment.drugName
                          : 'Medication',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    if (treatment.brandName.isNotEmpty)
                      Text(
                        treatment.brandName,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.medication, size: 14, color: Colors.teal),
                    const SizedBox(width: 4),
                    Text(
                      treatment.typeName.isNotEmpty
                          ? treatment.typeName
                          : 'Drug',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.md),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: AppDimensions.md),

          // Dosage information
          if (treatment.dosageDescription.isNotEmpty) ...[
            _InfoRow(
              icon: Icons.schedule,
              label: 'Dosage',
              value: treatment.dosageDescription,
            ),
            const SizedBox(height: AppDimensions.sm),
          ],

          // Duration
          if (treatment.treatmentDuration.isNotEmpty) ...[
            _InfoRow(
              icon: Icons.timer,
              label: 'Duration',
              value: treatment.treatmentDuration,
            ),
            const SizedBox(height: AppDimensions.sm),
          ],

          // Administration method
          if (treatment.administrationMethod.isNotEmpty) ...[
            _InfoRow(
              icon: Icons.medical_services_outlined,
              label: 'Method',
              value: treatment.administrationMethod,
            ),
            const SizedBox(height: AppDimensions.sm),
          ],

          // Warnings (if available)
          if (treatment.warnings.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.md),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 20,
                    color: Colors.amber.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      treatment.warnings,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.amber.shade800,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Treatment description (if available)
          if (treatment.treatmentDescription.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.md),
            Text(
              treatment.treatmentDescription,
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Helper widget for displaying labeled information rows.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textLight),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
