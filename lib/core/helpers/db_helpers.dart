import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo_riverpod/core/models/user_model.dart';

import '../models/task_model.dart';

class DBHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE IF NOT EXISTS todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title STRING,desc STRING,
        isCompleted INTEGER, date STRING,
        startTime STRING, endTime STRING,
        remind INTEGER, repeat STRING

        
        
        
        );
        ''');
    //     final int id;
    // final String isVerified;
    await database.execute(
      '''CREATE TABLE IF NOT EXISTS user(
        id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,
        isVerified STRING
        );
        ''',
    );
  }

  static Future<sql.Database> openDB() {
    return sql.openDatabase("todo.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createTask(Task task) async {
    final db = await DBHelper.openDB();
    final int id = await db.insert("todos", task.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createUser(int isVerified) async {
    final db = await DBHelper.openDB();
    final data = {
      "id": 1,
      "isVerified": isVerified,
    };
    final int id = await db.insert("user", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getUserList() async {
    final db = await DBHelper.openDB();
    return db.query('user', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItemList() async {
    final db = await DBHelper.openDB();
    return db.query('todos', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DBHelper.openDB();
    return db.query('todos', where: "id= ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(Task task) async {
    final db = await DBHelper.openDB();
    final data = {
      "id": task.id,
      "title": task.title,
      "desc": task.desc,
      "isCompleted": task.isCompleted,
      "date": task.date,
      "startTime": task.startTime,
      "endTime": task.endTime,
      "remind": task.remind,
      "repeat": task.repeat,
    };
    final result =
        await db.update('todos', data, where: "id= ?", whereArgs: [task.id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.openDB();
    try {
      db.delete('todos', where: "id= ?", whereArgs: [id]);
    } catch (e) {
      log("Unable to delete. Error Details: $e");
    }
  }
}
