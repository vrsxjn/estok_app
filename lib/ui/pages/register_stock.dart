import 'package:app_flutter/components/custom_text_from_field.dart';
import 'package:app_flutter/components/custom_text_ui.dart';
import 'package:app_flutter/entities/stock_entities.dart';
import 'package:app_flutter/models/stock_model.dart';
import 'package:app_flutter/ui/validator/stock_validator.dart';
import 'package:app_flutter/ui/widgets/loading_button.dart';
import 'package:app_flutter/ui/widgets/message.dart';
import 'package:app_flutter/util/database_save.dart';
import 'package:app_flutter/util/date_convertion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterStock extends StatefulWidget {
  Stock estoque;

  RegisterStock({this.estoque});

  @override
  _RegisterStockState createState() => _RegisterStockState();
}

class _RegisterStockState extends State<RegisterStock> with EstoqueValidator {
  final dateControllerEnter = TextEditingController();
  final dateControllerVality = TextEditingController();
  final FocusNode _registerFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final _scarffoldKey = GlobalKey<ScaffoldState>();

  final descricaoNovoEstoque = TextEditingController();
  String _selectedOption = "CAIXA";
  final List<String> dropDownItems = <String>['CAIXA', 'PACOTE', 'GRADE'];

  bool ehSalvar = true;

  @override
  void initState() {
    super.initState();
    _carregarCampos();
  }

  void _carregarCampos() {
    if (widget.estoque != null) {
      ehSalvar = false;
      descricaoNovoEstoque.text = widget.estoque.descricao;
      _selectedOption = widget.estoque.tipo;
      dateControllerEnter.text =
          ControllersFunction.formataData(widget.estoque.data_entrada);
      dateControllerVality.text =
          ControllersFunction.formataData(widget.estoque.data_validade);
    } else {
      _selectedOption = "CAIXA";
    }
  }

  @override
  void dispose() {
    dateControllerEnter.dispose();
    dateControllerVality.dispose();
    super.dispose();
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
            style: TextStyle(
              color: Color(0xFF58355E),
              fontFamily: 'Montserrat',
            ),
          ),
          Text(
            'ESTOQUE',
            style: TextStyle(
              color: Color(0xFF58355E),
              fontFamily: 'Montserrat',
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextUi(
                  labelText: 'Descrição',
                  fonte: 'Montserrat',
                  fonteSize: 16,
                ),
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: "Descrição do estoque",
                controller: descricaoNovoEstoque,
                validator: validatorDescricao,
                requestFocus: _registerFocus,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      CustomTextUi(
                        labelText: 'Data de entrada',
                        fonte: 'Montserrat',
                        fonteSize: 16,
                      ),
                      SizedBox(
                        width: 55,
                      ),
                      CustomTextUi(
                        labelText: 'Data de validade',
                        fonte: 'Montserrat',
                        fonteSize: 16,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      readOnlyy: true,
                      focusNode: _registerFocus,
                      controller: dateControllerEnter,
                      fonteSize: 12,
                      fonte: 'Montserrat',
                      hintText: '12/12/2012',
                      ontap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2040));
                        var formatoDataBr =
                            DateFormat('dd/MM/yyyy').format(date);

                        if (date != null) {
                          dateControllerEnter.text = "${formatoDataBr}";
                        }
                      },
                      validator: validatorData,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: CustomTextFormField(
                      readOnlyy: true,
                      controller: dateControllerVality,
                      fonteSize: 12,
                      validator: validatorData,
                      fonte: 'Montserrat',
                      hintText: '12/12/2012',
                      ontap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2040));

                        var formatoDataBr =
                            DateFormat('dd/MM/yyyy').format(date);
                        if (date != null) {
                          dateControllerVality.text = "${formatoDataBr}";
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextUi(
                  labelText: 'Tipo',
                  fonte: 'Montserrat',
                  fonteSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 55,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Color(0xff58355E),
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xff58355E),
                      ),
                    ),
                  ),
                  value: _selectedOption,
                  icon: Icon(Icons.expand_more),
                  items:
                      dropDownItems.map<DropdownMenuItem<String>>((String e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Center(
                        child: Text(
                          e,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff58355E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    _selectedOption = newValue;
                  },
                ),
              ),
              SizedBox(
                height: 45,
              ),
              ScopedModelDescendant<StockModel>(
                builder: (BuildContext context, Widget child,
                    StockModel stockModel) {
                  return LoadingButton(
                    onPressed: () {
                      _novoEstoqueRegister(context);
                    },
                    title: ehSalvar ? "ADCIONAR" : "ALTERAR",
                    fonteSize: 17,
                    colorButton: Color(0xFFF7F2F8),
                    colorCircularProgess: Colors.black,
                    isLoading:
                        stockModel.stockStatus == StockChangeStatus.LOADING,
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _novoEstoqueRegister(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!this._formKey.currentState.validate()) {
      return;
    }

    if (ehSalvar) {
      widget.estoque = Stock();
    }

    widget.estoque.descricao = descricaoNovoEstoque.text;
    widget.estoque.quantidade_total = 0;
    widget.estoque.data_entrada =
        ControllersFunction.desvormataData(dateControllerEnter.text);
    widget.estoque.data_validade =
        ControllersFunction.desvormataData(dateControllerVality.text);
    widget.estoque.tipo = _selectedOption;
    if (ehSalvar) {
      StockModel.of(context).adcionarEstoque(widget.estoque, onSuccess: () {
        Message.onSuccess(
            scaffoldKey: _scarffoldKey,
            message: 'Estoque criado com sucesso',
            seconds: 3,
            onPop: (value) {
              Navigator.of(context).pop();
            });
        DateConvert.salvarBancodDadaos(
            'INSERÇÂO ESTOQUE ${widget.estoque.descricao}', 'Estoque');
      }, onFail: (String message) {
        Message.onFail(
          scaffoldKey: _scarffoldKey,
          message: message,
        );
      });
    } else {
      StockModel.of(context).alterarEstoque(widget.estoque, onSuccess: () {
        Message.onSuccess(
            scaffoldKey: _scarffoldKey,
            message: 'Estoque atualizado com sucesso',
            seconds: 3,
            onPop: (value) {
              Navigator.of(context).pop();
            });
        DateConvert.salvarBancodDadaos(
            'ATUALIZAÇÂO ESTOQUE ${widget.estoque.descricao}', 'Estoque');
      }, onFail: (String message) {
        Message.onFail(
          scaffoldKey: _scarffoldKey,
          message: message,
        );
      });
    }
  }
}
