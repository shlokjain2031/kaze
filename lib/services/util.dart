import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intent/action.dart';
import 'package:kaze/utils/colours.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:intent/intent.dart' as intentFlutter;
import 'package:intent/action.dart' as actionFlutter;
import 'package:intent/category.dart' as categoryFlutter;
import 'package:intent/flag.dart' as flag;

class Util {
  Future getAllApps() async {
    List rawApp = await LauncherAssist.getAllApps();
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

  List listParser(String list) {
    return jsonDecode(list);
  }

  Uint8List getAppIcon(List list) {
    List<int> formattedList = [];
    list.forEach((element) {
      formattedList.add(element);
    });

    return Uint8List.fromList(formattedList);
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

  Future<Color> getDominantColor(String path) async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        FileImage(File(path))
    );
    return path != null ? paletteGenerator.lightVibrantColor.color : Colours().white();
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  String getStringFromTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final newDt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return newDt.toString();
  }

  bool checkTimeBeforeAfter(DateTime startTime, DateTime endTime) {
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

  void removeLauncherDefault() {
    intentFlutter
        .Intent()
      ..setAction(actionFlutter.Action.ACTION_MAIN)
      ..addCategory("android.intent.category.HOME")
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

  void notificationPolicyAccess({bool fromHome=false}) async {
    bool isNotificationPolicyAccessGranted = await FlutterDnd.isNotificationPolicyAccessGranted;
    if (!(isNotificationPolicyAccessGranted)) {
      FlutterDnd.gotoPolicySettings();
    }

    if(fromHome) {
      if (isNotificationPolicyAccessGranted) {
        setDndFilter();
      }
    }
  }
  
  setDndFilter({int dnd=1}) {
    if(dnd == 1) {
      FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALARMS);
    }
    else if(dnd == 2) {
      FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
    }
    else {
      FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
    }
  }


}