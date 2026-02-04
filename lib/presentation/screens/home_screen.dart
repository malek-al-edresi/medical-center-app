import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';

import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';
import '../blocs/language/language_cubit.dart';
import '../routes/app_routes.dart';
import '../layout/app_scaffold.dart';

import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/app_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _invoiceController;

  @override
  void initState() {
    super.initState();
    _invoiceController = TextEditingController();
  }

  @override
  void dispose() {
    _invoiceController.dispose();
    super.dispose();
  }

  void _submit() {
    final invoiceId = _invoiceController.text.trim();
    if (invoiceId.isEmpty) return;

    FocusScope.of(context).unfocus();
    context.read<PatientCubit>().loadPatient(invoiceId);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return AppScaffold(
      withSafeArea: false,
      backgroundColor: AppColors.background,
      body: BlocConsumer<PatientCubit, PatientState>(
        listener: (context, state) {
          if (state is PatientLoaded) {
            Navigator.pushNamed(context, AppRoutes.invoiceDetails);
          } else if (state is PatientError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(AppDimensions.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is PatientLoading;

          return Stack(
            children: [
              // Decorative Background
              Positioned(
                top: -150,
                right: -100,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.primary.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -50,
                left: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.lg,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Language Switcher
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusFull,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.language,
                                color: AppColors.primary,
                              ),
                              onPressed: () {
                                context.read<LanguageCubit>().toggleLanguage();
                              },
                              tooltip: 'Switch Language',
                            ),
                          ),
                        ),

                        const SizedBox(height: AppDimensions.xxl),

                        // Logo / Icon
                        Center(
                              child: Container(
                                padding: const EdgeInsets.all(AppDimensions.xl),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 24,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.medical_services_rounded,
                                  size: 64,
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                            .animate()
                            .scale(duration: 600.ms, curve: Curves.easeOutBack)
                            .fadeIn(duration: 600.ms),

                        const SizedBox(height: AppDimensions.xl),

                        // Welcome Text
                        Column(
                          children: [
                            Text(
                                  localization?.translate('welcome') ??
                                      'Welcome back',
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                                .animate()
                                .fadeIn(delay: 200.ms)
                                .slideY(begin: 0.3, end: 0),
                            const SizedBox(height: AppDimensions.sm),
                            Text(
                                  'Access your medical records securely',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                                .animate()
                                .fadeIn(delay: 300.ms)
                                .slideY(begin: 0.3, end: 0),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.xxl),

                        // Search Card
                        AppCard(
                          padding: const EdgeInsets.all(AppDimensions.xl),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.receipt_long_rounded,
                                    color: AppColors.primary,
                                    size: 24,
                                  ),
                                  const SizedBox(width: AppDimensions.sm),
                                  Text(
                                    "Find Invoice",
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDimensions.lg),

                              CustomTextField(
                                label:
                                    localization?.translate('enterInvoiceId') ??
                                    'Invoice ID',
                                controller: _invoiceController,
                                hint: 'e.g. 101',
                                // prefixIcon is handled in CustomTextField,
                                // avoiding duplicate icon if we want a clean look,
                                // but adding it for clarity as per previous design
                                prefixIcon: Icons.numbers_rounded,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: AppDimensions.xl),

                              PrimaryButton(
                                text:
                                    localization?.translate('search') ??
                                    'View Records',
                                onPressed: _submit,
                                isLoading: isLoading,
                                icon: Icons.arrow_forward_rounded,
                                width: double.infinity,
                                height: 56,
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),

                        const SizedBox(height: AppDimensions.xxl),

                        // Footer
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.verified_user_outlined,
                                size: 16,
                                color: AppColors.textLight,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Secure Medical System",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 600.ms),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
