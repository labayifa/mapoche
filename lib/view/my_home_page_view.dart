import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:ma_poche/constants/values/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ma_poche/view/account_balance_view.dart';

import 'dart:convert';

import 'package:ma_poche/view/home_page.dart';
import 'package:ma_poche/view/money_action_view.dart';
import 'package:ma_poche/view/statement_view.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  final StreamController<int> _streamController = StreamController<int>();


  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MoneyActionView(),
    AccountBalanceView(),
    StatementView()
  ];

  @override
  void initState() {
  }


  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        stream: _streamController.stream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
          return Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(snapshot.data),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
              ]),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                      gap: 8,
                      activeColor: Colors.white,
                      iconSize: 24,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      duration: Duration(milliseconds: 800),
                      tabBackgroundColor: Colors.red,
                      tabs: [
                        GButton(
                          icon: LineIcons.home,
                          text: 'Accueil',
                        ),
                        GButton(
                          icon: LineIcons.editAlt,
                          text: 'Opération',
                        ),
                        GButton(
                          icon: LineIcons.moneyBill,
                          text: 'Ma Poche',
                        ),
                        GButton(
                          icon: LineIcons.history,
                          text: 'Historique',
                        ),
                      ],
                      selectedIndex: snapshot.data,
                      onTabChange: (index) {
                        _streamController.sink.add(index);
                      }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
