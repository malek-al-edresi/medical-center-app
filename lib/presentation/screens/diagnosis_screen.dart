import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/providers/diagnosis_result_provider.dart';
import '../shared/widgets/result_card.dart';

class DiagnosisScreen extends StatefulWidget {
  final String invoiceId;

  const DiagnosisScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DiagnosisResultProvider>(context, listen: false)
          .fetchResults(widget.invoiceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiagnosisResultProvider>(context);
    final results = provider.results;
    final isLoading = provider.isLoading;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('التشخيص', style: GoogleFonts.cairo()),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : results.isNotEmpty
            ? ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ResultCard(
              result: result,
              title: '${result.clinicName}',
              icon: Icons.assignment,
              data: {
                  'التشخيص':result.fullReadyDiag,
                  'تاريخ التشخيص':result.diagnosisDate,
                  'الفحوصات المطلوبة':result.fullNameTest,
                  'الاشعة المطلوبة':result.fullNameRadiology,
              },
            );
          },
        )
            : Center(
          child: Text(
            'لا توجد نتائج تشخيص متاحة.',
            style: GoogleFonts.cairo(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
