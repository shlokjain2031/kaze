import 'package:launcher_assist/launcher_assist.dart';

class ModeService {
  getAllModes() {}

  Future getAllApps() async {
    List rawApp;
    await LauncherAssist.getAllApps().then((apps) {
      rawApp = apps;
    });
    return rawApp;
  }

  getSingleMode(String id) {}

  setMode() {} // more param
}


