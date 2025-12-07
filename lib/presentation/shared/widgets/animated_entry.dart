
import 'package:flutter/material.dart';

class AnimatedEntry extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const AnimatedEntry({super.key, required this.child, this.duration = const Duration(milliseconds: 500)});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero),
      duration: duration,
      builder: (context, Offset offset, _) {
        return Transform.translate(offset: offset * 20, child: child);
      },
    );
  }
}
