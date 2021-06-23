import 'dart:developer';

import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/settings.dart';
import 'package:kaze/services/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apps.dart';

class FocusModeService {

  // shit performance
  Future<List<Map>> getFocusModeApps() async {
    List<String> rawFocusModeApps = await SettingsService().getFocusModeApps();
    List allApps = await AppsService().getAllApps();
    List<Map> formattedFocusModeApps = [];

    rawFocusModeApps.forEach((focusModePackage) {
      allApps.forEach((allAppsElement) {
        if(allAppsElement.packageName == focusModePackage) {
          formattedFocusModeApps.add(AppsService().convertApplicationWithIconToMap(allAppsElement));
        }
      });
    });

    return formattedFocusModeApps;
  }

  Future<String> getFocusWallpaper() async {
    /**
     * current time
     * get all modes
     * mode which falls under current time
     * get wallpaperpath
     * return it
     * **/

    List<ModeModel> allModes = await ModeService().getAllModes();
    String wallpaperPath = "";

    for(int i=0;i<allModes.length;i++) {
      DateTime startTime = DateTime.parse(allModes[i].startTime);
      DateTime endTime = DateTime.parse(allModes[i].endTime);
      bool appCanBeUsed = Util().checkIfTimeIsInRange(startTime, endTime);

      if(appCanBeUsed && allModes[i].wallpaperPath != null) {
        wallpaperPath = allModes[i].wallpaperPath;
        break;
      }
    }

    return wallpaperPath;
  }

  Future<bool> checkForFocusModeApps() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("focusModeApps") != null ? true : false;
  }
}