import 'dart:async';
import 'package:gcet_app/models/forgotpass.dart';
import 'package:gcet_app/models/user_model.dart';
import 'package:gcet_app/models/api_model.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/db/user_dao.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    required String username,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<Forgot> forgotPassword({required username}) async {
    Forgot res = await forgotsubmit(username);
    return res;
  }

  Future<void> persistToken({required User user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future<void> deleteToken({required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}
