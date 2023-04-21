import 'package:flutter/material.dart';

class ProductValidator {
  String validateImage(ImageProvider image) {
    if (image is NetworkImage && image.url.isEmpty) {
      return 'Campo vazio';
    } else if (image is AssetImage && image.assetName.isEmpty) {
      return 'Campo Vazio';
    } else {
      return null;
    }
  }

  String validatorName(String value) {
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

  String validatorDescricao(String value) {
    if (value.isEmpty) {
      return "Campo vazio";
    } else if (value.length > 32) {
      return "Campo deve conter no maximo 32 caracteres";
    } else if (value.length < 3) {
      return "Campo deve conter no minimo 3 caracteres";
    } else {
      return null;
    }
  }

  String validatorValorItem(String value) {
    if (value.isEmpty) {
      return "Campo vazio";
    } else {
      return null;
    }
  }

  String validatorUnitItem(String value) {
    if (value.isEmpty) {
      return "Campo vazio";
    } else {
      return null;
    }
  }

  String validatorQuantity(String value) {
    if (value.isEmpty) {
      return "Campo vazio";
    } else {
      return null;
    }
  }

  String validatorSit(String value) {
    if (value.isEmpty) {
      return 'Campo vazio';
    } else if (!value.endsWith('.com')) {
      return 'O valor deve terminar com ".com"';
    }
    return null;
  }
}
