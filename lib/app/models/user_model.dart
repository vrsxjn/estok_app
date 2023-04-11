import 'package:app_flutter/app/repository/api/user.api.dart';
import 'package:app_flutter/app/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

enum UserChangeStatus { LOADING, IDLE }

class UserModel extends Model {
  UserChangeStatus userStatus = UserChangeStatus.IDLE;

  User user;

  static UserModel of(BuildContext context) {
    return ScopedModel.of<UserModel>(context);
  }

  setState() {
    notifyListeners();
  }

  void login(String username, String password,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    userStatus = UserChangeStatus.LOADING;
    setState();
    user = await UserApi.instance.signIn(username, password);
    if (user != null) {
      userStatus = UserChangeStatus.IDLE;
      setState();
      onSuccess();
    } else {
      userStatus = UserChangeStatus.IDLE;
      setState();
      onFail("Erro ao efetuar login para $username");
    }
  }

  void logout(
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    userStatus = UserChangeStatus.LOADING;
    setState();

    var response = await UserApi.instance.logout();
    if (response != null) {
      userStatus = UserChangeStatus.IDLE;
      setState();
      onSuccess();
    } else {
      userStatus = UserChangeStatus.IDLE;
      setState();
      onFail("Erro ao deslogar usuário ");
    }
  }
}
