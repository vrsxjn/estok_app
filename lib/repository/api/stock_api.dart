import 'dart:convert';

import 'package:app_flutter/app/entities/product_entities.dart';
import 'package:app_flutter/app/entities/stock_entities.dart';
import 'package:app_flutter/app/entities/user.dart';
import 'package:app_flutter/app/repository/local/user_repository.dart';
import 'package:app_flutter/app/shared/constants.dart';
import 'package:http/http.dart' as http;

class StockApi {
  static final StockApi instance = StockApi._();

  StockApi._();

  Future<List<Product>> signIn(int id) async {
    List<Product> productList;

    try {
      String url = Constants.BASE_URL_API + "/estoques/${id}/produtos/";
      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      print("LOG[STOCK.CLICK] - url $url");

      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });
      if (response.statusCode != 200) {
        print(
            "LOG[STOCK.CLICK] - Negado pelo servidor: ${response.statusCode}");
        return null;
      }

      var responseData = json.decode(utf8.decode(response.bodyBytes));

      responseData = responseData['data'];

      productList = (responseData as List)?.map((json) {
        return Product.fromJson(json as Map<String, dynamic>);
      })?.toList();

      return productList;
    } on Exception catch (error) {
      print("LOG[STOCK.CLICK] -error: $error");
      return null;
    }
  }

  Future<List<Stock>> getAll() async {
    List<Stock> estoqueList;
    try {
      String url = Constants.BASE_URL_API + "/estoques/";

      User usuario = await UserRepository.instance.getUser();

      String authorization = 'Bearer ${usuario.token}';

      print("LOG[STOCK.ALL] - url $url");

      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });

      if (response.statusCode != 200) {
        print("LOG[STOCK.ALL] - Negado pelo servidor: ${response.statusCode}");
        return null;
      }
      var responseData = json.decode(utf8.decode(response.bodyBytes));

      responseData = responseData['data'];

      print("LOG[STOCK.ALL] - ResponseData $responseData");

      estoqueList = (responseData as List)?.map((json) {
        return Stock.fromJson(json as Map<String, dynamic>);
      })?.toList();

      return estoqueList;
    } on Exception catch (error) {
      print("Log[STOCK.ALL] -error: $error");
      return null;
    }
  }

  Future<Stock> save(Stock estoque) async {
    try {
      var encode = json.encode(estoque.toJson());

      String url = Constants.BASE_URL_API + '/estoques/';
      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      print("LOG[STOCK.SAVE] - url $url");
      print("LOG[STOCK.SAVE] - Auth $authorization");

      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": authorization,
          },
          body: encode);

      if (response.statusCode == 200) {
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        Stock estoque = Stock.fromJson(responseData);
        return estoque;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print("LOG[STOCK.SAVE] - error: $error");
      return null;
    }
  }

  Future<Stock> update(Stock estoque) async {
    try {
      var encode = json.encode(estoque.toJsonPut());

      String url = Constants.BASE_URL_API + '/estoques/';
      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      print("LOG[STOCK.UPDATE] - url $url");
      print("LOG[STOCK.UPDATE] - Auth $authorization");

      var response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": authorization,
          },
          body: encode);

      if (response.statusCode == 200) {
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        Stock estoque = Stock.fromJson(responseData);
        return estoque;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print("LOG[STOCK.UPDATE] - error: $error");
      return null;
    }
  }

  Future<Map<String, dynamic>> delete(int id) async {
    try {
      String url = Constants.BASE_URL_API + "/estoques/${id}";

      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      print("LOG[STOCK.DELETE] - url $url");
      print("LOG[STOCK.DELETE] - Auth $authorization");

      var response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        "Authorization": authorization,
      });

      if (response.statusCode == 200) {
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        return responseData;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print("LOG[STOCK.DELETE] - error: $error");
      return null;
    }
  }
}
