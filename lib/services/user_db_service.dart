import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class UsersDataBase {
  static final UsersDataBase UDataB = UsersDataBase._dataBase();

  UsersDataBase._dataBase();

  factory UsersDataBase() {
    return UDataB;
  }

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

  //   Future<void> init() async {
  //   // initialized MongoRealm App

  //   try {} on PlatformException catch (e) {
  //     print("Error! ${e.message}");
  //   } on Exception {}
  // }

  // Future<void> insertA(User user) async {
  //   await userdb!.insert(
  //     'users',
  //     user.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  Future<void> insertData(User user) async {
    var collection = client.getDatabase('users').getCollection('collection');

    var document = MongoDocument({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'password': user.password,
      'email': user.email,
      'phone': user.phone,
      'birthDate': user.birthday.toString(),
      'name': user.name,
    });

    collection.insertOne(document);
    //   collection.insertMany([

    //     MongoDocument({
    //       "time": DateTime.now().millisecondsSinceEpoch,
    //       "username": "moshe",
    //       "grades": [90, 98],
    //     }),
    //     MongoDocument({
    //       "time": DateTime.now().millisecondsSinceEpoch,
    //       "username": "adiel",
    //       "age": [77, 55, 91],
    //     }),
    //   ]);
  }

//   Future<void> onCreate(Database db, int vexrsion) async {
//     await db.execute('CREATE TABLE users'
//         '(name STRING PRIMARY KEY NOT NULL,'
//         'firstName STRING,lastName STRING, email STRING, phone STRING,'
//         'password STRING,birthDate STRING)');
//   }
// }
}
