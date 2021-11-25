import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static String _tabelName = 'tasks';
  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        debugPrint('in dataBase path');
        Database database = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
            'CREATE TABLE $_tabelName (id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title STRING, note TEXT, date STRING, '
            'startTime STRING, endTime STRING, '
            'remind INTEGER, repeat STRING, '
            'color INTEGER '
            'isComplete INTEGER)',
          );
        });
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    print('Insert Function Called');
    return await _db!.insert(_tabelName, task!.toJson());
  }

  static Future<int> delete(Task task) async {
    print('Delete Function Called');
    return await _db!.delete(_tabelName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('Query Function Called');
    return await _db!.query(_tabelName);
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
