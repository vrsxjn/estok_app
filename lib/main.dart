import 'package:app_flutter/models/product_model.dart';
import 'package:app_flutter/models/stock_model.dart';
import 'package:app_flutter/models/user_model.dart';
import 'package:app_flutter/ui/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp(
    UserModel(),
    ProductModel(),
    StockModel(),
  ));
}

class MyApp extends StatefulWidget {
  final UserModel userScopedModel;
  final ProductModel productScopedModel;
  final StockModel stockscopedModel;

  MyApp(
    this.userScopedModel,
    this.productScopedModel,
    this.stockscopedModel,
  );
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: widget.userScopedModel,
      child: ScopedModel(
        model: widget.productScopedModel,
        child: ScopedModel(
          model: widget.stockscopedModel,
          child: MaterialApp(
              title: 'ESTOK APP',
              theme: ThemeData(
                primaryColor: Color(0xFF58355E),
                scaffoldBackgroundColor: Colors.white,
              ),
              debugShowCheckedModeBanner: false,
              home: SplashScreenPage()),
        ),
      ),
    );
  }
}
