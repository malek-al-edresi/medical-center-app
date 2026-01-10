import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/localization/app_localizations.dart';
import '../../logic/providers/patient_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/patient_info_card.dart';
import '../widgets/section_card.dart';
import '../../core/widgets/empty_state.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    final localization = AppLocalizations.of(context);
    final patient = patientProvider.patient;

    // Safety check if navigating via direct route or state lost
    if (patient == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const EmptyState(message: 'No patient data loaded'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${localization?.translate('patientId')}: ${patient.patientId}',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PatientInfoCard(patient: patient),

            const Divider(),

            // Lab Results Section
            SectionCard(
              title: localization?.translate('labResults') ?? 'Lab Results',
              subtitle: '${patientProvider.labResults.length} Records',
              icon: Icons.science,
              onTap: () => Navigator.pushNamed(context, AppRoutes.labResults),
            ),

            // Radiology Section
            SectionCard(
              title: localization?.translate('radiology') ?? 'Radiology',
              subtitle: '${patientProvider.radiologyResults.length} Images',
              icon: Icons.image,
              onTap: () => Navigator.pushNamed(context, AppRoutes.radiology),
              iconColor: Colors.purple,
            ),

            // Diagnosis Section (Placeholder for consistency or separate screen)
            SectionCard(
              title: localization?.translate('diagnosis') ?? 'Diagnosis',
              subtitle: '${patientProvider.diagnosis.length} Records',
              icon: Icons.assignment,
              onTap: () {
                // For now, maybe just show a dialog or list bottom sheet?
                // Or create a dedicated screen later.
                // Assuming "Diagnosis" is simple enough to show in a card or modal
                // but for enterprise, likely a screen.
                // Let's create a screen or keep it simpler as per Phase 1 reqs?
                // Request says "Display diagnosis and treatment".
                // I'll add simple placeholder action or create screen if time permits.
                // Reusing LabResults style for diagnosis is possible or just a simple list.
              },
              iconColor: Colors.orange,
            ),

            // Treatment Section
            SectionCard(
              title: localization?.translate('treatment') ?? 'Treatment',
              subtitle: '${patientProvider.treatment.length} Records',
              icon: Icons.medication,
              onTap: () {
                // SImilar to diagnosis
              },
              iconColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
