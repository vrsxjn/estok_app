import 'dart:convert';
import 'package:app_flutter/app/entities/product_entities.dart';
import 'package:app_flutter/app/entities/user.dart';
import 'package:app_flutter/app/repository/local/user_repository.dart';
import 'package:app_flutter/app/shared/constants.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static final ProductApi instance = ProductApi._();

  ProductApi._();

  Future<List<Product>> getProduct(int id) async {
    List<Product> productList;
    try {
      String url = Constants.BASE_URL_API + '/estoques/${id}/produtos/';
      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      print("LOG[PRODUCT.ALL] -url $url");
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": authorization
      });

      if (response.statusCode != 200) {
        print(
            "LOG[PRODUCT.ALL] - Negado pelo servidor: ${response.statusCode}");
        return null;
      }
      var responseData = json.decode(utf8.decode(response.bodyBytes));

      responseData = responseData['data'];

      print("LOG[PRODUCT.ALL] - ResponseData $responseData");

      productList = (responseData as List)?.map((json) {
        return Product.fromJson(json as Map<String, dynamic>);
      })?.toList();
      return productList;
    } on Exception catch (error) {
      print("Log[CarApi] -error: $error");
      return null;
    }
  }

  Future<Map<String, dynamic>> deleteProduct(int id, int idProduct) async {
    try {
      String url =
          Constants.BASE_URL_API + "/estoques/${id}/produtos/${idProduct}";

      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      print("LOG[PRODUCT.DELET] - url $url");
      print("LOG[PRODUCT.DELET] - Auth $authorization");

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
      print("LOG[PRODUCT.DELET] - error: $error");
      return null;
    }
  }

  Future<Product> saveProduct(int id, Product produto) async {
    try {
      var encode = json.encode(produto.toJson());
      String url = Constants.BASE_URL_API + '/estoques/${id}/produtos/';
      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      print("LOG[PRODUCT.SAVE] - url $url");
      print("LOG[PRODUCT.SAVE] - Auth $authorization");

      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": authorization,
          },
          body: encode);

      if (response.statusCode == 200) {
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        Product produto = Product.fromJson(responseData);
        return produto;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print("LOG[PRODUCT.SAVE] - error: $error");
      return null;
    }
  }

  Future<Product> upsateProduct(int id, Product produto) async {
    try {
      var encode = json.encode(produto.toJsonPut());
      String url = Constants.BASE_URL_API + '/estoques/${id}/produtos/';
      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      print("LOG[PRODUCT.UPDATE] - url $url");
      print("LOG[PRODUCT.UPDATE] - Auth $authorization");

      var response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": authorization,
          },
          body: encode);

      if (response.statusCode == 200) {
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        Product produto = Product.fromJson(responseData);
        return produto;
      } else {
        return null;
      }
    } on Exception catch (error) {
      print("LOG[ESTOQUE.SAVE] - error: $error");
      return null;
    }
  }
}
