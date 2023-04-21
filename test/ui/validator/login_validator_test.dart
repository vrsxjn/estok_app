import 'package:app_flutter/ui/validator/login_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginValidator', () {
    test('validateSenha senha vazia', () {
      final validator = LoginValidator();
      final emptyPassword = '';

      final result = validator.validateSenha(emptyPassword);

      expect(result, equals('Campo vazio'));
    });

    test('validateSenha deve conter 8 letras', () {
      final validator = LoginValidator();
      final shortPassword = '1';

      final result = validator.validateSenha(shortPassword);

      expect(result, equals('Campo deve conter no mínimo 8 caracteres'));
    });

    test('validateSenha nulo', () {
      final validator = LoginValidator();
      final validPassword = 'SenhaTesteNula';

      final result = validator.validateSenha(validPassword);

      expect(result, isNull);
    });
  });
}
