import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db;

  DatabaseHelper._instance();

  final String tableName = "todos";
  final String colId = 'id';
  final String colName = 'name';
  final String colDescription = 'description';
  final String colTime = 'time';
  final String colLocation = 'location';
  final String colPriority = 'priority';

  Future<Database?> get db async {
    return _db ?? await _initDB();
  }

  Future<Database?> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "todos.db";
    _db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE $tableName ("
              "$colId INTEGER PRIMARY KEY,"
              "$colName TEXT,"
              "$colDescription TEXT,"
              "$colTime TEXT,"
              "$colLocation TEXT,"
              "$colPriority INTEGER"
              ")");
        });
    return _db;
  }

  Future<TodoModel> insert(TodoModel todoModel) async {
    final data = await db;
    todoModel.id = (await data?.insert(tableName, todoModel.toMap()))!;
    print("INSERTED TO DATABASE");
    return todoModel;
  }

  Future<int?> update(TodoModel TodoModel) async {
    final data = await db;

    print("UPDATED");
    return await data?.update(tableName, TodoModel.toMap(),
        where: '$colId = ?', whereArgs: [TodoModel.id]);

  }

  Future<int?> delete(int todoModelId) async {
    final data = await db;
    return await data?.delete(
      tableName,
      where: '$colId = ?',
      whereArgs: [todoModelId],
    );
  }

  Future<List<TodoModel>> getAllTodos() async {
    final data = await db;
    final List<Map<String, Object?>>? maps = await data?.query(tableName);

    if (maps == null) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return TodoModel.fromMap(Map<String, dynamic>.from(maps[i]));
    });
  }
}