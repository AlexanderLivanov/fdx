import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'browser_controller.dart';
import 'browser_bar.dart';
import '../settings/settings_sheet.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({super.key});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  late final BrowserController browser;
  late final TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    browser = BrowserController();

    addressController = TextEditingController(
      text: browser.currentUrl.value,
    );

    browser.currentUrl.addListener(_updateAddress);
  }

  void _updateAddress() {
    final url = browser.currentUrl.value;

    if (addressController.text != url) {
      addressController.text = url;
      addressController.selection = TextSelection.fromPosition(
        TextPosition(
          offset: addressController.text.length,
        ),
      );
    }
  }

  void _openUrl() {
    browser.openUrl(addressController.text);
  }

  @override
  void dispose() {
    browser.currentUrl.removeListener(_updateAddress);
    addressController.dispose();
    browser.currentUrl.dispose();
    browser.canGoBack.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // WebView больше не начинается под статус-баром.
          Positioned(
            left: 0,
            right: 0,
            top: topPadding,
            bottom: 0,
            child: WebViewWidget(
              controller: browser.webView,
            ),
          ),

          // Нижняя панель браузера.
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ValueListenableBuilder<bool>(
              valueListenable: browser.canGoBack,
              builder: (
                context,
                canGoBack,
                _,
              ) {
                return BrowserBar(
                  addressController: addressController,
                  canGoBack: canGoBack,
                  onBack: browser.goBack,
                  onSubmit: _openUrl,
                  onSecurity: () {
                    browser.showSiteInfo(context);
                  },
                  onSettings: () {
                    SettingsSheet.show(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}