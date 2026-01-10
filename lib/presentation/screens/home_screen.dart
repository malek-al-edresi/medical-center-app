import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/localization/app_localizations.dart';
import '../../logic/providers/patient_provider.dart';
import '../../logic/providers/language_provider.dart';
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

  Future<void> _submit() async {
    final invoiceId = _invoiceController.text.trim();
    if (invoiceId.isEmpty) return;

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    final provider = Provider.of<PatientProvider>(context, listen: false);
    await provider.fetchMedicalData(invoiceId);

    if (!mounted) return;

    if (provider.state == ViewState.loaded) {
      Navigator.pushNamed(context, AppRoutes.invoiceDetails);
    } else if (provider.state == ViewState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'An error occurred'),
          backgroundColor: AppColors.error,
        ),
      );
    } else if (provider.state == ViewState.empty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.translate('noData') ??
                'No Data Found',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final isLoading = context.select<PatientProvider, bool>(
      (p) => p.state == ViewState.loading,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(localization?.translate('appName') ?? 'Medical Center'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: 'Change Language',
            onPressed: () {
              final langProvider = Provider.of<LanguageProvider>(
                context,
                listen: false,
              );
              final newLocale = langProvider.appLocale.languageCode == 'ar'
                  ? const Locale('en')
                  : const Locale('ar');
              langProvider.changeLanguage(newLocale);
            },
          ),
        ],
      ),
      body: Center(
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
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
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
      ),
    );
  }
}
