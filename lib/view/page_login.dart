import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ma_poche/service/userservice.dart';
import 'package:ma_poche/widget/widget_button_standard.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

ProgressDialog pr;

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _password = "";
  String _username = "";

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _setDataScreen();
    super.initState();
  }

  _setDataScreen() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey('username') && prefs.containsKey('password')){
      setState(() {
        usernameController = new TextEditingController(text: prefs.getString('username'));
        passwordController = new TextEditingController(text: prefs.getString('password'));
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _gotoConnexionPage(){
    print("Connexion  Button Pressed");
  }

  @override
  Widget build(BuildContext context) {

    void _goto_main_page(){
      Navigator.pushNamed(context, '/main');
    }

    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);

    pr.style(message: 'Connexion...');

    //Optional
    pr.style(
      message: 'Veuillez patienter...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
    );

    Future<Void> _connectUser() async {
      print("Connexion de l'utilisateur");
      _username = usernameController.value.text;
      _password = passwordController.value.text;

      print(["Hello",_username, _password]);

      if(_password.length < 8){
        pr.hide();
        Toast.show("Le Mot doit avoir au moins 8 caractères avec un caractère spécial", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.white, textColor: Colors.red);
        return null;
      }

      if(_username.length < 3){
        pr.hide();
        Toast.show("Nom d'utilisateur trop petit ou incorrect", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.white, textColor: Colors.red);
        return null;
      }

      // Lancer la connexion avec une méthode async et un loader
      //_auth2data = new OAuth2Data(+username, password);

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final dataSet = await UserService().login(_username, _password);

      await pr.hide();
      print(dataSet);
      if(dataSet){
        pr.hide();
        prefs.setString('username',_username);
        prefs.reload();
        prefs.setString('password', _password);
        prefs.reload();
        _goto_main_page();
        print("Test Gooooooooooooooooooooooooooo");
      }else{
        pr.hide();
        Toast.show("Impossible de se connecter.  Informations erronées ou serveur indisponible", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.white, textColor: Colors.red);
      }

    }

    return  MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
        home: Scaffold (
          body:  SizedBox.expand(
            child:ListView(
              children: <Widget>[
                PageHeader(),
                PageMidlleContent(onPressed: _gotoConnexionPage, singnIn: _connectUser, passwordController: passwordController, phoneController: usernameController),
                Container(
                  padding: EdgeInsets.all(
                      15
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height:  5,
                      ),
                      Container(
                        child: InkWell(
                          child: Text(
                              "S'inscrire",
                              style: TextStyle(
                                  color:  Colors.red,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.normal
                              )
                          ),
                          onTap: (){
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ),
                      SizedBox(
                        height:  10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}



class PageHeader extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(
          40
      ),
      child: Column(
        //mainAxisSize: MainAxisSize.,
        children: <Widget>[
          SizedBox(
            height:  20,
          ),
          Text(
            "Créer un compte",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold
            ),

          ),
          SizedBox(
            height:  50,
          ),
          Text(
              "Veuillez vous connecter",
              style: TextStyle(
                  color:  Color(0xff000000),
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.normal
              )
          )
        ],
      ),
    );
  }
}

class PageMidlleContent extends StatelessWidget{

  final GestureTapCallback onPressed;
  final GestureTapCallback singnIn;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  const PageMidlleContent({Key key,@required this.onPressed, this.singnIn, this.phoneController, this.passwordController, this.passwordConfirmController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
        child:Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    maxLength: 20,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    decoration: const InputDecoration(
                      //icon: Icon(Icons.phone),
                        hintText: "Nom d'utilisateur",
                        labelText: 'Username *',
                        fillColor: Colors.black,
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        )
                    ),
                    controller: phoneController,
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return value.contains('@') ? 'Do not use the @ char.' : null;
                    },
                  ),
                )
              ],
            ),
            Container(
              width: 300,
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                autovalidate: true,
                decoration:  InputDecoration(
                    hintText: 'Mot de passe',
                    labelText: 'Mot de passe *',
                    fillColor: Colors.black,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    )
                ),
                controller: passwordController,
                //validator: passwordValidator,
              ),
            ),
            SizedBox(
              height:  40,
            ),
            WidgetButtonStandard(
                onPressed: (){
                  pr.show();
                  singnIn();
                },
                buttonName: "Continuer",
                key: new Key("buttonContinuSignupTel")
            ),
            SizedBox(
              height:  20,
            ),
          ],
        )
    );
  }
}
