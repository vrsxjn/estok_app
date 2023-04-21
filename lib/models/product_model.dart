import 'dart:io';
import 'dart:async';

import 'package:app_flutter/entities/historic_db.dart';
import 'package:app_flutter/entities/product_entities.dart';
import 'package:app_flutter/entities/stock_entities.dart';
import 'package:app_flutter/repository/api/product_api.dart';
import 'package:app_flutter/repository/api/uploadApi.dart';
import 'package:app_flutter/repository/local/database/historic.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

enum ProductChangeStatus { LOADING, IDLE }

class ProductModel extends Model {
  Future<List<Stock>> futureHomeList;
  Future<List<Product>> futureProduct;
  Future<List<HistoricDb>> historicProduct;
  File file;
  ProductChangeStatus productStatus = ProductChangeStatus.IDLE;

  static ProductModel of(BuildContext context) {
    return ScopedModel.of<ProductModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetchProduct(int id) async {
    this.futureProduct =
        Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    setState();
    this.futureProduct = ProductApi.instance.getProduct(id);
    setState();
  }

  Future<void> carregarHistorico() async {
    this.futureProduct =
        Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    setState();
    this.historicProduct =
        Future.value(await HistoricDatabase.instance.listar());
    setState();
  }

  void deletarProduto(int id, int produto,
      {VoidCallback onSuccess(String message),
      VoidCallback onFail(String message)}) async {
    Map<String, dynamic> messageData =
        await ProductApi.instance.deleteProduct(id, produto);
    if (messageData != null) {
      String message = messageData['msg'];
      onSuccess(message);
    } else {
      onFail('Erro ao deletar o Produto');
    }
    setState();
  }

  void adicionarProduto(int id, Product produto,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    if (file != null) {
      productStatus = ProductChangeStatus.LOADING;
      setState();
      String urlImage = await enviarImageFile(file);

      if (urlImage != null) {
        produto.image = urlImage;
        file = null;
      } else {
        productStatus = ProductChangeStatus.IDLE;
        setState();
        onFail('Erro ao enviar a imagem do produto para o sevidor');
        return;
      }
    }

    Product produtoSalvar = await ProductApi.instance.saveProduct(id, produto);

    if (produtoSalvar != null) {
      productStatus = ProductChangeStatus.IDLE;
      setState();
      produto = produtoSalvar;
      onSuccess();
    } else {
      productStatus = ProductChangeStatus.IDLE;
      setState();
      onFail('Erro ao adicionar estoque');
    }
    setState();
  }

  void updateProduct(int id, Product produto,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    if (file != null) {
      String urlImage = await enviarImageFile(file);

      if (urlImage != null) {
        produto.image = urlImage;
        file = null;
      } else {
        productStatus = ProductChangeStatus.IDLE;
        setState();
        onFail('Erro ao enviar a imagem do produto para o sevidor');
        return;
      }
    }

    Product produtoSalvar =
        await ProductApi.instance.upsateProduct(id, produto);

    if (produtoSalvar != null) {
      productStatus = ProductChangeStatus.IDLE;
      setState();
      produto = produtoSalvar;
      onSuccess();
    } else {
      productStatus = ProductChangeStatus.IDLE;
      setState();
      onFail('Erro ao adicionar estoque');
    }
    setState();
  }

  Future<String> enviarImageFile(File file) async {
    return await UploadApi.instance.uploadFile(file);
  }
}
