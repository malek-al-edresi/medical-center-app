import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../logic/providers/patient_provider.dart';
import '../shared/widgets/result_card.dart';

class PatientScreen extends StatefulWidget {
  final String invoiceId;

  const PatientScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PatientProvider>(context, listen: false).fetchResults(widget.invoiceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final patients = Provider.of<PatientProvider>(context).patients;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('بيانات المريض', style: GoogleFonts.cairo()),
        ),
        body: patients.isNotEmpty
            ? ListView(
          padding: const EdgeInsets.all(12),
          children: [
            ResultCard(
              title: "معلومات عامة",
              icon: Icons.person,
              result: patients.first,
              data: {
                'الاسم الكامل': patients.first.fullName ?? "غير معروف",
                'الجنس': patients.first.gender ?? "غير محدد",
                'رقم الهاتف': patients.first.phone,
                'البريد الإلكتروني': patients.first.email,
                'العنوان': patients.first.address,
                'تاريخ الميلاد': patients.first.birthDate,
                'الحالة الاجتماعية': patients.first.maritalStatus,
                'فصيلة الدم': patients.first.bloodType,
              },
            ),
            const SizedBox(height: 12),
            ResultCard(
              title: "الحالة الطبية",
              icon: Icons.health_and_safety,
              result: patients.first,
              data: {
                'الحساسية': patients.first.allergies,
                'الأمراض المزمنة': patients.first.chronicDiseases,
                'العمليات السابقة': patients.first.surgeries,
                'التاريخ الطبي': patients.first.medicalHistory,
              },
            ),
            const SizedBox(height: 12),
            ResultCard(
              title: "جهة الطوارئ",
              icon: Icons.contact_phone,
              result: patients.first,
              data: {
                'الاسم': patients.first.emergencyName ?? "غير متوفر",
                'رقم الهاتف': patients.first.emergencyPhone ?? "غير متوفر",
              },
            ),
            const SizedBox(height: 12),
            ResultCard(
              title: "عدد الفواتير",
              icon: Icons.receipt_long,
              result: patients.first,
              data: {
                'الفواتير': patients.first.invoiceCount?.toString() ?? "0",
              },
            ),
          ],
        )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
