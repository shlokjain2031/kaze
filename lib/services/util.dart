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
}