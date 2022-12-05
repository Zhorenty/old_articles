import '../model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider {
  Future<List<User>> getUsers() async {
    var url = 'https://jsonplaceholder.typicode.com/users/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> usersJson = json.decode(response.body);
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('users error');
    }
  }
}
