import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo.dart';

import 'model/task.dart';

class DatabaseHelper {

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'task.db'),
      onCreate: (db, version) async{
        await db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
        );
        await db.execute(
          "CREATE TABLE todo(id INTEGER PRIMARY KEY, taskID INTEGER, title TEXT, isDone INTEGER)",
        );
        return db;
      },
      version: 1,
    );
  }

  Future<int> insertTask(Task task) async {
    int taskID = 0;
    Database _db = await database();
    await _db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
          taskID = value;
    });
    return taskID;
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();
    await _db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> retrieveTask() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query("tasks");
    return List.generate(taskMap.length, (index) {
      return Task(id: taskMap[index]["id"], title: taskMap[index]["title"], description: taskMap[index]["description"]);
    });

  }

  Future<List<Todo>> retrieveTodo(int taskID) async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap = await _db.rawQuery("SELECT * FROM todo WHERE taskID = $taskID");
    return List.generate(todoMap.length, (index) {
      return Todo(id: todoMap[index]["id"], title: todoMap[index]["title"], taskID: todoMap[index]["taskID"], isDone: todoMap[index]["isDone"]);
    });

  }

  Future<void> updateTaskTitle (int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateTaskDescription (int id, String description) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET description = '$description' WHERE id = '$id'");
  }

  Future<void> updateTodoDone (int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  }

}

