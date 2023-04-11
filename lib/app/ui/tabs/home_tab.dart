import 'package:app_flutter/app/entities/stock_entities.dart';
import 'package:app_flutter/app/models/stock_model.dart';
import 'package:app_flutter/app/ui/tile/stock_tite.dart';
import 'package:app_flutter/app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTab extends StatefulWidget {
  final String type;
  List filterDataParament;
  HomeTab(this.type);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

  void _reload() {
    StockModel.of(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StockModel>(
        builder: (context, child, stockModel) {
      return FutureBuilder(
          future: widget.type != "TODOS"
              ? stockModel.futureHomeList.then((value) => value
                  .where((element) => element.status_estoque == widget.type)
                  .toList())
              : stockModel.futureHomeList,
          builder: (BuildContext context, AsyncSnapshot<List<Stock>> snapshot) {
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
                      message: "Não foi possivel obter os dados do estoque");
                } else if (snapshot.data.isEmpty) {
                  return Message(
                      message: "Nenhum estoque encontrado", fontSize: 16);
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
                        return StockTite(
                          snapshot.data[index],
                        );
                      },
                    ),
                  );
                }
            }
          });
    });
  }
}
