import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String url = 'http://107.21.221.2:5000/users';
  //login user
  Future<User> loginUser(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse('$url/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var res = (jsonDecode(response.body));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', res['token']);
      prefs.setBool('isLoggedin', true);
      prefs.setString('user', jsonEncode(res['data']));
      print(res);
      return User.fromJson(res['data']);
    } else {
      throw Exception('Failed to load user');
    }
  }

  //signup user
  Future<User> signupUser(
      {required String email,
      required String password,
      required String username,
      required String country,
      required String state,
      required String city}) async {
    final response = await http.post(Uri.parse('$url/signup'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'username': username,
          'country': country,
          'state': state,
          'city': city
        }),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var res = (jsonDecode(response.body));
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('token', res['token']);
      prefs.setBool('isLoggedin', true);
      var user = User.fromJson(res['data']);
      prefs.setString('user', jsonEncode(user.toJson()));

      return user;
    } else {
      print(response.body);
      throw Exception('Failed to load user');
    }
  }
}
