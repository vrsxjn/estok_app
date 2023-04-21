import 'dart:convert' as convert;
import 'dart:io';

import 'package:app_flutter/entities/user.dart';
import 'package:app_flutter/repository/local/user_repository.dart';
import 'package:app_flutter/shared/constants.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class UploadApi {
  static final UploadApi instance = UploadApi._();

  UploadApi._();

  Future<String> uploadFile(File file) async {
    try {
      String url = Constants.BASE_URL_API + '/images/upload';
      User user = await UserRepository.instance.getUser();
      String authorization = "Bearer ${user.token}";

      List<int> imageBytes = file.readAsBytesSync();
      String imageBase64 = convert.base64Encode(imageBytes);
      String fileName = path.basename(file.path);

      var parametros = {
        'file_name': fileName,
        'mime_type': 'image/jpeg',
        'base64': imageBase64,
      };
      var encode = convert.json.encode(parametros);

      print("LOG[UPLOADAPI - uploadFile] - url: $url");
      print("LOG[UPLOADAPI - uploadFile] - Authorization: $authorization");
      print("LOG[UPLOADAPI - uploadFile] - encode $encode");

      var response = await http
          .post(url,
              headers: {
                'Content-Type': 'application/json',
                "Authorization": authorization,
              },
              body: encode)
          .timeout(Duration(seconds: 120), onTimeout: () {
        print(
            "LOG[UPLOADAPI - upload file] - onTimeout: Não foi possivel se comunicar com o servidor");
        throw SocketException(
            'LOG[UPLOADAPI - upload file] - Não foi possivel se comunicar com o sevidor');
      });
      if (response.statusCode == 200) {
        var responseData =
            convert.json.decode(convert.utf8.decode(response.bodyBytes));
        print("LOG[UploadApi.uploadFile] - responseData $responseData");

        var filtroResponse = responseData['data'];

        String urlImagem = filtroResponse['url_image'];
        return urlImagem;
      }
    } on Exception catch (error) {
      print("LOG[UPLOADAPI - upload file] - error: $error");
      return null;
    }
  }
}
