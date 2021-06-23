import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';

class AppsService {
  Future getAllApps() async {
    List allApps = await DeviceApps
        .getInstalledApplications(onlyAppsWithLaunchIntent: true, includeAppIcons: true);
    allApps.sort((a, b) => a.appName.compareTo(b.appName));

    return allApps;
  }

  openApp(String packageName) {
    DeviceApps.openApp(packageName);
  }

  openSettings(String packageName) {
    DeviceApps.openAppSettings(packageName);
  }

  Uint8List getAppIcon(List list) {
    List<int> formattedList = [];
    list.forEach((element) {
      formattedList.add(element);
    });

    return Uint8List.fromList(formattedList);
  }

  Map convertApplicationWithIconToMap(app) {
    Map appMap = {
      "label" : app.appName,
      "package" : app.packageName,
      "icon" : app.icon,
    };
    return appMap;
  }

  List<Map> convertListApplicationWithIconToListMap(List apps) {
    List<Map> newList = [];
    apps.forEach((app) {
      Map appMap = {
        "label" : app.appName,
        "package" : app.packageName,
        "icon" : app.icon,
      };

      newList.add(appMap);
    });

    return newList;
  }
}