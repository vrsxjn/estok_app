import 'package:app_flutter/entities/product_entities.dart';
import 'package:app_flutter/entities/stock_entities.dart';
import 'package:app_flutter/repository/api/stock_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

enum StockChangeStatus { LOADING, IDLE }

class StockModel extends Model {
  Future<List<Stock>> futureHomeList;
  Future<List<Product>> stock;
  StockChangeStatus stockStatus = StockChangeStatus.IDLE;

  static StockModel of(BuildContext context) {
    return ScopedModel.of<StockModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetch() async {
    this.futureHomeList =
        Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    setState();
    this.futureHomeList = StockApi.instance.getAll();

    setState();
  }

  Future<void> stockID(int id,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    this.stock = StockApi.instance.signIn(id);
    if (this.stock != null) {
      onSuccess();
    } else {
      onFail("Erro ao efetuar login para $id");
    }
  }

  void adcionarEstoque(Stock estoque,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    stockStatus = StockChangeStatus.LOADING;
    setState();

    Stock estoqueSalvar = await StockApi.instance.save(estoque);
    if (estoqueSalvar != null) {
      stockStatus = StockChangeStatus.IDLE;
      setState();

      estoque = estoqueSalvar;
      onSuccess();
    } else {
      stockStatus = StockChangeStatus.IDLE;
      setState();

      onFail('Erro ao adicionar estoque');
    }
    setState();
  }

  void alterarEstoque(Stock estoque,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    stockStatus = StockChangeStatus.LOADING;
    setState();

    Stock estoqueAlterado = await StockApi.instance.update(estoque);

    if (estoqueAlterado != null) {
      stockStatus = StockChangeStatus.IDLE;
      setState();
      estoque = estoqueAlterado;
      onSuccess();
    } else {
      stockStatus = StockChangeStatus.IDLE;
      setState();
      onFail('Erro ao adicionar estoque');
    }
    setState();
  }

  void deletarEstoque(Stock estoque,
      {VoidCallback onSuccess(String message),
      VoidCallback onFail(String message)}) async {
    Map<String, dynamic> messageData =
        await StockApi.instance.delete(estoque.id);
    if (messageData != null) {
      String message = messageData['msg'];
      onSuccess(message);
    } else {
      onFail('Erro ao deletar o Estoque');
    }
    setState();
  }
}
