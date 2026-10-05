import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserController {
  late final WebViewController webView;

  final ValueNotifier<String> currentUrl = ValueNotifier(
    'https://storage.yandexcloud.net/freendex-test/index.html',
  );

  final ValueNotifier<bool> canGoBack = ValueNotifier(false);

  BrowserController() {
    webView = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: _onUrlChanged,
          onPageFinished: _onUrlChanged,
        ),
      )
      ..loadRequest(
        Uri.parse(currentUrl.value),
      );
  }

  void _onUrlChanged(String url) async {
    currentUrl.value = url;
    canGoBack.value = await webView.canGoBack();
  }

  void openUrl(String value) {
    var url = value.trim();

    if (url.isEmpty) {
      return;
    }

    if (!url.startsWith('http://') &&
        !url.startsWith('https://')) {
      url = 'https://$url';
    }

    webView.loadRequest(Uri.parse(url));
  }

  Future<void> goBack() async {
    if (await webView.canGoBack()) {
      await webView.goBack();
    }
  }

  Future<void> showSiteInfo(BuildContext context) async {
    final rawUrl = currentUrl.value;
    final uri = Uri.tryParse(rawUrl);

    if (uri == null) {
      return;
    }

    final host = uri.host.isEmpty ? 'Неизвестный сайт' : uri.host;
    final isHttps = uri.scheme.toLowerCase() == 'https';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.25),
      isScrollControlled: true,
      builder: (context) {
        return _SiteInfoSheet(
          host: host,
          url: rawUrl,
          isHttps: isHttps,
        );
      },
    );
  }
}

class _SiteInfoSheet extends StatelessWidget {
  final String host;
  final String url;
  final bool isHttps;

  const _SiteInfoSheet({
    required this.host,
    required this.url,
    required this.isHttps,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.88),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isHttps
                            ? Icons.lock_rounded
                            : Icons.lock_open_rounded,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isHttps
                              ? 'Соединение защищено'
                              : 'Соединение не защищено',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Сайт',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    host,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Адрес',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 4),

                  SelectableText(
                    url,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Готово'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}