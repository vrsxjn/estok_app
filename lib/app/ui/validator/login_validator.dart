class LoginValidator {
  bool _isInvalidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !emailRegex.hasMatch(email);
  }

  String validateLogin(String value) {
    if (value.isEmpty) {
      return "Campo vazio";
    } else if (_isInvalidEmail(value) == true) {
      return "Erro ao informa o email";
    } else {
      return null;
    }
  }

  String validateSenha(String value) {
    if (value.isEmpty) {
      return "Campo vazio";
    } else if (value.length < 8) {
      return "Campo deve conter no mínimo 8 caracteres";
    } else {
      return null;
    }
  }
}
