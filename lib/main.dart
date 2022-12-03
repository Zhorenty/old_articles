import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'color_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: BlocProvider(
          create: (context) => ColorBloc(),
          child: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorBloc _bloc = BlocProvider.of<ColorBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('bloc w/ flutter_bloc'),
      ),
      body: Center(
        child: BlocBuilder<ColorBloc, Color>(
            builder: ((context, currentColor) => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 100,
                  height: 100,
                  color: currentColor,
                ))),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _bloc.add(RedColorEvent());
            },
            backgroundColor: Colors.red,
          ),
          const SizedBox(width: 15),
          FloatingActionButton(
            onPressed: () {
              _bloc.add(GreenColorEvent());
            },
            backgroundColor: Colors.green,
          )
        ],
      ),
    );
  }
}
