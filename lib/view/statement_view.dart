import 'package:flutter/material.dart';
import 'package:ma_poche/dbrequest/dbprovider.dart';
import 'package:ma_poche/helpers/account_statement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatementView extends StatefulWidget {
  @override
  _StatementViewState createState() => _StatementViewState();
}

class _StatementViewState extends State<StatementView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<AccountStatement>  _accountStatementList;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _getStatementList();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  _getStatementList() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int res = prefs.getInt('account_id');
    if(res > 0){
      final accountStatementList =  await DBProvider.db.getStatementByAccountId(res);
      setState(() {
        int accountId = res;
        _accountStatementList = accountStatementList;
      });
    }else{
      Navigator.pushNamed(context, '/signup');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:  AppBar(
          iconTheme: new IconThemeData(color: Colors.blue),
          backgroundColor: Colors.blue,
          title:Text(
            "Relevé",
            style: TextStyle(
                color: Colors.white,
                fontSize:  22,
                fontFamily: "Arial Rounded MT Bold",
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: _accountStatementList == null ?
        Center(
          child: Text(
            "En attente de données ",
            style: TextStyle(
                color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.w800),
          ),
        ): Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: _accountStatementList.length,
            itemBuilder: (context, index){
              return  Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2.0,
                          color: Colors.white
                      )
                    ]
                ),
                child: ExpansionTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: _accountStatementList[index].debit > 0 ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2.0,
                              color: Colors.white
                          )
                        ]
                    ),
                    child: Icon(
                      _accountStatementList[index].debit > 0 ? Icons.remove_circle_outline : Icons.add_circle_outline_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    _accountStatementList[index].debit > 0 ? "Dépense" : "Revenu" ,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(DateTime.fromMillisecondsSinceEpoch(_accountStatementList[index].dateOps).toIso8601String()),
                  children: [
                    Text(_accountStatementList[index].lib,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Crédit:",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(_accountStatementList[index].credit.toString())
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Débit:",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(_accountStatementList[index].debit.toString())
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Solde:",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(_accountStatementList[index].solde.toString())
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date de création:",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(DateTime.fromMillisecondsSinceEpoch(_accountStatementList[index].creationDateTime).toIso8601String())
                      ],
                    )
                    ,
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date de modification:",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(DateTime.fromMillisecondsSinceEpoch(_accountStatementList[index].updateDateTime).toIso8601String())
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )
    );
  }
}
