import 'package:shared_preferences/shared_preferences.dart';

class User {
  SharedPreferences preferences;

  Future<bool> getUser() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool("user") ?? null;
  }

  setUser() async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool("user", true);
  }
}