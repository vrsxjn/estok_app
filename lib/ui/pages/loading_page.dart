import 'package:app_flutter/entities/user.dart';
import 'package:app_flutter/models/user_model.dart';
import 'package:app_flutter/repository/local/user_repository.dart';
import 'package:app_flutter/ui/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenStatePage();
}

class _SplashScreenStatePage extends State<SplashScreenPage> {
  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    User user = await UserRepository.instance.getUser();
    if (user != null) {
      UserModel.of(context).user = user;
      print('Name: ${UserModel.of(context).user.name}');
      print('Email: ${UserModel.of(context).user.email}');
      Future.delayed(Duration(seconds: 3)).then((_) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePageEstok();
        }));
      });
    } else {
      Future.delayed(Duration(seconds: 3)).then((_) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
      });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ESTOK APP',
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Montserrat',
                    color: Colors.white)),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
