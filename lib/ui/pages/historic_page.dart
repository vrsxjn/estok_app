import 'package:app_flutter/ui/tabs/historic_tab.dart';
import 'package:app_flutter/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HistoricPage extends StatefulWidget {
  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF58355E)),
          backgroundColor: Color(0xFFF7F2F8),
          centerTitle: true,
          title: Text(
            'HISTORICO',
            style:
                TextStyle(color: Color(0xFF58355E), fontFamily: 'Montserrat'),
          )),
      body: HistoricTab(),
      drawer: DrawerExport(),
    );
  }
}
