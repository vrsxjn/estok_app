import 'package:app_flutter/app/repository/local/database/historic.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class InitDb {
  static Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'estok_app');

    return openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          'CREATE TABLE ${HistoricDatabase.tableName} (${HistoricDatabase.id} AUTO INCREMENT PRIMARY KEY, ${HistoricDatabase.atualizacao} TEXT, ${HistoricDatabase.type} TEXT,${HistoricDatabase.data} TEXT, ${HistoricDatabase.hora} TEXT)');
    });
  }
}
