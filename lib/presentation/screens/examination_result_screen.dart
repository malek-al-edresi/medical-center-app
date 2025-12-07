
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExaminationResultScreen extends StatefulWidget {
  final String invoiceId;

  const ExaminationResultScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<ExaminationResultScreen> createState() => _ExaminationResultScreenState();
}

class _ExaminationResultScreenState extends State<ExaminationResultScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // TODO: call provider method, for example:
      // Provider.of<SomeProvider>(context, listen: false).fetchResults(widget.invoiceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Examination Result', style: GoogleFonts.cairo()),
        ),
        body: Center(
          child: Text(
            'بيانات Examination Result للفاتورة: {widget.invoiceId}',
            style: GoogleFonts.cairo(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
