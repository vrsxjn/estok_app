import 'package:app_flutter/app/entities/historic_db.dart';
import 'package:app_flutter/app/repository/local/database/historic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConvert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void salvarBancodDadaos(
    String att,
    String type,
  ) async {
    DateTime now = DateTime.now();
    var formatoDataBr = DateFormat('dd/MM/yyyy').format(now);

    HistoricDb historic = HistoricDb(
        att: '${att} ',
        type: '${type}',
        date: '${formatoDataBr}',
        hour: '${now.hour.toString()}:${now.minute.toString()}');

    await HistoricDatabase.instance.save(historic);
  }
}
