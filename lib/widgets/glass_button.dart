import 'package:flutter/material.dart';

import 'glass_container.dart';

class GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;

  const GlassButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return GlassContainer(
      borderRadius: size / 2,
      color: enabled
          ? const Color(0xB8FFFFFF)
          : const Color(0x70FFFFFF),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(size / 2),
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              icon,
              size: 21,
              color: enabled
                  ? Colors.black87
                  : Colors.black26,
            ),
          ),
        ),
      ),
    );
  }
}