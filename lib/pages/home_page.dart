import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yo_app/bloc/user_bloc.dart';
import 'package:yo_app/bloc/user_event.dart';
import 'package:yo_app/services/user_repo.dart';
import '../widgets/action_buttons.dart';
import '../widgets/user_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final userRepo = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(userRepository: userRepo)..add(UserLoadEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc w/ API'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            ActionButtons(),
            Expanded(child: UserList()),
          ],
        ),
      ),
    );
  }
}
