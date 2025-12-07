import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;

  const PageTitle({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.color, // اجعلها اختيارية
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }
}
