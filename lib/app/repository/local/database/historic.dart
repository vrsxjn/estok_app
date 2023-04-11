import 'package:app_flutter/app/entities/historic_db.dart';
import 'package:app_flutter/app/repository/local/database/init_db.dart';
import 'package:sqflite/sqflite.dart';

class HistoricDatabase {
  static final String tableName = 'historico';
  static final String id = "id";
  static final String atualizacao = "att";
  static final String type = "type";
  static final String data = "date";
  static final String hora = "hour";

  static final HistoricDatabase instance = HistoricDatabase._();
  HistoricDatabase._();

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await InitDb.initDatabase();
    }
    return _database;
  }

  Future<HistoricDb> save(HistoricDb historic) async {
    Database db = await database;
    historic.id = await db.insert(tableName, historic.toJson());
    return historic;
  }

  Future<List<HistoricDb>> listar() async {
    Database db = await database;
    List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM $tableName');
    List<HistoricDb> historic = maps.map((e) {
      return HistoricDb.fromJson(e);
    }).toList();
    return historic;
  }
}
