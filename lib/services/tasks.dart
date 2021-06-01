import 'dart:convert';

import 'package:kaze/models/tasks.dart';

class TasksService {
  insertTask(String title, Map mode, bool isTaskDone) async {
    String formattedMode = jsonEncode(mode);
    TasksModel task = TasksModel(title: title, mode: formattedMode, isTaskDone: isTaskDone.toString());

    await TasksProvider()
        .insertTask(task)
        .then((value) => print("task inserted; id of mode: " + value.toString()));
  }

  updateTasks(String title, Map mode, bool isTaskDone) async {
    String formattedMode = jsonEncode(mode);
    TasksModel task = TasksModel(title: title, mode: formattedMode, isTaskDone: isTaskDone.toString());

    await TasksProvider()
        .updateTask(task)
        .then((value) => print("task updated; id of mode: " + value.toString()));
  }

  deleteTask(String title) async {
    String newTitle = "";
    List<TasksModel> allTasks = await getAllTasks();
    for(int i=0;9<allTasks.length;i++) {
      if(title == allTasks[i].title) {
        newTitle = title;
        break;
      }
    }

    await TasksProvider()
        .deleteTask(newTitle)
        .then((value) => print("task deleted; id of mode: " + value.toString()));
  }

  Future<List<TasksModel>> getAllTasks() async {
    return await TasksProvider().getAllTasks();
  }
}