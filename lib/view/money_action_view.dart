import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyActionView extends StatefulWidget {
  @override
  _MoneyActionViewState createState() => _MoneyActionViewState();
}

class _MoneyActionViewState extends State<MoneyActionView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  TextEditingController _controlleAmount = TextEditingController();
  TextEditingController _controllerLib = TextEditingController();

  double _amount;
  String _lib;
  DateTime _dateTimeOperation;
  String _opType;

  String _startDateText = "Choisir une date";
  String _endDateText = "Choisir une date";

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  String _gender = "Revenu";

  @override
  void initState() {
     _startDateText = "Choisir une date";
     _endDateText = "Choisir une date";

     _startDate = DateTime.now();

     _gender = "Revenu";
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, allowFontScaling: false);
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_ScreenUtil',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, widget) {
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,
          );
        },
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            iconTheme: new IconThemeData(color: Colors.lightBlue),
            backgroundColor: Colors.white,
            title: Text(
              "Nouvelle Opération",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize:  20,
                  fontFamily: "Arial Rounded MT Bold",
                  fontWeight: FontWeight.bold
              ),
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
                //onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Relevé', 'Solde'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body:Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Text(
                        "Option",
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        color: Colors.white,
                        width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
                        height: ScreenUtil().setHeight(65),
                        child: AppDropdownInput(
                          hintText: "Option",
                          options: ["Revenu", "Dépense"],
                          value: _gender,
                          onChanged: (String value) {
                            print(value);
                            setState(() {
                              _gender = value;
                            });
                          },
                          getLabel: (String value) => value,
                        ),
                      ),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Text(
                        "Libellé",
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        color: Colors.white,
                        width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
                        height: ScreenUtil().setHeight(100),
                        child: TextFormField(
                          enabled: true,
                          textAlign: TextAlign.justify,
                          controller: _controllerLib,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: const BorderSide(
                                    color: Colors.black
                                ),
                                //borderSide: const BorderSide(),
                              ),

                              hintStyle: TextStyle(color: Colors.white,fontFamily: "Lato",
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: ''),
                        ),
                      ),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Montant",
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        color: Colors.white,
                        width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
                        height: ScreenUtil().setHeight(50),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          enabled: true,
                          textAlign: TextAlign.justify,
                          controller: _controlleAmount,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: const BorderSide(
                                    color: Colors.black
                                ),
                                //borderSide: const BorderSide(),
                              ),

                              hintStyle: TextStyle(color: Colors.white,fontFamily: "Lato",
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: ''),
                        ),
                      ),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Text(
                        "Date",
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        color: Colors.white,
                        width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
                        height: ScreenUtil().setHeight(50),
                        child:  InkWell(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.blue,
                                ),
                                Text(
                                  _startDateText,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                            onTap: (){
                              final result =showDatePicker(
                                  context: context,
                                  initialDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day -1),
                                  firstDate: DateTime(DateTime.now().year -10, 6, 7),
                                  lastDate: DateTime(DateTime.now().year +1, DateTime.now().month, DateTime.now().day)
                              );
                              result.then((value){
                                print(value);
                                if(value == null || value.compareTo(_endDate) > 0){
                                  setState(() {
                                    _startDate = DateTime.now();
                                    _endDateText = "Choisir une date";
                                  });
                                }else{
                                  setState(() {
                                    _startDate = value;
                                    _startDateText =  _startDate.toString();
                                  });
                                }
                              });
                            }
                        ),
                      ),
                      SizedBox(height: 25,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35.0,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2.0,
                                    color: Colors.white
                                )
                              ],
                            ),
                            child: Center(
                              child: InkWell(
                                child:  Text(
                                  "Enregistrer",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                                onTap: (){
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => RechargeWalletViewPage()),
                                  // );
                                  print("Helo");
                                  print([_gender, _controlleAmount.text, _controllerLib.text, _startDate]);
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ) ,
          ),
        ),
      ),
    );
  }
}


class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T) onChanged;

  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration:InputDecoration(
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: const BorderSide(
                    color: Colors.black
                ),
                //borderSide: const BorderSide(),
              ),

              hintStyle: TextStyle(color: Colors.white,fontFamily: "Lato",
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: ''),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}