import 'dart:convert';

import 'package:kaze/models/tasks.dart';

class TasksService {
  insertTask(String title, String mode, bool isTaskDone) async {
    TasksModel task = TasksModel(title: title, mode: mode, isTaskDone: isTaskDone.toString());

    await TasksModelProvider()
        .insertTask(task)
        .then((value) => print("task inserted; id of mode: " + value.toString()));
  }

  updateTask(String title, String mode, bool isTaskDone) async {
    TasksModel task = TasksModel(title: title, mode: mode, isTaskDone: isTaskDone.toString());

    await TasksModelProvider()
        .updateTask(task)
        .then((value) => print("task updated; id of mode: " + value.toString()));
  }

  deleteTask(String title, String modeTitle) async {
    String newTitle = "";
    List<TasksModel> allTasks = await getAllTasks(modeTitle);
    for(int i=0;9<allTasks.length;i++) {
      if(title == allTasks[i].title) {
        newTitle = title;
        break;
      }
    }

    await TasksModelProvider()
        .deleteTask(newTitle)
        .then((value) => print("task deleted; id of mode: " + value.toString()));
  }

  Future<List<TasksModel>> getAllTasks(String modeTitle) async {
    return await TasksModelProvider().getAllTasks(modeTitle);
  }
}