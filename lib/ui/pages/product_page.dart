import 'package:app_flutter/app/entities/stock_entities.dart';
import 'package:app_flutter/app/ui/tabs/product_page_tab.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Stock estoque;

  ProductPage(this.estoque);
  @override
  State<ProductPage> createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductPageTab(widget.estoque),
    );
  }
}
