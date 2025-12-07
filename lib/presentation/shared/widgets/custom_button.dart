import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool fullWidth;
  final IconData? icon;
  final Color color;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.fullWidth = true,
    this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GFButton(
      onPressed: enabled ? onPressed : null,
      text: text,
      icon: icon != null ? Icon(icon, color: Colors.white) : null,
      color: color,
      fullWidthButton: fullWidth,
      blockButton: fullWidth,
      size: GFSize.LARGE,
      shape: GFButtonShape.pills,
      textStyle: theme.textTheme.bodyLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
