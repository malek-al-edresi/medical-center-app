import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/empty_state.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';
import '../../domain/entities/lab_result_entity.dart';
import '../../core/localization/app_localizations.dart';
import '../shared/widgets/app_card.dart';
import '../layout/app_scaffold.dart';

class LabResultsScreen extends StatelessWidget {
  const LabResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title:
          AppLocalizations.of(context)?.translate('labResults') ??
          'Lab Results',
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          if (state is! PatientLoaded) {
            return EmptyState(
              message:
                  AppLocalizations.of(context)?.translate('noData') ??
                  'No Lab Results Found',
              icon: Icons.science,
            );
          }

          final results = state.labResults;

          if (results.isEmpty) {
            return EmptyState(
              message:
                  AppLocalizations.of(context)?.translate('noData') ??
                  'No Lab Results Found',
              icon: Icons.science,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.md),
            itemCount: results.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppDimensions.md),
            itemBuilder: (context, index) {
              final result = results[index];
              return _LabResultCard(result: result);
            },
          );
        },
      ),
    );
  }
}

class _LabResultCard extends StatelessWidget {
  final LabResultEntity result;

  const _LabResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    // Basic logic to determine if result is abnormal
    bool isAbnormal =
        result.valueResult.toLowerCase() != 'normal' &&
        result.valueResult != '-';

    // Potentially more complex logic could check if value is within min/max if they are numbers
    // But keeping it simple as per original code

    final theme = Theme.of(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  result.testName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (result.resultDate.isNotEmpty)
                Text(
                  result.resultDate.split(' ').first,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppDimensions.md),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: AppDimensions.md),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    Text(
                      result.valueResult,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isAbnormal ? AppColors.error : AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Reference (${result.unitName})',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    Text(
                      '${result.valueMinimum} - ${result.valueMaximum}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (result.valueName.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.sm),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
              ),
              child: Text(
                'Comment: ${result.valueName}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
