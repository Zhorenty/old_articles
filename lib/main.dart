import 'package:flutter/material.dart';
import 'pages/register_form_page.dart';

void main() {
  runApp(const NavigatorApp());
}

class NavigatorApp extends StatefulWidget {
  const NavigatorApp({super.key});

  @override
  State<NavigatorApp> createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const RegisterFormPage(),
      },
    );
  }
}
