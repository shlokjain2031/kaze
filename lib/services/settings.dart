import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  setSettings(bool notif, bool phone, bool backup) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String> settings = [notif.toString(), phone.toString(), backup.toString()];
    preferences.setStringList("settings", settings);
  }

  Future<List<bool>> getSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String> rawSettings = preferences.getStringList("settings");
    List<bool> formattedSettings = [];
    rawSettings.forEach((element) {
      formattedSettings.add(element.toLowerCase() == 'true');
    });

    return formattedSettings ?? null;
  }
  
  setFocusModeApps(List<String> apps) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("apps", apps);
  }
  
  Future<List<String>> getFocusModeApps() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("apps") ?? null;
  }
}