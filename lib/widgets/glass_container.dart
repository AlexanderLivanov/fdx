import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color color;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 28,
    this.padding = EdgeInsets.zero,
    this.color = const Color(0xB8FFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 25,
          sigmaY: 25,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.65),
              width: 0.8,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}