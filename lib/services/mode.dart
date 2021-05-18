import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaze/models/mode.dart';
import 'package:launcher_assist/launcher_assist.dart';

class ModeService {

  Future getAllApps() async {
    List rawApp;
    await LauncherAssist.getAllApps().then((apps) {
      rawApp = apps;
    });
    return rawApp;
  }

  Future<ModeModel> getSingleMode(int id) async {
    return await ModeModelProvider().getSingleMode(id);
  }

  Future<List<ModeModel>> getAllModes() async {
    return await ModeModelProvider().getAllModes();
  }

  insertMode(String title, String startTime, String endTime, List apps, String wallpaperPath) {
    String rawApps = jsonEncode(apps);
    ModeModel mode = ModeModel(title: title, startTime: startTime, endTime: endTime, apps: rawApps, wallpaperPath: wallpaperPath);

    ModeModelProvider().insertMode(mode).then((value) => print("mode inserted; id of mode: " + value.toString()));
  }

  updateMode(String title, String startTime, String endTime, List apps, String wallpaperPath) {
    String rawApps = jsonEncode(apps);
    ModeModel mode = ModeModel(title: title, startTime: startTime, endTime: endTime, apps: rawApps, wallpaperPath: wallpaperPath);

    ModeModelProvider().updateMode(mode).then((value) => print("mode updated; id of mode: " + value.toString()));
  }

  deleteMode(int id) {
    ModeModelProvider().deleteMode(id).then((value) => print("mode deleted; id of mode: " + value.toString()));
  }

  initShutdown() {}

  initTimer() {}

  checkTimer() {}
}


