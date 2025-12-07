
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceptionScreen extends StatefulWidget {
  final String invoiceId;

  const ReceptionScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<ReceptionScreen> createState() => _ReceptionScreenState();
}

class _ReceptionScreenState extends State<ReceptionScreen> {
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
          title: Text('الاستقبال', style: GoogleFonts.cairo()),
        ),
        body: Center(
          child: Text(
            'بيانات الاستقبال للفاتورة: {widget.invoiceId}',
            style: GoogleFonts.cairo(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
