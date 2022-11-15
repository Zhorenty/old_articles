import 'package:flutter/material.dart';
import '../models/user.dart';

class UserInfo extends StatelessWidget {
  User user;
  UserInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('user info'),
        backgroundColor: Colors.teal,
      ),
      body: Card(
          margin: const EdgeInsets.all(12),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  user.name,
                  style: const TextStyle(color: Colors.teal),
                ),
                subtitle: Text(
                  user.story.isEmpty ? '' : user.story,
                  style: const TextStyle(color: Colors.black),
                ),
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                trailing: user.country.isEmpty ? Text(user.country) : null,
              ),
              ListTile(
                title: Text(
                  user.phone,
                  style: const TextStyle(color: Colors.teal),
                ),
                leading: const Icon(Icons.phone),
              ),
              user.email.isNotEmpty
                  ? ListTile(
                      title: Text(
                        user.email,
                        style: const TextStyle(color: Colors.teal),
                      ),
                      leading: const Icon(Icons.mail),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
