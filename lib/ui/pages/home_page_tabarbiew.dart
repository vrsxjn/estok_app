import 'package:app_flutter/models/stock_model.dart';
import 'package:app_flutter/ui/pages/register_stock.dart';
import 'package:app_flutter/ui/tabs/home_tab.dart';
import 'package:app_flutter/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomepageTab extends StatefulWidget {
  @override
  State<HomepageTab> createState() => _HomepageTabState();
}

class _HomepageTabState extends State<HomepageTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _scarffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _reload();
  }

  void _reload() {
    StockModel.of(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0), // here the desired height
        child: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF58355E)),
          backgroundColor: Color(0xFFF7F2F8),
          centerTitle: true,
          title: Text(
            'ESTOK APP',
            style:
                TextStyle(color: Color(0xFF58355E), fontFamily: 'Montserrat'),
          ),
          bottom: TabBar(
            controller: _tabController,
            unselectedLabelStyle: TextStyle(
              fontSize: 10.0,
              fontFamily: 'Montserrat',
            ),
            isScrollable: true,
            indicatorWeight: 5,
            indicatorColor: Color(0xFF58355E),
            labelColor: Color(0xFF58355E),
            tabs: [
              Tab(
                text: ("TODOS"),
              ),
              Tab(
                text: ("EM ESTOQUE"),
              ),
              Tab(
                text: ("EM AVISO"),
              ),
              Tab(
                text: ("EM FALTA"),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeTab("TODOS"),
          HomeTab("EM ESTOQUE"),
          HomeTab("EM AVISO"),
          HomeTab("EM FALTA")
        ],
      ),
      drawer: DrawerExport(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return RegisterStock();
          })).then((value) async {
            _reload();
          });
          ;
        },
        backgroundColor: Color(0xFF58355E),
        child: Icon(Icons.add),
      ),
    );
  }
}
