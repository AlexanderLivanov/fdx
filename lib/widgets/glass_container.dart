import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double blur;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 28,
    this.padding = EdgeInsets.zero,
    this.color = const Color(0xB8FFFFFF),
    this.blur = 20,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return ClipRRect(
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: radius,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.55),
              width: 0.7,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}