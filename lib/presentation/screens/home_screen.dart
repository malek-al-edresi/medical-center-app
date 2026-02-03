import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/localization/app_localizations.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';
import '../blocs/language/language_cubit.dart';
import '../routes/app_routes.dart';
import '../../core/widgets/app_loader.dart';

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

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    // Trigger patient data load
    context.read<PatientCubit>().loadPatient(invoiceId);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization?.translate('appName') ?? 'Medical Center'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: 'Change Language',
            onPressed: () {
              context.read<LanguageCubit>().toggleLanguage();
            },
          ),
        ],
      ),
      body: BlocConsumer<PatientCubit, PatientState>(
        listener: (context, state) {
          // Handle side effects: navigation and error snackbars
          if (state is PatientLoaded) {
            Navigator.pushNamed(context, AppRoutes.invoiceDetails);
          } else if (state is PatientError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is PatientLoading;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medical_services_outlined,
                    size: 80,
                    color: AppColors.primary.withValues(alpha: 0.8),
                  ),
                  const SizedBox(height: AppDimensions.paddingL),
                  Text(
                    localization?.translate('welcome') ??
                        'Welcome to Medical Center',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),
                  TextField(
                    controller: _invoiceController,
                    decoration: InputDecoration(
                      labelText: localization?.translate('enterInvoiceId'),
                      prefixIcon: const Icon(Icons.receipt_long),
                      hintText: 'e.g. 101',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusM,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _submit(),
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: AppDimensions.paddingL),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? const AppLoader()
                          : Text(localization?.translate('search') ?? 'Search'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
