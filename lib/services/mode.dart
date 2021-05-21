import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kaze/models/mode.dart';
import 'package:kaze/services/util.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:path_provider/path_provider.dart';

class ModeService {

  Future<ModeModel> getSingleMode(int id) async {
    return await ModeModelProvider().getSingleMode(id);
  }

  Future<List<ModeModel>> getAllModes() async {
    return await ModeModelProvider().getAllModes();
  }

  insertMode(String title, String startTime, String endTime, List apps, String wallpaperPath) {
    String rawApps = jsonEncode(apps);
    ModeModel mode = ModeModel(title: title, startTime: startTime, endTime: endTime, apps: rawApps, wallpaperPath: wallpaperPath);

    ModeModelProvider()
        .insertMode(mode)
        .then((value) => print("mode inserted; id of mode: " + value.toString()));

    initBackup();
  }

  updateMode(String title, String startTime, String endTime, List apps, String wallpaperPath) {
    String rawApps = jsonEncode(apps);
    ModeModel mode = ModeModel(title: title, startTime: startTime, endTime: endTime, apps: rawApps, wallpaperPath: wallpaperPath);

    ModeModelProvider()
        .updateMode(mode)
        .then((value) => print("mode updated; id of mode: " + value.toString()));

    initBackup();
  }

  deleteMode(int id) {
    ModeModelProvider()
        .deleteMode(id)
        .then((value) => print("mode deleted; id of mode: " + value.toString()));
  }

  bool checkIfAppCanBeUsed(ModeModel mode) {

    DateTime startTime = DateTime.parse(mode.startTime);
    DateTime endTime = DateTime.parse(mode.endTime);
    bool appCanBeUsed = Util().checkTimeBeforeAfter(startTime, endTime);

    return appCanBeUsed;
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


