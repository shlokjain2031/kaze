import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaze/utils/colours.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:palette_generator/palette_generator.dart';

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
}