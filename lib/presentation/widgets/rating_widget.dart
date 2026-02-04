import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int starCount;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const RatingWidget({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.size = 16,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        final icon = index < rating
            ? Icons.star_rounded
            : Icons.star_outline_rounded;

        final color = index < rating
            ? (activeColor ?? Colors.amber)
            : (inactiveColor ?? AppColors.textLight);

        return Icon(icon, size: size, color: color);
      }),
    );
  }
}
