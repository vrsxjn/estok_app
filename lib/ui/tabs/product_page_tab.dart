import 'package:app_flutter/app/components/custom_text_ui.dart';
import 'package:app_flutter/app/entities/product_entities.dart';
import 'package:app_flutter/app/entities/stock_entities.dart';
import 'package:app_flutter/app/models/product_model.dart';
import 'package:app_flutter/app/models/stock_model.dart';
import 'package:app_flutter/app/util/database_save.dart';
import 'package:app_flutter/app/ui/pages/register_product.dart';
import 'package:app_flutter/app/ui/pages/register_stock.dart';
import 'package:app_flutter/app/ui/tile/product_tite.dart';
import 'package:app_flutter/app/ui/widgets/dialog.dart';
import 'package:app_flutter/app/ui/widgets/dialog.dart';
import 'package:app_flutter/app/ui/widgets/message.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPageTab extends StatefulWidget {
  final Stock estoque;

  ProductPageTab(this.estoque);

  @override
  State<ProductPageTab> createState() => _ProductPageTabState();
}

class _ProductPageTabState extends State<ProductPageTab> {
  final _scarffoldKey = GlobalKey<ScaffoldState>();
  int quantidadeTotal;
  String status_product;
  Color status_colorText;
  double valorTotal;

  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    ProductModel.of(context).fetchProduct(widget.estoque.id);
  }

  String formataData(String dataParamet) {
    DateTime dateTime = DateTime.parse(dataParamet);
    String dataFormatada = DateFormat('dd/MM/yyyy').format(dateTime);
    return dataFormatada;
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
                      message: "Não foi possivel obter os dados do produto");
                } else {
                  int quantidadeReturn() {
                    var quantidade_array = [];
                    snapshot.data.forEach(
                        (element) => quantidade_array.add(element.quantidade));
                    int total = quantidade_array.reduce((a, b) => a + b);
                    return total;
                  }

                  if (snapshot.data.isEmpty) {
                    quantidadeTotal = 0;
                    status_product = widget.estoque.status_estoque;
                    valorTotal = 0;
                    if (widget.estoque.quantidade_total != 0) {
                      putProduct(widget.estoque, 0);
                    }
                    status_product = "EM FALTA";
                    status_colorText = Colors.red;
                  } else {
                    var quantidade = [];

                    snapshot.data.forEach(
                        (element) => quantidade.add(element.quantidade));
                    this.quantidadeTotal = quantidade.reduce((a, b) => a + b);
                    if (quantidadeTotal == 0) {
                      status_product = "EM FALTA";
                      status_colorText = Colors.red;
                    } else if (quantidadeTotal >= 1 && quantidadeTotal <= 5) {
                      status_product = "EM AVISO";
                      status_colorText = Colors.yellow;
                    } else if (quantidadeTotal > 5) {
                      status_product = "EM ESTOQUE";
                      status_colorText = Colors.green;
                    }

                    if (widget.estoque.quantidade_total != quantidadeTotal) {
                      putProduct(widget.estoque, quantidadeReturn());
                    }

                    valorTotal = 0;
                    snapshot.data.forEach((element) {
                      valorTotal += element.quantidade * element.valor_item;
                    });
                  }
                  return Scaffold(
                    key: _scarffoldKey,
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Color(0xFF58355E)),
                      backgroundColor: Color(0xFFF7F2F8),
                      centerTitle: true,
                      title: Text(
                        widget.estoque.descricao,
                        style: TextStyle(
                            color: Color(0xFF58355E), fontFamily: 'Montserrat'),
                      ),
                    ),
                    body: Container(
                        padding: EdgeInsets.all(17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextUi(
                                  labelText: "Tipo: ${widget.estoque.tipo}",
                                  fonte: 'Montserrat',
                                  fonteSize: 15,
                                  maxLine: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                CustomTextUi(
                                  labelText: "${quantidadeTotal}",
                                  fonte: 'Montserrat',
                                  fonteSize: 25,
                                  maxLine: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextUi(
                                  labelText:
                                      "Entrada em: ${formataData(widget.estoque.data_entrada)}",
                                  fonte: 'Montserrat',
                                  fonteSize: 15,
                                  maxLine: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                CustomTextUi(
                                  labelText: "${status_product}",
                                  fonte: 'Montserrat',
                                  fonteSize: 15,
                                  color: status_colorText,
                                  maxLine: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextUi(
                                  labelText:
                                      "Validade: ${formataData(widget.estoque.data_validade)}",
                                  fonte: 'Montserrat',
                                  fonteSize: 15,
                                  maxLine: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.create,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return RegisterStock(
                                          estoque: widget.estoque);
                                    })).then((value) async {
                                      reload();
                                    });
                                    ;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: CustomTextUi(
                                    labelText: "Valor Total: ${valorTotal}",
                                    fonte: 'Montserrat',
                                    fonteSize: 15,
                                    maxLine: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                  padding: EdgeInsets.only(bottom: 20),
                                  onPressed: () {
                                    _popSelector('deletar');
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomTextUi(
                                  labelText: "Produtos",
                                  fonte: 'Montserrat',
                                ),
                                Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(
                                          left: 40.0, right: 10.0),
                                      child: Divider(
                                        color: Colors.black,
                                        height: 40,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 400,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = snapshot.data[index].descricao;

                                  return Dismissible(
                                    key: Key(item),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      margin: EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      color: Colors.red,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 20.0, 0.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    confirmDismiss: (direction) {
                                      Message.alertDialog(
                                        context,
                                        title:
                                            'Deseja excluir o produto: ${widget.estoque.descricao}',
                                        subtitle:
                                            'A exclusão apagará todos os dados do produto',
                                        textokButton: "Ok",
                                        onPressOkbutton: () {
                                          Navigator.of(context).pop();

                                          if (snapshot.hasData &&
                                              snapshot.data.length > index) {
                                            _deletarProduto(widget.estoque.id,
                                                snapshot.data[index].id);
                                          }
                                          reload();
                                        },
                                        textNoButton: "Cancelar",
                                        onPressedNoButton: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        Dialogg.valorProduct(context,
                                            stockSave: snapshot.data[index],
                                            title: snapshot.data[index].nome,
                                            id: widget.estoque.id,
                                            subtitle:
                                                snapshot.data[index].quantidade,
                                            onPressOkbutton: () async {
                                          await putProduct(widget.estoque,
                                              quantidadeReturn());
                                        }, onPressedNoButton: () async {
                                          Navigator.of(context).pop();
                                        }, addPressedButton: null);
                                      },
                                      child: ProductTite(
                                        widget.estoque.id,
                                        product: (snapshot.data[index]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),

                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return RegisterProduct(widget.estoque.id);
                        })).then((value) async {
                          ProductModel.of(context)
                              .fetchProduct(widget.estoque.id);
                        });
                      },
                      backgroundColor: Color(0xFF58355E),
                      child: Icon(Icons.add),
                    ),
                    //EstoqueTabe("teste"),
                  );
                }
            }
          });
    });
  }

  void _popSelector(String value) {
    switch (value) {
      case 'salvar':
        break;
      case 'deletar':
        Message.alertDialog(context,
            title: 'Deseja excluir o estoque: ${widget.estoque.descricao}',
            subtitle: 'A exclusão apagara todos os dados do estoque',
            textokButton: "Ok",
            onPressOkbutton: () {
              Navigator.of(context).pop();
              _deletar(widget.estoque);
            },
            textNoButton: "Cancelar",
            onPressedNoButton: () {
              Navigator.of(context).pop();
            });
        break;
    }
  }

  void putProduct(Stock estoqueAlterar, quantidade) {
    estoqueAlterar.descricao = widget.estoque.descricao;
    estoqueAlterar.data_entrada =
        widget.estoque.data_entrada.replaceAll("Z", "0");
    estoqueAlterar.data_validade =
        widget.estoque.data_validade.replaceAll("Z", "0");
    estoqueAlterar.quantidade_total = quantidade;
    estoqueAlterar.tipo = widget.estoque.tipo;

    StockModel.of(context).alterarEstoque(
      estoqueAlterar,
      onSuccess: () {
        DateConvert.salvarBancodDadaos(
            'ATUALIZAÇÂO ESTOQUE ${widget.estoque.descricao}', 'Estoque');
        return;
      },
      onFail: (String message) {
        Message.onFail(
          scaffoldKey: _scarffoldKey,
          message: message,
        );
        return;
      },
    );
  }

  void _deletar(Stock estoque) {
    StockModel.of(context).deletarEstoque(
      estoque,
      onSuccess: (String message) {
        Message.onSuccess(
            scaffoldKey: _scarffoldKey,
            message: 'Removido com sucesso',
            seconds: 3,
            onPop: (value) {
              Navigator.of(context).pop();
            });
        DateConvert.salvarBancodDadaos(
            'REMOÇÂO ESTOQUE ${widget.estoque.descricao}', 'Estoque');
        return;
      },
      onFail: (String message) {
        Message.onFail(
          scaffoldKey: _scarffoldKey,
          message: message,
        );
        return;
      },
    );
  }

  void _deletarProduto(int id, int product) {
    ProductModel.of(context).deletarProduto(
      id,
      product,
      onSuccess: (String message) {
        DateConvert.salvarBancodDadaos(
            'REMOÇÂO PPRODUTO ${widget.estoque.descricao}', 'Produto');
        return;
      },
      onFail: (String message) {
        Message.onFail(
          scaffoldKey: _scarffoldKey,
          message: message,
        );
        return;
      },
    );
  }
}
