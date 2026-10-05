import 'package:flutter/material.dart';

import '../widgets/glass_container.dart';
import '../widgets/glass_button.dart';

class BrowserBar extends StatelessWidget {
  final TextEditingController addressController;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final VoidCallback onSettings;
  final VoidCallback onSecurity;

  final bool canGoBack;

  const BrowserBar({
    super.key,
    required this.addressController,
    required this.onBack,
    required this.onSubmit,
    required this.onSettings,
    required this.onSecurity,
    required this.canGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GlassButton(
          icon: Icons.chevron_left_rounded,
          onPressed: canGoBack ? onBack : null,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: GlassContainer(
            borderRadius: 24,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SizedBox(
              height: 46,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onSecurity,
                    child: const Icon(
                      Icons.lock_rounded,
                      size: 18,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: TextField(
                      controller: addressController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.go,
                      maxLines: 1,
                      onSubmitted: (_) => onSubmit(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Поиск или адрес сайта',
                        isDense: true,
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        GlassButton(
          icon: Icons.tune_rounded,
          onPressed: onSettings,
        ),
      ],
    );
  }
}