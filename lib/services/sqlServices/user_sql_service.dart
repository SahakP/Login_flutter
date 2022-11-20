import 'package:sqflite/sqflite.dart';

import '../../model/user_model.dart';

class UserSqlService {
  static final UserSqlService UDataB = UserSqlService._dataBase();

  UserSqlService._dataBase();

  factory UserSqlService() {
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

  Future<void> insertData(User user) async {
    await userdb!.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(String userName, String password) async {
    await init();
    final user = await userdb!.query('users',
        where: 'name = ? AND password = ?', whereArgs: [userName, password]);
    if (user.isEmpty) {
      return null;
    } else {
      return User.fromMap(user.first);
    }
  }

  Future<void> onCreate(Database db, int vexrsion) async {
    await db.execute('CREATE TABLE users'
        '(name STRING PRIMARY KEY NOT NULL,'
        'firstName STRING,lastName STRING, email STRING, phone STRING,'
        'password STRING,birthDate STRING)');
  }
}
