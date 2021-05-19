import 'package:launcher_assist/launcher_assist.dart';

class Util {
  Future getAllApps() async {
    List rawApp;
    await LauncherAssist.getAllApps().then((apps) {
      rawApp = apps;
    });
    return rawApp;
  }

  customSqlQuery(String sqlQuery) {

  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String hour = now.hour < 10 ? "0" + now.hour.toString() : now.hour.toString();
    String minute = now.minute < 10 ? "0" + now.minute.toString() : now.minute.toString();

    String time = hour + ":" + minute;
    return time;
  }

  launchApp(String packageName) {
    LauncherAssist.launchApp(packageName);
  }
}