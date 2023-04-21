import 'package:app_flutter/app/entities/historic_db.dart';
import 'package:app_flutter/app/models/product_model.dart';
import 'package:app_flutter/app/ui/tile/historic_tite.dart';
import 'package:app_flutter/app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoricTab extends StatefulWidget {
  @override
  State<HistoricTab> createState() => _HistoricTab();
}

class _HistoricTab extends State<HistoricTab> {
  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    ProductModel.of(context).carregarHistorico();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(
        builder: (context, child, estoqueModel) {
      return FutureBuilder<List<HistoricDb>>(
          future: estoqueModel.historicProduct,
          builder:
              (BuildContext context, AsyncSnapshot<List<HistoricDb>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Message(
                    message: 'Não foi possível obter os dados do historico');
              case ConnectionState.waiting:
                return Message.loading(context);
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Message(
                      message: "Não foi possível obter os dados do servidor");
                } else if (!snapshot.hasData) {
                  return Message(
                      message: "Não foi possível obter os dados do historico");
                } else if (snapshot.data.isEmpty) {
                  return Message(
                      message: "Nenhum dado do historico encontrado",
                      fontSize: 16);
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      this._reload();
                    },
                    child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HistoricTite(
                          snapshot.data[index],
                        );
                      },
                    ),
                  );
                }
                break;
              default:
                return Container();
            }
          });
    });
  }
}
