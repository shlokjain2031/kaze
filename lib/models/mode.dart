import 'dart:core';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ModeModel {
  final int id;
  final String title;
  final String startTime;
  final String endTime;
  final String wallpaperPath;
  final String apps;

  ModeModel({this.id, this.title, this.startTime, this.endTime, this.wallpaperPath, this.apps});

  Map<String, Object> toMap() {
    Map<String, Object> mode = {
      "id" : id,
      "title" : title,
      "startTime" : startTime,
      "endTime" : endTime,
      "wallpaperPath" : wallpaperPath,
      "apps" : apps
    };
    return mode;
  }
}

class ModeModelProvider {

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "kaze.db");
    Database initDatabase = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE kaze(id INTEGER PRIMARY KEY, title TEXT, startTime TEXT, endTime TEXT, wallpaperPath TEXT, apps TEXT)"
      );
    });
  }

  Future<int> insertMode(ModeModel mode) async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "kaze.db");
    Database database = await openDatabase(dbPath, version: 1);

    return database.insert("kaze", mode.toMap());
  }

  Future<int> updateMode(ModeModel mode) async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "kaze.db");
    Database database = await openDatabase(dbPath, version: 1);

    return database.update("kaze", mode.toMap(), where: 'id = ?', whereArgs: [mode.id]);
  }

  Future<int> deleteMode(int id) async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "kaze.db");
    Database database = await openDatabase(dbPath, version: 1);

    return await database.delete("kaze", where: 'id = ?', whereArgs: [id]);
  }

  Future<ModeModel> getSingleMode(int id) async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "kaze.db");
    Database database = await openDatabase(dbPath, version: 1);

    List<Map> allModes = await database.query("kaze",
        columns: ["title", "startTime", "endTime", "wallpaperPath", "apps"],
        where: 'id = ?',
        whereArgs: [id]);
    Map modeMap = allModes.first;
    if(modeMap.length > 0) {
      ModeModel mode = ModeModel(
          id: modeMap["id"],
          title: modeMap["title"],
          startTime: modeMap["startTime"],
          endTime: modeMap["endTime"],
          wallpaperPath: modeMap["wallpaperPath"],
          apps: modeMap["apps"]
      );
      return mode;
    }
    return null;
  }

  Future<List<ModeModel>> getAllModes() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "kaze.db");
    Database database = await openDatabase(dbPath, version: 1);

    List<Map> allModesMap = await database.query("kaze",
        columns: ["title", "startTime", "endTime", "wallpaperPath", "apps"]);
    List<ModeModel> allModes = [];
    allModesMap.forEach((element) {
      allModes.add(
          ModeModel(
            id: element["id"],
            title: element["title"],
            startTime: element["startTime"],
            endTime: element["endTime"],
            wallpaperPath: element["wallpaperPath"],
            apps: element["apps"]
          ));
    });

    return allModes.length > 0 ? allModes : null;
  }
}