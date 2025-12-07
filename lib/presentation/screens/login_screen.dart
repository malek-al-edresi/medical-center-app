
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  final String invoiceId;

  const LoginScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          title: Text('Login', style: GoogleFonts.cairo()),
        ),
        body: Center(
          child: Text(
            'بيانات Login للفاتورة: {widget.invoiceId}',
            style: GoogleFonts.cairo(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
