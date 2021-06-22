import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaze/utils/colours.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:intent/intent.dart' as intentFlutter;
import 'package:intent/action.dart' as actionFlutter;
import 'package:intent/flag.dart' as flag;
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/sound_profiles.dart';
import 'package:permission_handler/permission_handler.dart' as permissionHandler;

class Util {

  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  List<String> months = ["Jan", "Feb", "March", "April", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"];

  Future getAllApps() async {
    List apps = await DeviceApps
        .getInstalledApplications(onlyAppsWithLaunchIntent: true, includeSystemApps: true, includeAppIcons: true);
    return apps;
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String hour = now.hour < 10 ? "0" + now.hour.toString() : now.hour.toString();
    String minute = now.minute < 10 ? "0" + now.minute.toString() : now.minute.toString();

    String time = hour + ":" + minute;
    return time;
  }

  openApp(String packageName) {
    DeviceApps.openApp(packageName);
  }

  openSettings(String packageName) {
    DeviceApps.openAppSettings(packageName);
  }

  checkNotificationPermission() async {
    String permissionStatus = await getCheckNotificationPermStatus();
    log("perm: " + permissionStatus);
    if(permissionStatus == "unknown" || permissionStatus == "denied") {
      NotificationPermissions.requestNotificationPermissions();
    }
  }

  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return "denied";
        case PermissionStatus.granted:
          return "granted";
        case PermissionStatus.unknown:
          return "unknown";
        case PermissionStatus.provisional:
          return "provisional";
        default:
          return null;
      }
    });
  }

  List listDecoder(String list) {
    return jsonDecode(list);
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

  Future<String> pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    String path;

    if (pickedFile != null) {
      path = pickedFile.path;
    }
    else {
      print('No image selected.');
    }

    return path;
  }

  String getStringFromTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final newDt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return newDt.toString();
  }

  bool checkIfTimeIsInRange(DateTime startTime, DateTime endTime) {
    bool startTimeAppCanBeUsed = false;
    bool endTimeAppCanBeUsed = false;
    DateTime now = DateTime.now();

    if(now.hour == startTime.hour) {
      if(now.minute > startTime.minute) {
        startTimeAppCanBeUsed = true;
      }
    }
    else if (now.hour > startTime.hour) {
      startTimeAppCanBeUsed = true;
    }

    if(now.hour == endTime.hour) {
      if(now.minute < endTime.minute) {
        endTimeAppCanBeUsed = true;
      }
    }
    else if (now.hour < endTime.hour) {
      endTimeAppCanBeUsed = true;
    }

    return (startTimeAppCanBeUsed && endTimeAppCanBeUsed);
  }

  void displayDefaultLauncherChooser() {
    intentFlutter
        .Intent()
          ..setAction(actionFlutter.Action.ACTION_MAIN)
          ..addCategory("android.intent.category.HOME")
          ..addCategory("android.intent.category.DEFAULT")
          ..addFlag(flag.Flag.FLAG_ACTIVITY_NEW_DOCUMENT)
          ..startActivity().catchError((e) => print("intent error: " + e.toString()));
  }

  void removeLauncherDefault() async {
    intentFlutter
        .Intent()
      ..setAction(actionFlutter.Action.ACTION_MAIN)
      ..addCategory("android.intent.category.DEFAULT")
      ..addFlag(flag.Flag.FLAG_ACTIVITY_NEW_DOCUMENT)
      ..startActivity().catchError((e) => print("intent error: " + e.toString()));
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void notificationPolicyAccess() async {
    bool isNotificationPolicyAccessGranted = await FlutterDnd.isNotificationPolicyAccessGranted;
    if (!(isNotificationPolicyAccessGranted)) {
      FlutterDnd.gotoPolicySettings();
    }
  }
  
  setDndFilter({int dnd=1}) {
    if(dnd == 1) {
      print("dnd: " + dnd.toString());
      FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_PRIORITY);
    }
    else if(dnd == 2) {
      FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
    }
    else if (dnd == 3){
      print("dnd: " + dnd.toString());
      FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
    }
    else {
      FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALARMS);
    }
  }

  Future<TimeOfDay> timePicker(context, time) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (newTime != null) {
      time = newTime;
    }
    return time;
  }

  void turnOffSilentMode() async {
    try {
      await SoundMode.setSoundMode(Profiles.NORMAL);
      String mode = await SoundMode.ringerModeStatus;
      print("sound mode: " + mode);
    } on PlatformException {
      print('Please enable permissions required');
    }
  }

  String getCurrentFormattedDate() {
    String currentFormattedDate;
    DateTime now = DateTime.now();
    currentFormattedDate = days[(now.weekday - 1)] + ", " + now.day.toString() + "th " + months[(now.month - 1)];

    return currentFormattedDate;
  }

  bool checkIfAppIsInMode(List modeApps, List installedApps, int index) {
    bool appIsInMode = false;
    for(int i=0;i<modeApps.length;i++) {
      if(installedApps[index]["label"] == modeApps[i]["label"]) {
        appIsInMode = true;
        break;
      }
    }
    return appIsInMode;
  }
}