import 'dart:core';

class ModeModel {
  final String title;
  final String startTime;
  final String endTime;
  final String wallpaperPath;
  final List<String> apps;

  ModeModel({this.title, this.startTime, this.endTime, this.wallpaperPath, this.apps});

  Map toMap(ModeModel modeModel) {
    Map map = {
      "title" : modeModel.title,
      "startTime" : modeModel.startTime,
      "endTime" : modeModel.endTime,
      "wallpaperPath" : modeModel.wallpaperPath,
      "apps" : modeModel.apps
    };
    return map;
  }
}