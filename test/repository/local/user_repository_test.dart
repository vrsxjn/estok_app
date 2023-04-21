import 'dart:convert';

import 'package:app_flutter/app/entities/user.dart';
import 'package:app_flutter/app/repository/local/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('saveUser salvar', () async {
    final user =
        User(name: 'Roberto Secanechia', email: 'beto.secanechia@hotmail.com');
    final userRepository = UserRepository.instance;

    await userRepository.saveUser(user);

    final instance = await SharedPreferences.getInstance();
    final userString = instance.getString('user.prefs');

    final expectedJson = json.encode(user.toJson());

    expect(userString, expectedJson);
  });
}
