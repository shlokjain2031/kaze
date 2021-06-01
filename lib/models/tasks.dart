import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TasksModel {
  final String title;
  final String mode;
  final String isTaskDone;

  TasksModel({this.title, this.mode, this.isTaskDone});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> task = {
      "title" : title,
      "mode" : mode,
      "isTaskDone" : isTaskDone
    };

    return task;
  }
}

class TasksModelProvider {

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "tasks.db");
    Database initDatabase = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE tasks(title TEXT, mode TEXT, isTaskDone TEXT)"
      );
    });
  }

  insertTask(TasksModel task) async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "tasks.db");
    Database database = await openDatabase(dbPath, version: 1);

    database.insert("tasks", task.toMap());

  }

  updateTask(TasksModel task) async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "tasks.db");
    Database database = await openDatabase(dbPath, version: 1);
    String column = "title";

    return database.update("tasks", task.toMap(), where: '$column = ?', whereArgs: [task.title]);
  }

  Future<int> deleteTask(String title) async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "tasks.db");
    Database database = await openDatabase(dbPath, version: 1);
    String column = "title";

    return await database.delete("tasks", where: '$column = ?', whereArgs: [title]);
  }

  Future<List<TasksModel>> getAllTasks(String modeTitle) async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "tasks.db");
    Database database = await openDatabase(dbPath, version: 1);

    List<Map> allTasksMap = await database.query("tasks",
        columns: ["title", "mode", "isTaskDone"], where: 'mode = ?', whereArgs: [modeTitle]);
    List<TasksModel> allTasks = [];
    allTasksMap.forEach((element) {
      allTasks.add(
          TasksModel(
            title: element["title"],
            mode: element["mode"],
            isTaskDone: element["isTaskDone"]
          )
      );
    });

    return allTasks.length > 0 ? allTasks : null;
  }

}