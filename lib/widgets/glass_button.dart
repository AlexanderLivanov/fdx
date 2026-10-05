import 'package:flutter/material.dart';

import 'glass_container.dart';

class GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const GlassButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 22,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onPressed,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Icon(
              icon,
              size: 21,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}