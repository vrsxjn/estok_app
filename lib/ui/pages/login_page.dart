import 'package:app_flutter/app/components/custom_text_from_field.dart';
import 'package:app_flutter/app/components/custom_text_ui.dart';
import 'package:app_flutter/app/ui/validator/login_validator.dart';
import 'package:app_flutter/app/ui/widgets/loading_button.dart';
import 'package:app_flutter/app/ui/widgets/message.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/user_model.dart';
import 'package:app_flutter/app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPageModel extends Model {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}

class LoginPage extends StatelessWidget with LoginValidator {
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _focusSenha = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoginPageModel>(
      model: LoginPageModel(),
      child: ScopedModelDescendant<LoginPageModel>(
          builder: (context, child, model) {
        return Scaffold(
          key: _scaffoldKey,
          body: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextUi(
                          labelText: 'ESTOK APP',
                          fonte: 'Montserrat',
                          fonteSize: 24,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextUi(
                          labelText: 'Login',
                          fonte: 'Montserrat',
                          fonteSize: 20,
                          color: Color(0xFF495057),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        CustomTextFormField(
                          labelText: "Email",
                          hintText: "example@gmail.com",
                          controller: _loginController,
                          keyboardType: TextInputType.emailAddress,
                          requestFocus: _focusSenha,
                          iconz: Icon(Icons.person, size: 25.0),
                          validator: validateLogin,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          labelText: "Senha",
                          hintText: "informe a senha",
                          controller: _senhaController,
                          keyboardType: TextInputType.visiblePassword,
                          focusNode: _focusSenha,
                          obscureText: model.obscureText,
                          iconz: Icon(Icons.lock, size: 25.0),
                          validator: validateSenha,
                          suffixIconz: GestureDetector(
                            onTap: () {
                              model.toggleObscureText();
                            },
                            child: Icon(
                              model.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF58355E),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ScopedModelDescendant<UserModel>(
                          builder: (BuildContext context, Widget child,
                              UserModel userModel) {
                            return LoadingButton(
                              onPressed: () {
                                _loginOnPressed(context, userModel);
                              },
                              title: 'ENTRAR',
                              fonteSize: 17,
                              colorButton: Color(0xFFF7F2F8),
                              colorCircularProgess: Colors.black,
                              isLoading: userModel.userStatus ==
                                  UserChangeStatus.LOADING,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _loginOnPressed(BuildContext context, UserModel userModel) {
    FocusScope.of(context).unfocus();
    if (!this._formKey.currentState.validate()) {
      return;
    }
    _loginController.text = _loginController.text.replaceAll(" ", "");
    userModel.login(_loginController.text, _senhaController.text,
        onSuccess: () {
      Message.onSuccess(
          scaffoldKey: _scaffoldKey,
          message: "Usuário logado com sucesso",
          seconds: 4,
          onPop: (value) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return HomePageEstok();
            }));
          });
      return;
    }, onFail: (String message) {
      Message.onFail(
        scaffoldKey: _scaffoldKey,
        message: message,
        seconds: 4,
      );
      return;
    });
  }
}
