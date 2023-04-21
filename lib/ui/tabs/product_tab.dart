import 'package:app_flutter/app/entities/product_entities.dart';
import 'package:app_flutter/app/models/product_model.dart';
import 'package:app_flutter/app/ui/tile/product_tite.dart';
import 'package:app_flutter/app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductTabe extends StatefulWidget {
  final int type;
  ProductTabe(this.type);

  @override
  State<ProductTabe> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTabe> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(
        builder: (context, child, estoqueModel) {
      return FutureBuilder(
          future: estoqueModel.futureProduct,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Message(
                    message: "Não foi possivel obter os dados necessários");
              case ConnectionState.waiting:
                return Message.loading(context);
              default:
                if (snapshot.hasError) {
                  return Message(
                      message: "Não foi possivel obter os dados do servidor");
                } else if (!snapshot.hasData) {
                  return Message(
                      message: "Não foi possivel obter os dados da pagina");
                } else if (snapshot.data.isEmpty) {
                  return Message(
                      message: "Nenhum dado encontrado", fontSize: 16);
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      child:
                      ProductTite(
                        widget.type,
                        product: (snapshot.data[index]),
                      );
                    },
                  );
                }
            }
          });
    });
  }
}
