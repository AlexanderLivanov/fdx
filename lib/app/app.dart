import 'package:flutter/material.dart';
import '../browser/browser_page.dart';

class FreendexBrowserApp extends StatelessWidget {
  const FreendexBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navioh Browser',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const BrowserPage(),
    );
  }
}