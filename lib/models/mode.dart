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

  Map toMap() {
    Map map = {
      "id" : id,
      "title" : title,
      "startTime" : startTime,
      "endTime" : endTime,
      "wallpaperPath" : wallpaperPath,
      "apps" : apps
    };
    return map;
  }
}

class ModeModelProvider {

  Database database;

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "kaze.db");
    Database initDatabase = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE kaze(id INTEGER PRIMARY KEY, title TEXT, startTime TEXT, endTime TEXT, wallpaperPath TEXT, apps TEXT)"
      );
    });
  }

  openSqlDatabase() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "kaze.db");
    database = await openDatabase(dbPath, version: 1);
  }

  Future<int> insertMode(ModeModel mode) async {
    return database.insert("kaze", mode.toMap());
  }

  Future<int> updateMode(ModeModel mode) async {
    return database.update("kaze", mode.toMap(), where: 'id = ?', whereArgs: [mode.id]);
  }

  Future<int> deleteMode(int id) async {
    await database.delete("kaze", where: 'id = ?', whereArgs: [id]);
  }

  Future<Map> getSingleMode(int id) async {
    List<Map> mode = await database.query("kaze",
        columns: ["title", "startTime", "endTime", "wallpaperPath", "apps"],
        where: 'id = ?',
        whereArgs: [id]);
    if(mode.length > 0) {
      return mode.first;
    }
    return null;
  }

  Future<List<Map>> getAllModes() async {
    List<Map> allModes = await database.query("kaze",
        columns: ["title", "startTime", "endTime", "wallpaperPath", "apps"]);
    if(allModes.length > 0) {
      return allModes;
    }
    return null;
  }
}