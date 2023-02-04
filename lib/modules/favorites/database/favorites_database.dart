import 'dart:async';

import 'package:mvv_tracker/modules/favorites/models/favorite.model.dart';
import 'package:mvv_tracker/utils/string.util.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDatabase {
  static final FavoritesDatabase instance = FavoritesDatabase._init();

  static Database? _database;

  FavoritesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(filePath) async {
    return await openDatabase(filePath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'VARCHAR NOT NULL';
    await db.execute('''
CREATE TABLE $tableFavorite (
  ${FavoriteFields.id} $idType,
  ${FavoriteFields.types} $textType,
  ${FavoriteFields.origin} $textType,
  ${FavoriteFields.originGlobalId} $textType,
  ${FavoriteFields.destination} $textType
)''');
  }

  Future<Favorite> readSingle(int id) async {
    final db = await instance.database;
    final results = await db.query(tableFavorite,
        where: '${FavoriteFields.id} = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      return Favorite.fromJson(results.first);
    } else {
      throw Exception("ID $id not found in database");
    }
  }

  Future<Favorite?> readSingleByOrigin(String origin) async {
    final db = await instance.database;
    final results = await db.query(tableFavorite,
        where: '${FavoriteFields.origin} = ?', whereArgs: [origin]);
    if (results.isNotEmpty) {
      return Favorite.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<List<Favorite>> readAll() async {
    final db = await instance.database;
    final results = await db.query(tableFavorite);
    return results.map((json) => Favorite.fromJson(json)).toList();
  }

  Future<Favorite> create(Favorite favorite) async {
    final db = await instance.database;
    final id = await db.insert(tableFavorite, favorite.toJson());
    return favorite.copy(id: id);
  }

  void createFavoritesInBatch(List<Favorite> favorites) async {
    final db = await instance.database;
    final Batch batch = db.batch();
    for (var favorite in favorites) {
      batch.insert(tableFavorite, favorite.toJson());
    }
    await batch.commit();
  }

  Future<int> update(Favorite favorite) async {
    final db = await instance.database;
    return await db.update(tableFavorite, favorite.toJson(),
        where: '${FavoriteFields.id} = ?', whereArgs: [favorite.id]);
  }

  Future<int> delete(int idToDelete) async {
    final db = await instance.database;
    return await db.delete(tableFavorite,
        where: '${FavoriteFields.id} = ?', whereArgs: [idToDelete]);
  }

  Future<int> deleteDestination(String origin, String destination) async {
    final db = await instance.database;
    return await db.delete(tableFavorite,
        where:
            '${FavoriteFields.origin} = ? and ${FavoriteFields.destination} = ?',
        whereArgs: [origin, destination]);
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return await db.delete(tableFavorite);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
