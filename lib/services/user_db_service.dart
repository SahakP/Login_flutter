import 'dart:async';
import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UserService {
  //static final UsersDataBase UDataB = UsersDataBase._dataBase();
  // UsersDataBase._dataBase();
  //factory UsersDataBase() {
  // return UDataB;
  //}

  final MongoRealmClient client = MongoRealmClient();
  final RealmApp app = RealmApp();

  // Database? userdb;
  // Future<void> init() async {
  //   try {
  //     if (userdb != null) {}
  //     userdb = await openDatabase(await getDatabasesPath() + 'database.db',
  //         version: 1, onCreate: onCreate);
  //     // ignore: empty_catches
  //   } catch (e) {}
  // }

  // Future<void> insertA(User user) async {
  //   await userdb!.insert(
  //     'users',
  //     user.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  Future<void> insertData(User user) async {
    final tokenPref = await SharedPreferences.getInstance();
    final realmToken = tokenPref.getString('realmToken')!;
    await RealmApp().login(Credentials.jwt(realmToken));
    var collection = client.getDatabase('myDb').getCollection('users');

    var document = MongoDocument({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'password': user.password,
      'email': user.email,
      'phone': user.phone,
      'birthDate': user.birthday.toString(),
      'name': user.name,
    });

    await collection.insertMany([document]);
  }

  Future<User> getUser(String userName, String password) async {
    var collection = client.getDatabase('myDb').getCollection('users');
    var docs =
        await collection.find(filter: {'name': userName, 'password': password});
    final user = User.fromMap(docs.first.map);
    return user;
  }

  Future<void> deleteUser(User user) async {
    var collection = client.getDatabase('myDb').getCollection('users');
    var deletedDocs = await collection.deleteOne({'name': user.name});
  }

//   Future<void> onCreate(Database db, int vexrsion) async {
//     await db.execute('CREATE TABLE users'
//         '(name STRING PRIMARY KEY NOT NULL,'
//         'firstName STRING,lastName STRING, email STRING, phone STRING,'
//         'password STRING,birthDate STRING)');
//   }
// }

  Future<void> updateUser(User user, _doc) async {
    var collection = client.getDatabase('myDb').getCollection('users');

    // var doc = MongoDocument({
    //   'name': user.name,
    //   'firstName': user.firstName,
    //   'lastName': user.lastName,
    //   'password': user.password,
    //   'email': user.email,
    //   'phone': user.phone,
    //   'birthDate': user.birthday.toString(),
    // });

    await collection.updateMany(
        filter: {'name': user.name}, update: UpdateOperator.set(_doc));
  }
}
