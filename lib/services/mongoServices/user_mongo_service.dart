import 'dart:async';
import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

class UserMongoService {
  final MongoRealmClient client = MongoRealmClient();
  final RealmApp app = RealmApp();

  Future<void> insertData(User user) async {
    final tokenPref = await SharedPreferences.getInstance();
    final realmToken = tokenPref.getString('realmToken')!;
    await RealmApp().login(Credentials.jwt(realmToken));
    var collection = client.getDatabase('myDb').getCollection('users');

    var document = MongoDocument(user.toMap());

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

  Future<void> updateUser(User user, _doc) async {
    var collection = client.getDatabase('myDb').getCollection('users');
    await collection.updateMany(
        filter: {'name': user.name}, update: UpdateOperator.set(_doc));
  }
}
