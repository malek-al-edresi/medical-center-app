
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/providers/lab_result_provider.dart';
import '../shared/widgets/result_card.dart';

class LabResultScreen extends StatefulWidget {
  final String invoiceId;

  const LabResultScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<LabResultScreen> createState() => _LabResultScreenState();
}

class _LabResultScreenState extends State<LabResultScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LabResultProvider>(context, listen: false).fetchResults(widget.invoiceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = Provider.of<LabResultProvider>(context).labResults;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('نتائج التحاليل', style: GoogleFonts.cairo()),
        ),
        body: results.isNotEmpty
            ? ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
            final result = results[index];
                  return ResultCard(
                    result: result,
                    title: 'المختبر',
                    icon: Icons.assignment,
                    data: {
                      'الوصف': result.valueResult,
                      'التاريخ': result.valueName,
                    },
                  );
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
