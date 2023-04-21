import 'package:app_flutter/app/entities/stock_entities.dart';
import 'package:app_flutter/app/models/stock_model.dart';
import 'package:app_flutter/app/ui/pages/product_page.dart';
import 'package:app_flutter/app/ui/widgets/message.dart';
import 'package:flutter/material.dart';

class StockTite extends StatelessWidget {
  final Stock stock;
  Color colorIcon;
  Color colorText;

  StockTite(this.stock);

  @override
  Widget build(BuildContext context) {
    if (this.stock.status_estoque == "EM ESTOQUE") {
      colorIcon = Colors.green;
      colorText = Colors.green;
    } else if (this.stock.status_estoque == "EM AVISO") {
      colorIcon = Colors.yellow;
      colorText = Colors.yellow;
    } else if (this.stock.status_estoque == "EM FALTA") {
      colorIcon = Colors.red;
      colorText = Colors.red;
    }
    ;
    return Padding(
        padding: EdgeInsets.only(
          top: 10.0,
          left: 5,
          right: 5,
        ),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () {
                _estoqueProduct(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE7EFF2),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.stock.descricao,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'TOTAL: ${this.stock.quantidade_total}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'TIPO: ${this.stock.tipo}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.brightness_1,
                              color: colorIcon,
                              size: 20,
                            ),
                            Text(
                              this.stock.status_estoque,
                              style: TextStyle(
                                color: colorText,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  void _estoqueProduct(BuildContext context) {
    StockModel.of(context).stockID(this.stock.id, onSuccess: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return ProductPage(this.stock);
      }));
      return;
    }, onFail: (String message) {
      Message.onFail(
        message: message,
        seconds: 4,
      );
      return;
    });
  }
}
