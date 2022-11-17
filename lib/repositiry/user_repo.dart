import '../model/user_model.dart';
import '../services/user_db_service.dart';

class UserRepo {
  final userDB = UsersDataBase();

  Future<void> createUser(User user) async {
    // await userDB.init();
    await userDB.insertData(user);
  }

  Future<User?> getUser(String userName, String password) async {
    final user = await userDB.getUser(userName, password);
    return user;
  }

  // Future<User?> getUser(String userName, String password) async {
  //   //await userDB.init();
  //   final user = await userDB.userdb!.query('users',
  //       where: 'name = ? AND password = ?', whereArgs: [userName, password]);
  //   if (user.isEmpty) {
  //     return null;
  //   } else {
  //     return User.fromMap(user.first);
  //   }
  // }
  Future<void> delete(User user) async {
    await userDB.deleteUser(user);

    //  Future<void> delete(String name) async {
    //     await userDB.userdb!.delete('users', where: 'name=?', whereArgs: [name]);
    //   }
  }
// //  Future<void> deleteData() async {
//     // sample_mflix.comments
//     // test.my_collection
//     var collection =
//         client.getDatabase("sample_mflix").getCollection("comments");

//     try {
// //      var document = MongoDocument.fromMap({
// //        "time": DateTime.now().millisecondsSinceEpoch,
// //        "user_id": "abcdefg",
// //        "price": 31.78432
// //      });

// //      var docs = await collection.find(filter: {"name": "Olly"});
// //      print(docs.length);
// //
// //      var deletedDocs = await collection.deleteOne({"name": "Olly"});
// //      print(deletedDocs);

//       var deletedDocs = await collection.deleteMany({"name": "Olly"});
//       print(deletedDocs);

// //      var size = await collection.count();
// //      print(size);
//     } on PlatformException catch (e) {
//       debugPrint("Error! ${e.message}");
//     }
//   }
}
