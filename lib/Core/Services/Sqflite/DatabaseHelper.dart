import '../../Models/UserTransaction.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static DataBaseHelper _databaseHelper;
  Database _database;
  static final String _createDatabaseString =
      "CREATE TABLE userTransaction (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount REAL, date INTEGER, category TEXT, desc TEXT)";

  DataBaseHelper._createInstance();

  factory DataBaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DataBaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  /// Returns the database object
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "userTransaction.db");
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(_createDatabaseString);
  }

  /// Inserts a user transaction into the database.
  Future<void> insertUserTransaction(UserTransaction tx) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'userTransaction',
      tx.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("[DatabaseHelper] - inserted ux");
  }

  /// Updates a user transaction in the database.
  Future<int> updateUserTransaction(UserTransaction tx) async {
    final Database db = await database;

    int resp = await db.update('userTransaction', tx.toMap(), where: "id = ?", whereArgs: [tx.id]);

    print("[DatabaseHelper] - updated tx result -> " + resp.toString());

    return resp;
  }

  /// Deletes a user transaction from the database.
  Future<int> deleteUserTransaction(int id) async {
    final Database db = await database;

    int resp = await db.delete('userTransaction', where: "id = ?", whereArgs: [id]);

    print("[DatabaseHelper] - delete tx result -> " + resp.toString());

    return resp;
  }

  /// Gets all user transactions in the database.
  Future<List<Map<String, dynamic>>> getAllUserTransactionList() async {
    print("[DatabaseHelper] - getAllUserTransactionList");
    final Database db = await database;

    return await db.query('userTransaction');
  }

  /// Gets all user transactions between two dates that is in millisecondsFromEpoch.
  Future<List<Map<String, dynamic>>> getUserTransactionsBetween(int startOfMonth, int endOfMonth) async {
    print("[DatabaseHelper] - getUserTransactionsBetween dates");
    final Database db = await database;

    return await db.query('userTransaction', where: "date >= ? AND date <= ?", whereArgs: [startOfMonth, endOfMonth]);
  }

  /// Gets all transactions from a particular category and date.
  Future<List<Map<String, dynamic>>> getCategoryList(int startOfMonth, int endOfMonth, String category) async {
    print("[DatabaseHelper] - getCategoryList");
    final Database db = await database;

    return await db.query('userTransaction',
        where: "date >= ? AND date <= ? AND category = ?", whereArgs: [startOfMonth, endOfMonth, category]);
  }
}
