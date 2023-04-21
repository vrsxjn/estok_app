import 'package:app_flutter/app/entities/stock_entities.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Json verificar', () {
    Map<String, dynamic> json = {
      "id": 1,
      "descricao": "TESTE",
      "quantidade_total": 10,
      "data_entrada": "2022-04-08",
      "data_validade": "2023-04-08",
      "tipo": "CAIXA",
      "status_estoque": "EM ESTOQUE"
    };

    Stock stock = Stock.fromJson(json);

    expect(stock.id, 1);
    expect(stock.descricao, 'TESTE');
    expect(stock.quantidade_total, 10);
    expect(stock.data_entrada, '2022-04-08');
    expect(stock.data_validade, '2023-04-08');
    expect(stock.tipo, 'CAIXA');
    expect(stock.status_estoque, 'EM ESTOQUE');
  });
}
