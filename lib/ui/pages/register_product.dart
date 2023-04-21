import 'dart:io';

import 'package:app_flutter/components/custom_text_from_field.dart';
import 'package:app_flutter/components/custom_text_ui.dart';
import 'package:app_flutter/entities/product_entities.dart';
import 'package:app_flutter/models/product_model.dart';
import 'package:app_flutter/ui/validator/product_validator.dart';
import 'package:app_flutter/ui/widgets/loading_button.dart';
import 'package:app_flutter/ui/widgets/message.dart';
import 'package:app_flutter/util/database_save.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterProduct extends StatefulWidget {
  Product produto;
  final num id;
  RegisterProduct(this.id, {this.produto});

  @override
  State<RegisterProduct> createState() => _RegisterProductState();
}

class _RegisterProductState extends State<RegisterProduct>
    with ProductValidator {
  final FocusNode _focusnomeDescricao = FocusNode();
  final FocusNode _focusdescicaovaloritem = FocusNode();
  final FocusNode _focusvaloitemvalorunitario = FocusNode();
  final FocusNode _focusNodequantidade = FocusNode();
  final FocusNode _focusNodesite = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  var valoritemController = TextEditingController();
  var valorunitarioController = TextEditingController();
  var quantidadeController = TextEditingController();
  final siteController = TextEditingController();
  final _scarffoldKey = GlobalKey<ScaffoldState>();

  bool ehSalvar = true;
  String err;

  void initState() {
    super.initState();
    _carregarCampos();
  }

  void _carregarCampos() {
    if (widget.produto != null) {
      ehSalvar = false;
      nomeController.text = widget.produto.nome;
      descricaoController.text = widget.produto.descricao;
      valoritemController..text = widget.produto.valor_item.toString();
      valorunitarioController.text = widget.produto.valor_unitario.toString();
      quantidadeController.text = widget.produto.quantidade.toString();
      siteController.text = widget.produto.site;
    } else {}
    ProductModel.of(context).file = null;
    ProductModel.of(context).setState();
  }

  ImageProvider getImage(ProductModel estoqueModel) {
    if (!ehSalvar && widget.produto.image != null) {
      if (estoqueModel.file != null) {
        return FileImage(estoqueModel.file);
      } else {
        return NetworkImage(widget.produto.image);
      }
    } else if (estoqueModel.file != null) {
      return FileImage(estoqueModel.file);
    } else {
      return AssetImage("assets/icons/ic_camera.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scarffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF58355E)),
        backgroundColor: Color(0xFFF7F2F8),
        centerTitle: true,
        title: Column(children: [
          Text(
            'NOVO',
            style:
                TextStyle(color: Color(0xFF58355E), fontFamily: 'Montserrat'),
          ),
          Text(
            'PRODUTO',
            style:
                TextStyle(color: Color(0xFF58355E), fontFamily: 'Montserrat'),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScopedModelDescendant<ProductModel>(
                        builder: (context, snapshot, estoqueModel) {
                          return SizedBox(
                            child: InkWell(
                              onTap: () {
                                _onTapImageSheet(estoqueModel, context);
                              },
                              child: Container(
                                width: 170,
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: getImage(estoqueModel),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      CustomTextUi(
                        labelText: 'Clique na imagem para tirar uma foto',
                        color: Colors.grey,
                        fonte: 'Montserrat',
                        textAlign: TextAlign.center,
                        fonteSize: 16,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextUi(
                          labelText: 'Nome',
                          fonte: 'Montserrat',
                          fonteSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "Heineken original",
                        controller: nomeController,
                        requestFocus: _focusnomeDescricao,
                        keyboardType: TextInputType.emailAddress,
                        validator: validatorName,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextUi(
                          labelText: 'Descrição',
                          fonte: 'Montserrat',
                          fonteSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        maxlines: 4,
                        hintText: "- Uma das melhores marcas em uma\ncasa só",
                        controller: descricaoController,
                        requestFocus: _focusdescicaovaloritem,
                        focusNode: _focusnomeDescricao,
                        keyboardType: TextInputType.multiline,
                        validator: validatorDescricao,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextUi(
                          labelText: 'Valor item',
                          fonte: 'Montserrat',
                          fonteSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "R\$ 45,00",
                        controller: valoritemController,
                        requestFocus: _focusvaloitemvalorunitario,
                        focusNode: _focusdescicaovaloritem,
                        keyboardType: TextInputType.number,
                        validator: validatorValorItem,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextUi(
                          labelText: 'Valor unitário',
                          fonte: 'Montserrat',
                          fonteSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "R\$ 7,00",
                        controller: valorunitarioController,
                        requestFocus: _focusNodequantidade,
                        focusNode: _focusvaloitemvalorunitario,
                        keyboardType: TextInputType.number,
                        validator: validatorUnitItem,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextUi(
                          labelText: 'Quantidade',
                          fonte: 'Montserrat',
                          fonteSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "10",
                        controller: quantidadeController,
                        focusNode: _focusNodequantidade,
                        requestFocus: _focusNodesite,
                        keyboardType: TextInputType.number,
                        validator: validatorQuantity,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextUi(
                          labelText: 'Site',
                          fonte: 'Montserrat',
                          fonteSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: "Informe a url",
                        controller: siteController,
                        focusNode: _focusNodesite,
                        keyboardType: TextInputType.emailAddress,
                        validator: validatorSit,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ScopedModelDescendant<ProductModel>(
                        builder: (BuildContext context, Widget child,
                            ProductModel productModel) {
                          return LoadingButton(
                            onPressed: () {
                              _novoProductRegister(context);
                            },
                            title: ehSalvar ? "CADASTRAR" : "ALTERAR",
                            fonteSize: 17,
                            colorButton: Color(0xFFF7F2F8),
                            colorCircularProgess: Colors.black,
                            isLoading: productModel.productStatus ==
                                ProductChangeStatus.LOADING,
                          );
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ])),
          ),
        ),
      ),
    );
  }

  void _novoProductRegister(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!this._formKey.currentState.validate()) {
      return;
    }

    if (ProductModel.of(context).file != null ||
        (widget.produto != null && widget.produto.image != null)) {
      if (ehSalvar) {
        widget.produto = Product();
      }
      widget.produto.nome = nomeController.text;
      widget.produto.descricao = descricaoController.text;
      widget.produto.valor_item =
          double.parse(valoritemController.text.replaceAll(",", "."));
      widget.produto.valor_unitario =
          double.parse(valorunitarioController.text.replaceAll(",", "."));
      widget.produto.quantidade = int.parse(quantidadeController.text);
      widget.produto.site = siteController.text;
      if (ehSalvar) {
        ProductModel.of(context).adicionarProduto(widget.id, widget.produto,
            onSuccess: () {
          Navigator.of(context).pop();

          DateConvert.salvarBancodDadaos(
              'INSERÇÂO PRODUTO ${widget.produto.nome}', 'Produto');
        }, onFail: (String message) {
          Navigator.of(context).pop();
          Message.onFail(
            scaffoldKey: _scarffoldKey,
            message: message,
          );
        });
      } else {
        ProductModel.of(context).updateProduct(widget.id, widget.produto,
            onSuccess: () {
          Navigator.of(context).pop();

          DateConvert.salvarBancodDadaos(
              'INSERÇÂO PRODUTO ${widget.produto.nome}', 'Produto');
        }, onFail: (String message) {
          Navigator.of(context).pop();
          Message.onFail(
            scaffoldKey: _scarffoldKey,
            message: message,
          );
        });
      }
    } else {
      print('teste');
      _scarffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Por favor, selecione uma imagem'),
        ),
      );
    }
  }

  void _onTapImageSheet(ProductModel estoqueModel, BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!this._formKey.currentState.validate()) {
      return;
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                onPressed: () async {
                  var picker = ImagePicker();

                  var pickedFile = await picker.getImage(
                      source: ImageSource.camera, imageQuality: 60);

                  if (pickedFile != null) {
                    estoqueModel.file = File(pickedFile.path);
                  } else {
                    estoqueModel.file = null;
                  }
                  estoqueModel.setState();
                  Navigator.of(context).pop();
                },
                child: Text('Camera'),
              ),
              FlatButton(
                onPressed: () async {
                  var picker = ImagePicker();

                  var pickedFile = await picker.getImage(
                      source: ImageSource.gallery, imageQuality: 60);

                  if (pickedFile != null) {
                    estoqueModel.file = File(pickedFile.path);
                  } else {
                    estoqueModel.file = null;
                  }
                  estoqueModel.setState();
                  Navigator.of(context).pop();
                },
                child: Text('Galeria'),
              )
            ],
          );
        });
  }
}
