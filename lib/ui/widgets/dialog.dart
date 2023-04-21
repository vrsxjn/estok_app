import 'package:app_flutter/entities/product_entities.dart';
import 'package:app_flutter/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DialogModel extends Model {
  int _currentValue = 0;

  int get currentValue => _currentValue;

  void increment() {
    _currentValue++;
    notifyListeners();
  }

  void decrement() {
    _currentValue--;
    notifyListeners();
  }
}

class Dialogg extends StatelessWidget {
  final Product stockSave;

  Dialogg({this.stockSave});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void valorProduct(
    BuildContext context, {
    String title = "",
    int subtitle,
    String textokButton = "Alterar",
    @required Function onPressOkbutton,
    String textNoButton = "Cancelar",
    Function onPressedNoButton,
    @required Function addPressedButton,
    Function removePressedButton,
    Product stockSave,
    num id,
  }) {
    final model = DialogModel();
    model._currentValue = subtitle;
    showDialog(
        context: context,
        builder: (context) {
          return ScopedModel<DialogModel>(
            model: model,
            child: AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              titleTextStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF58355E),
              ),
              content: ScopedModelDescendant<DialogModel>(
                builder: (context, child, model) {
                  return SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          color: Color(0xFF58355E),
                          icon: Icon(
                            Icons.remove,
                          ),
                          onPressed: () {
                            if (model.currentValue <= 0) {
                            } else {
                              model.decrement();
                              if (removePressedButton != null) {
                                removePressedButton(model.currentValue);
                              }
                            }
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          '${model.currentValue}',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        IconButton(
                          color: Color(0xFF58355E),
                          icon: Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            model.increment();
                            if (addPressedButton != null) {
                              addPressedButton(model.currentValue);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              actions: [
                onPressedNoButton == null
                    ? Container()
                    : FlatButton(
                        onPressed: onPressedNoButton,
                        child: Text(
                          textNoButton,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF58355E),
                          ),
                        )),
                FlatButton(
                  onPressed: () async {
                    stockSave.quantidade = model.currentValue;

                    ProductModel.of(context).updateProduct(id, stockSave,
                        onSuccess: () async {
                      await onPressOkbutton();
                    }, onFail: (String message) {});
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    textokButton,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF58355E),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
