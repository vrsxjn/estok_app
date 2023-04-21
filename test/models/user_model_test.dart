import 'package:app_flutter/app/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('login sem resultado', () async {
    UserModel userModel = UserModel();
    String username;
    String password;
    String errorMessage;

    await userModel.login(username, password, onFail: (message) {
      errorMessage = message;
    });

    expect(userModel.userStatus, UserChangeStatus.IDLE);
    expect(errorMessage, 'Erro ao efetuar login para $username');
  });
}
