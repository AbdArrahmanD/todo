import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 5;
  static String tabelName = 'tasks';
  static Future<void> initDb() async {
    String _path = await getDatabasesPath() + 'task.db';
    debugPrint('in dataBase path');
    _db = await openDatabase(_path, version: _version,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        'CREATE TABLE $tabelName ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title STRING, note TEXT, date STRING, isCompleted INTEGER, '
        'startTime STRING, endTime STRING, '
        'remind INTEGER, repeat STRING, '
        'color INTEGER)',
      );
      print('Creating a new databases');
    });
    print('Db is : $_db');
  }

  static Future<int> insert(Task? task) async {
    print('Insert Function Called');
    return await _db!.insert(tabelName, task!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> delete(Task task) async {
    print('Delete Function Called');
    return await _db!.delete(tabelName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteAll() async {
    print('Delete All Function Called');
    return await _db!.delete(tabelName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('Query Function Called');
    return await _db!.query(tabelName);
  }

  static Future<int> update(int id) async {
    print('Update Function Called');
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
