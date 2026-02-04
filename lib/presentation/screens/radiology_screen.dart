import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/widgets/empty_state.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';
import '../widgets/medical_image_viewer.dart';
import '../../core/localization/app_localizations.dart';
import '../widgets/app_card.dart';
import '../layout/app_scaffold.dart';

class RadiologyScreen extends StatelessWidget {
  const RadiologyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title:
          AppLocalizations.of(context)?.translate('radiology') ?? 'Radiology',
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          if (state is! PatientLoaded) {
            return EmptyState(
              message:
                  AppLocalizations.of(context)?.translate('noData') ??
                  'No Radiology Images Found',
              icon: Icons.image,
            );
          }

          final results = state.radiologyResults;

          if (results.isEmpty) {
            return EmptyState(
              message:
                  AppLocalizations.of(context)?.translate('noData') ??
                  'No Radiology Images Found',
              icon: Icons.image,
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppDimensions.md),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimensions.md,
              mainAxisSpacing: AppDimensions.md,
              childAspectRatio: 0.85,
            ),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return AppCard(
                padding: EdgeInsets.zero,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => const MedicalImageViewer(
                      imageUrl: 'https://via.placeholder.com/600',
                    ), // Placeholder
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppDimensions.radiusLg),
                          ),
                        ),
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: AppColors.primary.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppDimensions.sm),
                      child: Text(
                        item.testName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
