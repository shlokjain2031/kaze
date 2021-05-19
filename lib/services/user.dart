import 'package:shared_preferences/shared_preferences.dart';

class User {

  Future<bool> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("user") ?? null;
  }

  setUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("user", true);
  }
}