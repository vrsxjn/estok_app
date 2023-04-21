import 'package:intl/intl.dart';

class EstoqueValidator {
  String validatorDescricao(String value) {
    if (value.isEmpty) {
      return "Campo vazio";
    } else if (value.length > 16) {
      return "Campo deve conter no maximo 16 caracteres";
    } else if (value.length < 3) {
      return "Campo deve conter no minimo 3 caracteres";
    } else {
      return null;
    }
  }

  String validatorData(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    final date = DateFormat('dd/MM/yyyy').parseStrict(value);
    if (date.isBefore(DateTime(2020))) {
      return 'Data selecionada é anterior a 2020';
    } else if (date.isAfter(DateTime(2040))) {
      return 'Data selecionada é posterior a 2040';
    } else if (date.year < 2020) {
      return 'Data selecionada é anterior a 2022';
    }
    return null;
  }
}
