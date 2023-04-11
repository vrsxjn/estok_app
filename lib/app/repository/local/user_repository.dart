import 'dart:convert';

import 'package:app_flutter/app/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._();

  UserRepository._();

  Future<void> saveUser(User user) async {
    String userString = json.encode(user.toJson());
    var instance = await SharedPreferences.getInstance();
    await instance.setString("user.prefs", userString);
    print("user:$userString salvo com sucesso");
  }

  Future<User> getUser() async {
    var instance = await SharedPreferences.getInstance();
    String userString = await instance.getString("user.prefs");

    instance.setString('user.prefs', userString);

    if (userString == null || userString.isEmpty) {
      return null;
    }

    Map<String, dynamic> userJson = json.decode(userString);
    User user = User.fromJson(userJson);

    return user;
  }

  Future<void> deleteUser() async {
    var instance = await SharedPreferences.getInstance();
    await instance.getString("user.prefs");
  }
}
