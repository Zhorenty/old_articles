import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yo_app/bloc/user_bloc.dart';
import 'package:yo_app/bloc/user_state.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserEmptyState) {
          return const Center(
              child: Text(
            'no for fuck your add, press DICK!',
            style: TextStyle(fontSize: 20),
          ));
        } else if (state is UserLoadingState) {
          return const Center(
            child: SpinKitChasingDots(color: Colors.black),
          );
        } else if (state is UserLoadedState) {
          return ListView.builder(
            itemCount: state.loadedUser.length,
            itemBuilder: (context, index) {
              return Container(
                color: index % 2 == 0 ? Colors.white : Colors.blueGrey[300],
                child: ListTile(
                  leading: Text(
                    'id: ${state.loadedUser[index].id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Column(
                    children: [
                      Text(
                        state.loadedUser[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text(
                            state.loadedUser[index].email.toString(),
                            style: const TextStyle(),
                          )
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    state.loadedUser[index].phone.toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              );
            },
          );
        } else if (state is UserErrorState) {
          return throw Exception('ошибка');
        }
        return const SizedBox.shrink();
      },
    );
  }
}
