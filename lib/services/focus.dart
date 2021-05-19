import 'package:kaze/models/mode.dart';
import 'package:kaze/services/mode.dart';
import 'package:kaze/services/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FocusModeService {
  Future<List<Map>> getApps() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> rawFocusModeApps = preferences.getStringList("focusModeApps");
    List<Map> allApps = await Util().getAllApps();
    List<Map> formattedFocusModeApps = [];

    // time complexity = 2n
    rawFocusModeApps.forEach((focusModePackage) {
      allApps.forEach((allAppsElement) {
        if(allAppsElement["package"] == focusModePackage) {
          formattedFocusModeApps.add(allAppsElement);
        }
      });
    });

    return formattedFocusModeApps;
  }

  Future<String> getWallpaper() async {
    /**
     * current time
     * get all modes
     * mode which falls under current time
     * get wallpaperpath
     * return it
     * **/

    DateTime now = DateTime.now();
    List<ModeModel> allModes = await ModeService().getAllModes();
    String wallpaperPath = "";
    allModes.forEach((mode) {
      if(now.isAfter(DateTime.parse(mode.startTime)) && now.isAfter(DateTime.parse(mode.endTime))) {
        wallpaperPath = mode.wallpaperPath;
      }
      else {
        wallpaperPath = null;
      }
    });

    return wallpaperPath;
  }
}