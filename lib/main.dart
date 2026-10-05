import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const BrowserApp());
}

class BrowserApp extends StatelessWidget {
  const BrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Freendex Browser',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        ),
      home: const BrowserPage(),
    );
  }
}

class BrowserPage extends StatefulWidget {
  const BrowserPage({super.key});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  late final WebViewController controller;

  final addressController = TextEditingController(text: 'https://ya.ru');

  String currentUrl = 'https://ya.ru';

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              currentUrl = url;
              addressController.text = url;
            });
          },
          onPageFinished: (url){
            setState(() {
              currentUrl = url;
              addressController.text = url;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse(currentUrl),
      );
  }

  void openUrl() {
    var url = addressController.text.trim();

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    controller.loadRequest(Uri.parse(url));
  }

  void openSettings(){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      isScrollControlled: true,
      builder: (context){
        return const _SettingsSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: WebViewWidget(controller: controller),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _BrowserBar(
              addressController: addressController,
              onSubmit: openUrl,
              onSettings: openSettings,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}

class _BrowserBar extends StatelessWidget {
  final TextEditingController addressController;
  final VoidCallback onSubmit;
  final VoidCallback onSettings;

  const _BrowserBar({
    required this.addressController,
    required this.onSubmit,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Container(
                height: 54,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 25,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 17,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: addressController,
                        onSubmitted: (_) => onSubmit(),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.go,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search or enter website',
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
        ),
        const SizedBox(width: 10),
        _GlassButton(
          icon: Icons.tune_rounded,
          onPressed: onSettings,
        ),
      ],
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _GlassButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(27),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Material(
          color: Colors.white.withValues(alpha: 0.72),
          child: InkWell(
            onTap: onPressed,
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.8)
                ),
              ),
              child: Icon(
                icon, 
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsSheet extends StatelessWidget {
  const _SettingsSheet();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(32),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 25,
          sigmaY: 25,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.88),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  margin: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.bookmark_outline),
                  title: Text('Bookmarks'),
                ),
                const ListTile(
                  leading: Icon(Icons.history),
                  title: Text('History'),
                ),
                const ListTile(
                  leading: Icon(Icons.download_outlined),
                  title: Text('Download'),
                ),
                const ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}