import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/localization/app_localizations.dart';
import '../../domain/entities/treatment_entity.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';

/// Screen displaying patient treatment records.
///
/// Consumes [PatientCubit] state — does NOT contain business logic.
class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization?.translate('treatment') ?? 'Treatment'),
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
          return ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            itemCount: treatmentList.length,
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

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
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
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.medication,
                        size: 14,
                        color: Colors.teal,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        treatment.typeName.isNotEmpty
                            ? treatment.typeName
                            : 'Drug',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingS),
            const Divider(),

            // Dosage information
            if (treatment.dosageDescription.isNotEmpty) ...[
              _InfoRow(
                icon: Icons.schedule,
                label: 'Dosage',
                value: treatment.dosageDescription,
              ),
              const SizedBox(height: AppDimensions.paddingS),
            ],

            // Duration
            if (treatment.treatmentDuration.isNotEmpty) ...[
              _InfoRow(
                icon: Icons.timer,
                label: 'Duration',
                value: treatment.treatmentDuration,
              ),
              const SizedBox(height: AppDimensions.paddingS),
            ],

            // Administration method
            if (treatment.administrationMethod.isNotEmpty) ...[
              _InfoRow(
                icon: Icons.medical_services,
                label: 'Method',
                value: treatment.administrationMethod,
              ),
              const SizedBox(height: AppDimensions.paddingS),
            ],

            // Warnings (if available)
            if (treatment.warnings.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.paddingS),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.amber.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber,
                      size: 18,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        treatment.warnings,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.amber.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Treatment description (if available)
            if (treatment.treatmentDescription.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.paddingS),
              Text(
                treatment.treatmentDescription,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
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
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}
