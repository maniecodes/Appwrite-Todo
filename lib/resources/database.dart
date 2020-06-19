import 'dart:async';
import 'dart:io';

import 'package:appwrite_project/models/task_entity.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  static final table = 'Users';

  static final userId = 'uid';
  static final name = 'name';
  static final email = 'email';
  static final phone = 'phone';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

// this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('creating db');
    await db.execute('''
          CREATE TABLE Tasks (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            complete TEXT,
            favourite TEXT,
            uid TEXT
          )
          ''');
  }

// Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future insert(TaskEntity task) async {
    Database db = await instance.database;
    print('inserting to db');
    return await db.rawInsert(
        'INSERT INTO Tasks (id, title, description, complete, favourite, uid) VALUES(?, ?, ?, ?, ?, ?)',
        [
          task.id,
          task.title,
          task.description,
          task.complete,
          task.favourite,
          task.uid
        ]);
  }

  // Future<List<TaskEntity>> getLocalTask() async {
  //   Database db = await instance.database;
  //   var result = await db.rawQuery('SELECT * FROM Tasks');
  //   print('sql lite');
  //   print(result);
  // }
}
