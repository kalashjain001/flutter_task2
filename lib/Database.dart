import 'dart:io';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'Students.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "StudentsDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Students ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "age INTEGER"
          ")");
    });
  }

  int id = 0;
  newStudent(Student student) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Students (id,name,age)"
        " VALUES (?,?,?)",
        [id, student.name, student.age]);
    id++;
    return raw;
  }

  getStudent(int id) async {
    final db = await database;
    var res = await db.query("Students", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Student.fromMap(res.first) : null;
  }

  Future<List<Student>> getAllStudents() async {
    final db = await database;
    var res = await db.query("Students");
    List<Student> list =
        res.isNotEmpty ? res.map((c) => Student.fromMap(c)).toList() : [];
    return list;
  }

  deleteStudent(int id) async {
    final db = await database;
    return db.delete("Students", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Students");
  }
}
