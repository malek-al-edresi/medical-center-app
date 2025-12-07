
import 'package:flutter/material.dart';
import '../../../core/theme/app_fonts.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppFonts.body,
        textAlign: TextAlign.center,
      ),
    );
  }
}
