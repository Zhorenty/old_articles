import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

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
            ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
            FutureProvider<List<User>>(
              create: (_) async => UserProvider().loadUserData(),
              initialData: [],
            ),
            StreamProvider<int>(
              create: (_) => EventProvider().intStream(),
              initialData: 0,
            )
          ],
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Provider'),
                bottom: const TabBar(tabs: [
                  Icon(Icons.add),
                  Icon(Icons.person),
                  Icon(Icons.message),
                ]),
              ),
              body: const TabBarView(children: [
                MyCountPage(),
                MyUserPage(),
                EventPage(),
              ]),
            ),
          ),
        ));
  }
}

class MyCountPage extends StatelessWidget {
  const MyCountPage({super.key});

  @override
  Widget build(BuildContext context) {
    CountProvider state = Provider.of<CountProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('value: ${state._value.toString()}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    state._decrementValue();
                  },
                  icon: const Icon(Icons.remove)),
              IconButton(
                  onPressed: () {
                    state._incrementValue();
                  },
                  icon: const Icon(Icons.add))
            ],
          )
        ],
      ),
    );
  }
}

class CountProvider extends ChangeNotifier {
  int _value = 0;
  void _incrementValue() {
    _value++;
    notifyListeners();
  }

  void _decrementValue() {
    _value--;
    notifyListeners();
  }
}

class MyUserPage extends StatelessWidget {
  const MyUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('FutureProvider Example, users loaded from a File',
              style: TextStyle(fontSize: 17)),
        ),
        Consumer<List<User>>(
          builder: (context, List<User> users, _) {
            return Expanded(
              child: users.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 50,
                            color: Colors.grey[(index * 200) % 400],
                            child: Center(
                                child: Text(
                                    '${users[index].firstName} ${users[index].lastName} | ${users[index].website}')));
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}

class UserProvider {
  final String _dataPath = 'assets/users.json';
  List<User> users = [];
  Future<String> _loadAsset() async {
    return await Future.delayed(const Duration(seconds: 1), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>> loadUserData() async {
    var dataString = await _loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    return users;
  }
}

class User {
  //create variables
  String firstName;
  String lastName;
  String website;
  User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        website = json['website'];
}

class UserList {
  //mapping
  List<User> users;
  UserList(this.users);
  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((user) => User.fromJson(user)).toList();
}

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<int>(context);
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'StreamProviderExample',
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.headline1,
        )
      ]),
    );
  }
}

class EventProvider {
  Stream<int> intStream() {
    Duration interval = const Duration(seconds: 1);
    return Stream<int>.periodic(interval, (int count) => count++);
  }
}
