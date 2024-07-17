import 'dart:io';

import 'package:belajar_flutter_maps/models/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  DbHelper._createObject();

  factory DbHelper() {
    _dbHelper ??= DbHelper._createObject();
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}todo.db";

    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      """
        CREATE TABLE TODO (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        note Text
        )
        """,
    );
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await database;
    var mapList = await db.query("todo", orderBy: "title");
    return mapList;
  }

  Future<int> create(Todo object) async {
    Database database = await this.database;
    int count = await database.insert("todo", object.toMap());
    return count;
  }

  Future<int> update(Todo object) async {
    Database database = await this.database;
    int count = await database
        .update("todo", object.toMap(), where: "id=?", whereArgs: [object.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database database = await this.database;
    int count = await database.delete("todo", where: "id=?", whereArgs: [id]);
    return count;
  }

  Future<List<Todo>> getTodoList() async {
    var todoListMap = await select();
    int count = todoListMap.length;
    List<Todo> todoList = <Todo>[];
    for (var i = 0; i < count; i++) {
      todoList.add(Todo.fromMap(todoListMap[i]));
    }
    return todoList;
  }
}
