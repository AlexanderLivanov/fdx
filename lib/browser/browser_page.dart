import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../settings/settings_sheet.dart';
import 'browser_bar.dart';
import 'browser_controller.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({super.key});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  late final BrowserController browser;

  late final TextEditingController addressController;

  bool isEditingAddress = false;

  String addressBeforeEditing = '';

  @override
  void initState() {
    super.initState();

    browser = BrowserController();

    addressController = TextEditingController(
      text: browser.currentUrl.value,
    );

    browser.currentUrl.addListener(_updateAddress);
    addressController.addListener(_onAddressChanged);
  }

  @override
  void dispose() {
    browser.currentUrl.removeListener(_updateAddress);
    addressController.removeListener(_onAddressChanged);

    addressController.dispose();

    browser.currentUrl.dispose();
    browser.canGoBack.dispose();

    super.dispose();
  }

  void _updateAddress() {
    if (isEditingAddress) {
      return;
    }

    addressController.text = browser.currentUrl.value;

    addressController.selection =
        TextSelection.fromPosition(
      TextPosition(
        offset: addressController.text.length,
      ),
    );
  }

  void _onAddressChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _startEditingAddress() {
    if (isEditingAddress) {
      return;
    }

    addressBeforeEditing = addressController.text;

    setState(() {
      isEditingAddress = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      addressController.selection =
          TextSelection.fromPosition(
        TextPosition(
          offset: addressController.text.length,
        ),
      );
    });
  }

  void _openUrl() {
    final value = addressController.text.trim();

    if (value.isEmpty) {
      return;
    }

    browser.openUrl(value);

    setState(() {
      isEditingAddress = false;
    });

    FocusManager.instance.primaryFocus?.unfocus();

    SystemChannels.textInput.invokeMethod(
      'TextInput.hide',
    );
  }

  void _clearAddress() {
    addressController.clear();
  }

  void _cancelAddressEditing() {
    addressController.text = addressBeforeEditing;

    addressController.selection =
        TextSelection.fromPosition(
      TextPosition(
        offset: addressController.text.length,
      ),
    );

    setState(() {
      isEditingAddress = false;
    });

    FocusManager.instance.primaryFocus?.unfocus();

    SystemChannels.textInput.invokeMethod(
      'TextInput.hide',
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final topSafeArea = media.padding.top;
    final bottomSafeArea = media.padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: topSafeArea,
            bottom: 0,
            child: WebViewWidget(
              controller: browser.webView,
            ),
          ),

          Positioned(
            left: 12,
            right: 12,
            bottom: bottomSafeArea + 24,
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
                  isEditing: isEditingAddress,

                  onBack: browser.goBack,

                  onAddressTap: _startEditingAddress,

                  onSubmit: _openUrl,

                  onSettings: () {
                    SettingsSheet.show(context);
                  },

                  onSecurity: () {
                    browser.showSiteInfo(context);
                  },

                  onClear: _clearAddress,

                  onCancel: _cancelAddressEditing,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}