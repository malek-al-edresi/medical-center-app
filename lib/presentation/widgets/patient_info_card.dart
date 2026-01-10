import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
// import '../../core/localization/app_localizations.dart'; // Unused
import '../../domain/entities/patient_entity.dart';

class PatientInfoCard extends StatelessWidget {
  final PatientEntity patient;

  const PatientInfoCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    // final localization = AppLocalizations.of(context); // Unused

    return Card(
      margin: const EdgeInsets.all(AppDimensions.paddingM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text(
                patient.fullName.isNotEmpty
                    ? patient.fullName[0].toUpperCase()
                    : '?',
                style: const TextStyle(fontSize: 24, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.fullName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildInfoChip(Icons.person, patient.gender, context),
                      _buildInfoChip(Icons.cake, patient.birthDate, context),
                      _buildInfoChip(Icons.numbers, patient.patientId, context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
      backgroundColor: AppColors.background,
    );
  }
}
