import 'dart:async';
import 'dart:core';

import 'package:bloc_bases/data/model/favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbStorage {
  static final tableName = "favorite";
  static final dbName = "media";
  Future<Database> database;

  Future<Database> _open() async {
    return openDatabase(
      join(await getDatabasesPath(), '$dbName.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, is_favorite INTEGER, is_flaged INTEGER, at_date_time TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> _close() async {
    database = database ?? _open();
    final Database db = await database;
    db.close();
    database = null;
  }

  Future<void> insertFavorite(
      int mediaId, bool isFavorite, bool isFlagged) async {
    database = database ?? _open();
    final Database db = await database;

    var item = MediaFavorite(mediaId, isFavorite, isFlagged, DateTime.now());
    await db.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _close();
    print("insert ${item.toMap()}");
  }

  Future<MediaFavorite> getFavorite(int mediaId) async {
    database = database ?? _open();
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    var list = List.generate(result.length, (i) {
      MediaFavorite(result[i]["id"], result[i]["is_favorite"] == 1,
          result[i]["is_flaged"] == 1, null);
    });


    var res = await db.query(tableName, where: "id = ?", whereArgs: [mediaId]);

    var result3 =  res.isNotEmpty ? MediaFavorite.fromMap(res.first) : Null;
     await _close();

    return result3;
  }

  Future<void> deleteFavorite(int id) async {
    database = database ?? _open();
    final Database db = await database;

    await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    await _close();
  }
}
