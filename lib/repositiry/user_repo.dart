import '../model/user_model.dart';
import '../services/user_db_service.dart';

class UserRepo {
  final userDB = UsersDataBase();

  Future<void> createUser(User user) async {
    // await userDB.init();
    await userDB.insertData(user);
  }

//    Future<void> insertData() async {
//     var collection = client.getDatabase("test").getCollection("my_collection");

//     try {
// //      var document = MongoDocument({
// //        "time": DateTime.now().millisecondsSinceEpoch,
// //        "name": "hadar",
// //        "age": 27,
// //        "dogs": [
// //          "shocko",
// //          "nuna"
// //        ]
// //      });
// //
// //      collection.insertOne(document);

//       collection.insertMany([
//         MongoDocument({
//           "time": DateTime.now().millisecondsSinceEpoch,
//           "username": "moshe",
//           "grades": [90, 98],
//         }),
//         MongoDocument({
//           "time": DateTime.now().millisecondsSinceEpoch,
//           "username": "adiel",
//           "age": [77, 55, 91],
//         }),
//       ]);
//     } on PlatformException {
//       debugPrint("Error!!!");
//     }
//   }

  //   Future<User?> getUser(String userName, String password) async {
  //     //await userDB.init();
  //     final user = await userDB.userdb!.query('users',
  //         where: 'name = ? AND password = ?', whereArgs: [userName, password]);
  //     if (user.isEmpty) {
  //       return null;
  //     } else {
  //       return User.fromMap(user.first);
  //     }
  //   }
// //    Future<void> fetchData() async {
//     // sample_mflix.comments
//     // test.my_collection
//     var collection = client.getDatabase("test").getCollection("my_collection");

//     try {
// //      var document = MongoDocument.fromMap({
// //        "time": DateTime.now().millisecondsSinceEpoch,
// //        "user_id": "abcdefg",
// //        "price": 31.78432
// //      });

// //      var size = await collection.count({
// //        // "name": "kfir"
// //        "name": "Taylor Scott",
// //      });
// //      print(size);

// //      var docs = await collection.find(
// //          filter: {
// //            "year": QueryOperator.gt(2010)..lte(2014),
// //            // "year":{"$gt":2010,"$lte":2014}
// //      });
// //      print(docs.length);

// //      var doc = await collection.findOne({
// //        //"name": "kfir",
// //        "name": "Taylor Scott",
// //      });
// //      int ssaa = 232;

//       /// with projection/limit
//       var docs = await collection.find(
//         filter: {
//           "name": "naama",
//         },
// //        options: RemoteFindOptions(
// //            projection: {
// //              "title": ProjectionValue.INCLUDE,
// //              "rated": ProjectionValue.INCLUDE,
// //              "year": ProjectionValue.INCLUDE,
// //            },
// //            limit: 70,
// //            sort: {
// //              "year": OrderValue.DESCENDING,
// //            }),
//       );
// //      print(doc.get("_id"));
// //      print(docs.length);

//       docs.forEach((doc) {
//         print(doc.get("_id"));
//       });

// //      /// with projection
// //      var doc = await collection.findOne(
// ////        filter: {
// ////          "year": 2014,
// ////        },
// ////        projection: {
// ////          "title": ProjectionValue.INCLUDE,
// ////          "rated": ProjectionValue.INCLUDE,
// ////          "year": ProjectionValue.INCLUDE,
// ////        },
// //      );
// //      print(doc.map);
//     } on PlatformException catch (e) {
//       debugPrint("Error: $e");
//     }
//   }

  //   Future<void> delete(String name) async {
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
