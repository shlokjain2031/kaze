import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:device_apps/device_apps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/util.dart';
import 'package:path_provider/path_provider.dart';

class ModeService {

  Future<ModeModel> getSingleMode(int id) async {
    return await ModeModelProvider().getSingleMode(id);
  }


  Future<ModeModel> getCurrentMode() async {
    List<ModeModel> allModes = await getAllModes();
    ModeModel currentMode;
    DateTime startTime;
    DateTime endTime;

    allModes.forEach((element) {
      startTime = DateTime.parse(element.startTime);
      endTime = DateTime.parse(element.endTime);

      bool modeCanBeUsed = Util().checkIfTimeIsInRange(startTime, endTime);
      currentMode = modeCanBeUsed ? element : allModes[0];
    });

    return currentMode;
  }

  Future<List<ModeModel>> getAllModes() async {
    return await ModeModelProvider().getAllModes();
  }

  insertMode(String title, String startTime, String endTime, List rawApps, String wallpaperPath) {
    List<Map> apps = [];
    rawApps.forEach((element) {
      apps.add(Util().convertApplicationWithIconToMap(element));
    });
    String formattedApps = jsonEncode(apps);
    int rid = 1;
    ModeModel mode = ModeModel(id: rid, title: title, startTime: startTime, endTime: endTime, apps: formattedApps, wallpaperPath: wallpaperPath);

    ModeModelProvider()
        .insertMode(mode)
        .then((value) => print("mode inserted; id of mode: " + value.toString()));

    initBackup();
  }

  updateMode(int id, String title, String startTime, String endTime, List rawApps, String wallpaperPath, {String prevTitle}) {
    String formattedApps = jsonEncode(rawApps);
    ModeModel mode = ModeModel(id: id, title: title, startTime: startTime, endTime: endTime, apps: formattedApps, wallpaperPath: wallpaperPath);

    ModeModelProvider()
        .updateMode(mode, prevTitle: prevTitle)
        .then((value) => print("mode updated; id of mode: " + value.toString()));

    initBackup();
  }

  deleteMode(String title) async {
    ModeModelProvider()
        .deleteMode(title)
        .then((value) =>
        print("mode deleted; id of mode: " + value.toString()));
  }

  bool checkIfAppCanBeUsed(ModeModel mode) {

    DateTime startTime = DateTime.parse(mode.startTime);
    DateTime endTime = DateTime.parse(mode.endTime);
    bool appCanBeUsed = Util().checkIfTimeIsInRange(startTime, endTime);

    return appCanBeUsed;
  }

  Future<bool> checkForDuplicate(String title) async {
    bool isDuplicate = false;
    List<ModeModel> allModes = await getAllModes();
    if(allModes == null) {
      isDuplicate = false;
    }
    else {
      for(int i=0;i<allModes.length;i++) {
        if(allModes[i].title == title) {
          isDuplicate = true;
          break;
        }
      }
    }

    return isDuplicate;
  }

  backup(User user) async {
    String uid = user.uid;

    List<ModeModel> allModes = await getAllModes();
    List<String> formattedAllModes = [];
    allModes.forEach((element) {
      formattedAllModes.add(jsonEncode(element));
    });

    String formattedData = jsonEncode(formattedAllModes);

    String path = (await getApplicationDocumentsDirectory()).path;
    File backupFile = await File('$path/backup_$uid.txt').writeAsString(formattedData);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference ref = firebaseStorage.ref('/');
    await ref.putFile(backupFile).then((snapshot) {
      print("file uploaded to: " + snapshot.ref.fullPath);
    });
  }

  void initBackup() {
    User user = FirebaseAuth.instance.currentUser;
    user != null ? backup(user) : print("user does not exists so did not backup");
  }
}


