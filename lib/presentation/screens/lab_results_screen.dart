import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/empty_state.dart';
import '../../logic/providers/patient_provider.dart';
import '../../domain/entities/lab_result_entity.dart';
import '../../core/localization/app_localizations.dart';

class LabResultsScreen extends StatelessWidget {
  const LabResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientProvider>(context);
    final results = provider.labResults;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.translate('labResults') ??
              'Lab Results',
        ),
      ),
      body: results.isEmpty
          ? EmptyState(
              message:
                  AppLocalizations.of(context)?.translate('noData') ??
                  'No Lab Results Found',
              icon: Icons.science,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return _buildResultCard(context, result);
              },
            ),
    );
  }

  Widget _buildResultCard(BuildContext context, LabResultEntity result) {
    bool isAbnormal =
        result.valueResult != 'Normal' &&
        result.valueResult != '-'; // Simplified check

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    result.testName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  result.resultDate.split(' ').first,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Result: ${result.valueResult}',
                  style: TextStyle(
                    color: isAbnormal ? AppColors.error : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${result.valueMinimum} - ${result.valueMaximum} ${result.unitName}',
                ),
              ],
            ),
            if (result.valueName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Comment: ${result.valueName}',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
