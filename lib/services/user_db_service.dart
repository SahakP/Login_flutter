import 'dart:async';
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class UsersDataBase {
  static final UsersDataBase UDataB = UsersDataBase._dataBase();

  UsersDataBase._dataBase();

  factory UsersDataBase() {
    return UDataB;
  }

  Database? userdb;

  Future<void> init() async {
    try {
      if (userdb != null) {}
      userdb = await openDatabase(await getDatabasesPath() + 'database.db',
          version: 1, onCreate: onCreate);
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> insertA(User user) async {
    await userdb!.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> onCreate(Database db, int vexrsion) async {
    await db.execute('CREATE TABLE users'
        '(name STRING PRIMARY KEY NOT NULL,'
        'firstName STRING,lastName STRING, email STRING, phone STRING,'
        'password STRING,birthDate STRING)');
  }
}
