import 'package:app_flutter/ui/pages/historic_page.dart';
import 'package:app_flutter/ui/pages/home_page_tabarbiew.dart';
import 'package:app_flutter/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePageModel extends Model {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class HomePageEstok extends StatelessWidget {
  final model = HomePageModel();
  num status;
  HomePageEstok({status}) {
    if (status != null) {
      model._currentIndex = status;
    }
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomePageModel>(
      model: model,
      child: ScopedModelDescendant<HomePageModel>(
        builder: (BuildContext context, Widget child, HomePageModel model) {
          final List<Widget> _children = [
            HomepageTab(),
            HistoricPage(),
            ProfilePage()
          ];
          return Scaffold(
            body: _children[model.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: model.currentIndex,
                onTap: (index) => model.setIndex(index),
                selectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
                unselectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.playlist_add_check),
                    label: 'Historico',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Perfil',
                  )
                ]),
          );
        },
      ),
    );
  }
}
