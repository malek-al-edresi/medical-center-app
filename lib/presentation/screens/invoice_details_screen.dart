import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/localization/app_localizations.dart';
import '../blocs/patient/patient_cubit.dart';
import '../blocs/patient/patient_state.dart';
import '../routes/app_routes.dart';
import '../widgets/patient_info_card.dart';
import '../widgets/section_card.dart';
import '../../core/widgets/empty_state.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return BlocBuilder<PatientCubit, PatientState>(
      builder: (context, state) {
        // Handle non-loaded states
        if (state is! PatientLoaded) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const EmptyState(message: 'No patient data loaded'),
          );
        }

        final patient = state.patient;

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
                  subtitle: '${state.labResults.length} Records',
                  icon: Icons.science,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.labResults),
                ),

                // Radiology Section
                SectionCard(
                  title: localization?.translate('radiology') ?? 'Radiology',
                  subtitle: '${state.radiologyResults.length} Images',
                  icon: Icons.image,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.radiology),
                  iconColor: Colors.purple,
                ),

                // Diagnosis Section
                SectionCard(
                  title: localization?.translate('diagnosis') ?? 'Diagnosis',
                  subtitle: '${state.diagnosis.length} Records',
                  icon: Icons.assignment,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.diagnosis);
                  },
                  iconColor: Colors.orange,
                ),

                // Treatment Section
                SectionCard(
                  title: localization?.translate('treatment') ?? 'Treatment',
                  subtitle: '${state.treatment.length} Records',
                  icon: Icons.medication,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.treatment);
                  },
                  iconColor: Colors.teal,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
