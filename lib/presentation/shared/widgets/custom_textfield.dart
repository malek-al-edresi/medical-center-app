import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? actionIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onSearchPressed;
  final bool obscureText;
  final TextInputType keyboardType;

  const TextFieldCustom({
    super.key,
    required this.controller,
    this.labelText = 'أدخل البيانات',
    this.hintText = '',
    this.prefixIcon,
    this.actionIcon,
    this.onChanged,
    this.onSubmitted,
    this.onSearchPressed,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: FadeInDown(
        duration: const Duration(milliseconds: 600),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyMedium?.color ?? Colors.black,
            ),
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
              prefixIcon: Icon(prefixIcon, color: colorScheme.primary),
              filled: true,
              fillColor: theme.inputDecorationTheme.fillColor ?? colorScheme.background,
              contentPadding: theme.inputDecorationTheme.contentPadding,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: colorScheme.primary.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: colorScheme.primary, width: 2),
              ),
              hintText: hintText,
              hintStyle: theme.inputDecorationTheme.hintStyle ??
                  TextStyle(color: colorScheme.onBackground.withOpacity(0.5)),
              suffixIcon: IconButton(
                icon: Icon(actionIcon, color: colorScheme.primary),
                onPressed: onSearchPressed,
                tooltip: 'بحث',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
