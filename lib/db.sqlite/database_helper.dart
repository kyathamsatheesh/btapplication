// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   static Database? _database;

//   DatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'bt-tbar.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//     print("DB Creation Succesfully done...............");
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE users(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         weight INTEGER,
//         angle double
//       )
//     ''');
//   }
//     Future<int> insertItem(Map<String, dynamic> item) async {
//     Database db = await database;
//     return await db.insert('users', item);
//   }

//   Future<List<Map<String, dynamic>>> getItems() async {
//     Database db = await database;
//     return await db.query('users');
//   }

//   Future<int> updateItem(Map<String, dynamic> item) async {
//     Database db = await database;
//     int id = item['id'];
//     return await db.update('users', item, where: 'id = ?', whereArgs: [id]);
//   }

//   Future<int> deleteItem(int id) async {
//     Database db = await database;
//     return await db.delete('users', where: 'id = ?', whereArgs: [id]);
//   }

// }

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, weight REAL, angle REAL)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert('users', item);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('users');
  }

  Future<void> updateItem(Map<String, dynamic> item) async {
    final db = await database;
    await db.update(
      'users',
      item,
      where: 'id = ?',
      whereArgs: [item['id']],
    );
  }
  Future<int> deleteItem(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
