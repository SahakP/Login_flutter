import '../../model/user_model.dart';
import '../../services/mongoServices/user_mongo_service.dart';

class UserMongoRepo {
  final userDB = UserMongoService();

  Future<void> createUser(User user) async {
    await userDB.insertData(user);
  }

  Future<User?> getUser(String userName, String password) async {
    final user = await userDB.getUser(userName, password);
    return user;
  }

  Future<void> deleteUser(User user) async {
    await userDB.deleteUser(user);
  }

  Future<void> updateUser(User user, _doc) async {
    await userDB.updateUser(user, _doc);
  }
}
