import 'package:flutter/material.dart';

import '../widgets/glass_container.dart';

class BrowserBar extends StatelessWidget {
  final TextEditingController addressController;

  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final VoidCallback onSettings;
  final VoidCallback onSecurity;
  final VoidCallback onAddressTap;

  final VoidCallback onClear;
  final VoidCallback onCancel;

  final bool canGoBack;
  final bool isEditing;

  const BrowserBar({
    super.key,
    required this.addressController,
    required this.onBack,
    required this.onSubmit,
    required this.onSettings,
    required this.onSecurity,
    required this.onAddressTap,
    required this.onClear,
    required this.onCancel,
    required this.canGoBack,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 28,
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          _BarButton(
            icon: Icons.chevron_left_rounded,
            onPressed: canGoBack ? onBack : null,
          ),

          const SizedBox(width: 4),

          Expanded(
            child: _AddressField(
              controller: addressController,
              isEditing: isEditing,
              onAddressTap: onAddressTap,
              onSecurity: onSecurity,
              onSubmit: onSubmit,
              onClear: onClear,
            ),
          ),

          const SizedBox(width: 4),

          _BarButton(
            icon: isEditing
                ? Icons.close_rounded
                : Icons.tune_rounded,
            onPressed: isEditing
                ? onCancel
                : onSettings,
            size: isEditing ? 46 : 44,
          ),
        ],
      ),
    );
  }
}

class _AddressField extends StatelessWidget {
  final TextEditingController controller;

  final bool isEditing;

  final VoidCallback onAddressTap;
  final VoidCallback onSecurity;
  final VoidCallback onSubmit;
  final VoidCallback onClear;

  const _AddressField({
    required this.controller,
    required this.isEditing,
    required this.onAddressTap,
    required this.onSecurity,
    required this.onSubmit,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          GestureDetector(
            onTap: onSecurity,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.lock_rounded,
                size: 17,
                color: Colors.black54,
              ),
            ),
          ),

          Expanded(
            child: TextField(
              controller: controller,
              autofocus: isEditing,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.go,
              maxLines: 1,
              onTap: onAddressTap,
              onSubmitted: (_) => onSubmit(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Поиск или адрес сайта',
                isDense: true,
                contentPadding: EdgeInsets.zero,

                suffixIcon: isEditing &&
                        controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: onClear,
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 18,
                        ),
                        splashRadius: 18,
                      )
                    : null,
              ),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;

  const _BarButton({
    required this.icon,
    required this.onPressed,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 2),
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: 22,
            color: enabled
                ? Colors.black87
                : Colors.black26,
          ),
        ),
      ),
    );
  }
}