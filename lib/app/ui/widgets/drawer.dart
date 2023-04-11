import 'package:app_flutter/app/components/custom_button.dart';
import 'package:app_flutter/app/models/user_model.dart';
import 'package:app_flutter/app/ui/pages/home_page.dart';
import 'package:app_flutter/app/ui/pages/login_page.dart';
import 'package:app_flutter/app/ui/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerExport extends StatefulWidget {
  @override
  State<DrawerExport> createState() => _DrawerExportState();
}

class _DrawerExportState extends State<DrawerExport> {
  final _scarffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ScopedModelDescendant<UserModel>(
            builder: (BuildContext context, Widget child, UserModel userModel) {
              if (userModel.user != null) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/icons/account_circle.jpg"),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/banner.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.transparent.withOpacity(0.4),
                        BlendMode.colorBurn,
                      ),
                    ),
                  ),
                  accountName: Text(userModel.user.name),
                  accountEmail: Text(userModel.user.email),
                );
              } else {
                return DrawerHeader(
                  child: Text('User not found'),
                );
              }
            },
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(
              'Meu Perfil',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return HomePageEstok(
                    status: 2,
                  );
                }),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text(
              'Estoques',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return HomePageEstok(
                    status: 0,
                  );
                }),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.playlist_add_check),
            title: Text(
              'Histórico',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return HomePageEstok(
                    status: 1,
                  );
                }),
              );
            },
          ),
          SizedBox(
            height: 90,
          ),
          Center(
            child: ScopedModelDescendant<UserModel>(
              builder:
                  (BuildContext context, Widget child, UserModel userModel) {
                return LoadingButton(
                  height: 45,
                  width: 100,
                  borderRadius: 7,
                  colorCircularProgess: Colors.white,
                  colorTextButton: Colors.white,
                  onPressed: () {
                    UserModel.of(context).logout(onSuccess: () {
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  LoginPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero));
                    });
                  },
                  title: 'Sair',
                  fonteSize: 17,
                  colorButton: Color(0xFF58355E),
                  isLoading: userModel.userStatus == UserChangeStatus.LOADING,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
