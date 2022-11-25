// import 'package:snap_chat_copy/services/sqlServices/user_sql_service.dart';

// import '../../model/user_model.dart';

// class UserRepo {
//   final userDB = UserSqlService();

//   Future<void> createUser(User user) async {
//     await userDB.init();
//     await userDB.insertData(user);
//   }

//   Future<User?> getUser(String userName, String password) async {
//     await userDB.init();
//     final user = await userDB.userdb!.query('users',
//         where: 'name = ? AND password = ?', whereArgs: [userName, password]);
//     if (user.isEmpty) {
//       return null;
//     } else {
//       return User.fromMap(user.first);
//     }
//   }
// }
