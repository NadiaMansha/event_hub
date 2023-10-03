import 'package:shared_preferences/shared_preferences.dart';

class Token {
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token!;
  }
}
