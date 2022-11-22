import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<ChangeProvider>.value(
                value: ChangeProvider()),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Homework Provider',
                style: TextStyle(color: Colors.pink.shade200),
              ),
              backgroundColor: Colors.black,
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AContainer(),
                const MySwitch(),
              ],
            )),
          ),
        ));
  }
}

class AContainer extends StatelessWidget {
  AContainer({super.key});
  @override
  Widget build(BuildContext context) {
    ChangeProvider state = Provider.of(context);
    return AnimatedContainer(
      width: 200,
      height: 200,
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0),
      duration: const Duration(seconds: 1),
    );
  }
}

class MySwitch extends StatelessWidget {
  const MySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeProvider state = Provider.of(context);
    return Switch(
      value: state.light,
      onChanged: (value) => state._changeToggle(value),
    );
  }
}

class ChangeProvider extends ChangeNotifier {
  bool light = true;
  void _changeToggle(value) {
    light = value;
    notifyListeners();
  }
}
