import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.22),
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const SettingsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 30,
            sigmaY: 30,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.78),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(height: 20),

                    _Item(
                      icon: Icons.bookmark_outline_rounded,
                      title: 'Закладки',
                      onTap: () {},
                    ),

                    _Item(
                      icon: Icons.history_rounded,
                      title: 'История',
                      onTap: () {},
                    ),

                    _Item(
                      icon: Icons.download_outlined,
                      title: 'Загрузки',
                      onTap: () {},
                    ),

                    _Item(
                      icon: Icons.settings_outlined,
                      title: 'Настройки',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _Item({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      onTap: onTap,
    );
  }
}