import '../model/user_model.dart';
import '../services/user_db_service.dart';

class UserRepo {
  final userDB = UsersDataBase();

  Future<void> createUser(User user) async {
    await userDB.init();
    await userDB.insertA(user);
  }

  Future<User?> getUser(String userName, String password) async {
    await userDB.init();
    final user = await userDB.userdb!.query('users',
        where: 'name = ? AND password = ?', whereArgs: [userName, password]);
    if (user.isEmpty) {
      return null;
    } else {
      return User.fromMap(user.first);
    }
  }
}
