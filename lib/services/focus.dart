import 'dart:developer';

import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/settings.dart';
import 'package:kaze/services/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FocusModeService {
  Future<List<Map>> getApps() async {
    List<String> rawFocusModeApps = await SettingsService().getFocusModeApps();
    List allApps = await Util().getAllApps();
    List<Map> formattedFocusModeApps = [];

    // time complexity = nlog n
    rawFocusModeApps.forEach((focusModePackage) {
      allApps.forEach((allAppsElement) {
        if(allAppsElement["package"] == focusModePackage) {
          formattedFocusModeApps.add(allAppsElement);
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

    allModes.forEach((mode) {
      if(Util().checkTimeBeforeAfter(DateTime.parse(mode.startTime), DateTime.parse(mode.endTime))) {
        wallpaperPath = mode.wallpaperPath;
      }
      else {
        wallpaperPath = null;
      }
    });

    return wallpaperPath;
  }
}