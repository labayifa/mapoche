import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ma_poche/route/RouteGenerator.dart';
import 'package:ma_poche/view/my_home_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

String routeStartLink;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if(prefs.containsKey('username') && prefs.containsKey('password')){
    route = MaterialPageRoute(builder: (_) => MyMainPage());
    routeStartLink = '/signin';
  }else{
    routeStartLink = '/signin';
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  String name = "main";
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  bool _enabled = true;
  int _status = 0;
  List<String> _events = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      route = MaterialPageRoute(builder: (_) => MyMainPage());
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

      statusBarColor: Colors.blue,

    ));


    return MaterialApp(
      title: 'Ma Poche',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFF2E7D32),
          secondaryHeaderColor: Color(0xFF2E7D32)
      ),
      initialRoute: routeStartLink,
//      isReady ? routeStartLink :
      onGenerateRoute: RouteGenerator.generateRoute,
//        MyHomePage(title: 'Flutter Demo Home Page')
    );
  }
}


class MyMainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xffFFFFFF)),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: Scaffold (
            body: MyHomePage(),
        )
    );
  }
}


// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//         // This makes the visual density adapt to the platform that you run
//         // the app on. For desktop platforms, the controls will be smaller and
//         // closer together (more dense) than on mobile platforms.
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
