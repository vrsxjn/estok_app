import 'package:app_flutter/app/components/custom_button.dart';
import 'package:app_flutter/app/components/custom_text_ui.dart';
import 'package:app_flutter/app/models/user_model.dart';
import 'package:app_flutter/app/ui/pages/login_page.dart';
import 'package:app_flutter/app/ui/widgets/drawer.dart';
import 'package:app_flutter/app/ui/widgets/loading_button.dart';
import 'package:app_flutter/app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scarffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scarffoldKey,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF58355E)),
          backgroundColor: Color(0xFFF7F2F8),
          centerTitle: true,
          title: Text(
            'MEU PERFIL',
            style:
                TextStyle(color: Color(0xFF58355E), fontFamily: 'Montserrat'),
          )),
      body: ListView(
        children: [
          ScopedModelDescendant<UserModel>(builder:
              (BuildContext context, Widget child, UserModel userModel) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        AssetImage('assets/icons/account_circle.jpg'),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  CustomTextUi(
                    labelText: '${userModel.user.name}',
                    fonte: 'Montserrat',
                    fonteSize: 17,
                    color: Color(0xFF58355E),
                  ),
                  CustomTextUi(
                    labelText: '${userModel.user.email}',
                    fonte: 'Montserrat',
                    fonteSize: 13,
                    color: Color(0xFF555353),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.phone, color: Color(0xFF58355E), size: 20),
                      SizedBox(width: 10),
                      CustomTextUi(
                        labelText: '${userModel.user.telefone}',
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(
                        Icons.email,
                        color: Color(0xFF58355E),
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      CustomTextUi(
                        labelText: '${userModel.user.email}',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ScopedModelDescendant<UserModel>(
                    builder: (BuildContext context, Widget child,
                        UserModel userModel) {
                      return LoadingButton(
                        height: 45,
                        width: 100,
                        borderRadius: 7,
                        colorCircularProgess: Colors.white,
                        colorTextButton: Colors.white,
                        onPressed: () {
                          UserModel.of(context).logout(onSuccess: () {
                            Message.onSuccess(
                                scaffoldKey: _scarffoldKey,
                                message: 'Usuario deslogado com sucesso',
                                onPop: (value) {
                                  Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              LoginPage(),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration:
                                              Duration.zero));
                                });
                          });
                        },
                        title: 'Sair',
                        fonteSize: 17,
                        colorButton: Color(0xFF58355E),
                        isLoading:
                            userModel.userStatus == UserChangeStatus.LOADING,
                      );
                    },
                  ),
                ]),
              ),
            );
          })
        ],
      ),
      drawer: DrawerExport(),
    );
  }
}
