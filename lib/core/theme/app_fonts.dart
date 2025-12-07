import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static final body = GoogleFonts.cairo(
    fontSize: 17,
    color: const Color(0xFF333333),
  );

  static final heading = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final sub = GoogleFonts.cairo(
    fontSize: 14,
    color: Colors.grey,
  ); // ✅ أُضيف هذا الخط
}

