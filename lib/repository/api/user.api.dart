import 'dart:convert';
import 'package:app_flutter/app/entities/user.dart';
import 'package:app_flutter/app/repository/local/user_repository.dart';
import 'package:app_flutter/app/shared/constants.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static final UserApi instance = UserApi._();

  UserApi._();

  Future<User> signIn(String username, String password) async {
    var encodeString = {
      "email": username,
      "senha": password,
    };
    var encode = json.encode(encodeString);
    String url = "http://54.90.203.92/auth/login";

    print("LOG[USERAPI.LOGIN] -url $url");
    print("LOG[USERAPI.LOGIN] -encode $encode");

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: encode);
    if (response.statusCode == 200) {
      var responseData = json.decode(utf8.decode(response.bodyBytes));

      print("LOG[USERAPI.LOGIN] -ResponseData $responseData");
      User user = User.fromJson(responseData['data']);
      print("LOG[USERAPI.LOGIN] -User $user");
      await UserRepository.instance.saveUser(user);
      return user;
    } else {
      return null;
    }
  }

  Future logout() async {
    String url = Constants.BASE_URL_API + "/auth/logout";
    User user = await UserRepository.instance.getUser();
    String authorization = "Bearer ${user.token}";
    print("LOG[USERAPI.LOGOUT] -url $url");

    var response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      "Authorization": authorization,
    });

    await UserRepository.instance.deleteUser();
    if (response.statusCode == 200) {
      var responseData = json.decode(utf8.decode(response.bodyBytes));

      return responseData['message'];
    } else {
      return null;
    }
  }
}
