import 'package:flutter/material.dart';
import 'pages/register_form_page.dart';
import 'pages/user_info_page.dart';
import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const RegisterFormPage());

          case '/user':
            final user = settings.arguments as User;
            return MaterialPageRoute(
                builder: (context) => UserInfo(user: user));
        }
        return null;
      },
    );
  }
}
