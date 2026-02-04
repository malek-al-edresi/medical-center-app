import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/patient_entity.dart';
import 'app_card.dart';

class PatientInfoCard extends StatelessWidget {
  final PatientEntity patient;

  const PatientInfoCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(0), // Reset padding to handle custom layout
      child: Column(
        children: [
          // Header Background
          Container(
            padding: const EdgeInsets.all(AppDimensions.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppDimensions.radiusLg),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    patient.fullName.isNotEmpty
                        ? patient.fullName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.fullName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${patient.patientId}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Details Section
          Padding(
            padding: const EdgeInsets.all(AppDimensions.md),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    context,
                    Icons.person_outline,
                    'Gender',
                    patient.gender,
                  ),
                ),
                const SizedBox(width: AppDimensions.md),
                Container(width: 1, height: 40, color: AppColors.divider),
                const SizedBox(width: AppDimensions.md),
                Expanded(
                  child: _buildInfoItem(
                    context,
                    Icons.cake_outlined,
                    'Date of Birth',
                    patient.birthDate,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: AppDimensions.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textLight),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
