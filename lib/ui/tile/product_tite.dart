import 'package:app_flutter/entities/product_entities.dart';
import 'package:app_flutter/ui/pages/register_product.dart';
import 'package:app_flutter/util/share.dart';
import 'package:flutter/material.dart';

class ProductTite extends StatelessWidget {
  final Product product;
  final num id;

  ProductTite(this.id, {this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 10.0,
          left: 0,
          right: 0,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  this.product.image,
                  width: 80,
                  height: 80,
                ),
                SizedBox(
                  width: 170,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.product.nome,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF58355E),
                          ),
                          softWrap: false,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          this.product.descricao,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF949191)),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text('${this.product.quantidade}'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Text("R\$ ${this.product.valor_item}",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF58355E),
                        )),
                    Text(
                      "R\$ ${this.product.valor_unitario}",
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                          ),
                          // highlightColor: Colors.pink,
                          //   padding: EdgeInsets.only(bottom: 20),
                          onPressed: () {
                            ShareUtil.shareLink(this.product.site);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.create,
                          ),
                          // highlightColor: Colors.pink,
                          //   padding: EdgeInsets.only(bottom: 20),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return RegisterProduct(this.id,
                                  produto: this.product);
                            }));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              height: 20,
            )
          ],
        ));
  }
}
