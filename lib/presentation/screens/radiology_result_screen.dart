import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../logic/providers/radiology_result_provider.dart';
import '../shared/widgets/result_card.dart';

class RadiologyResultScreen extends StatefulWidget {
  final String invoiceId;

  const RadiologyResultScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<RadiologyResultScreen> createState() => _RadiologyResultScreenState();
}

class _RadiologyResultScreenState extends State<RadiologyResultScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RadiologyResultProvider>(context, listen: false)
          .fetchResults(widget.invoiceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RadiologyResultProvider>(context);
    final results = provider.results;
    final isLoading = provider.isLoading;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('نتائج الأشعة', style: GoogleFonts.cairo()),
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
              title: 'نتيجة الأشعة',
              icon: Icons.assignment,
              data: {
                'الوصف': result.readyResultDescription,
                'التاريخ': result.resultSummary,
              },
            );
          },
        )
            : const Center(child: Text('لا توجد نتائج حالياً')),
      ),
    );
  }
}
