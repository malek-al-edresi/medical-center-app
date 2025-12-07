import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/providers/treatment_result_provider.dart';
import '../shared/widgets/result_card.dart';

class TreatmentResultScreen extends StatefulWidget {
  final String invoiceId;

  const TreatmentResultScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<TreatmentResultScreen> createState() => _TreatmentResultScreenState();
}

class _TreatmentResultScreenState extends State<TreatmentResultScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TreatmentResultProvider>(context, listen: false)
          .fetchResults(widget.invoiceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TreatmentResultProvider>(context);
    final results = provider.results;
    final isLoading = provider.isLoading;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الوصفة الطبية', style: GoogleFonts.cairo()),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : results.isNotEmpty
            ? ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ResultCard(
                    title: "الطبيب والعيادة",
                    icon: Icons.local_hospital,
                    result: result,
                    data: {
                      'الطبيب': result.doctorName,
                      'العيادة': result.clinicName,
                    },
                  ),
                  const SizedBox(height: 12),
                  ResultCard(
                    title: "معلومات الدواء",
                    icon: Icons.healing,
                    result: result,
                    data: {
                      'اسم الدواء': result.drugName,
                      'الاسم التجاري': result.brandName,
                      'الفئة الدوائية': result.categoryName,
                      'الاسم الكيميائي': result.chemicalName,
                      'الشركة المصنعة': result.manufacturerName,
                    },
                  ),
                  const SizedBox(height: 12),
                  ResultCard(
                    title: "طريقة الاستخدام",
                    icon: Icons.schedule,
                    result: result,
                    data: {
                      'طريقة الاستخدام': result.administrationMethod,
                      'وقت الاستخدام / مدة العلاج':
                      '${result.dosageDescription}, ${result.treatmentDuration}',
                    },
                  ),
                  const SizedBox(height: 12),
                  ResultCard(
                    title: "موانع وتداخلات وتحذيرات",
                    icon: Icons.warning_amber,
                    result: result,
                    data: {
                      'موانع الاستخدام': result.contraDesc,
                      'التداخلات الدوائية': result.drugInteractions,
                      'التحذيرات': result.warnings,
                    },
                  ),
                  const Divider(height: 24, thickness: 1),
                ],
              ),
            );
          },
        )
            : const Center(child: Text('لا توجد نتائج علاجية حالياً')),
      ),
    );
  }
}
