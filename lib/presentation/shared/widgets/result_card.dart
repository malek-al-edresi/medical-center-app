import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart'; // ✅ Already imported
import 'package:glassmorphism/glassmorphism.dart';

import '../../../core/theme/app_fonts.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final IconData icon; // ✅ Accepts any IconData, including LucideIcons
  final Map<String, dynamic> data;

  const ResultCard({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
    required result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return IntrinsicHeight(
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 24,
        blur: 20,
        alignment: Alignment.bottomCenter,
        border: 1.5,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white38.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withOpacity(0.5),
            colorScheme.secondary.withOpacity(0.3),
          ],
        ),
        child: Animate(
          effects: [FadeEffect(duration: 500.ms), SlideEffect(begin: Offset.zero)],
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: Row(
                    children: [
                      Icon(icon, size: 28, color: colorScheme.primary), // ✅ Works with LucideIcons
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    const SizedBox(height: 26),
                    Divider(
                      thickness: 1.1,
                      color: colorScheme.onSurface.withOpacity(0.3),
                    ),
                    const SizedBox(height: 26),
                    // Scrollable content area if needed
                    SizedBox(
                      height: 150,
                      child: SingleChildScrollView(
                        child: Column(
                          children: data.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${entry.key}: ",
                                    style: AppFonts.body.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: colorScheme.onSurface.withOpacity(0.85),
                                      letterSpacing: 0.15,
                                      height: 1.3,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value.toString(),
                                      style: AppFonts.body.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: colorScheme.onSurface.withOpacity(0.7),
                                        letterSpacing: 0.1,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}