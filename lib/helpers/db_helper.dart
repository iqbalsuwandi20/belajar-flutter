import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "absensi.db";

    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDB);

    return todoDatabase;
  }

  void _createDB(Database database, int version) async {
    await database.execute("""
      CREATE TABLE absensi (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      status_hadir TEXT
      )
    """);
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }

    return _database!;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query("absensi", orderBy: "nama");
    return mapList;
  }
}
