import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ControllersFunction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static String formataData(String dataParamet) {
    DateTime dateTime = DateTime.parse(dataParamet);
    String dataFormatada = DateFormat('dd/MM/yyyy').format(dateTime);
    return dataFormatada;
  }

  static String desvormataData(String dataParamet) {
    String formato = 'dd/MM/yyyy';

    DateTime data = DateTime.parse(
      DateFormat(formato).parse(dataParamet).toString(),
    );

    return data.toString();
  }
}
