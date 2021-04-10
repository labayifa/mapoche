import 'package:flutter/material.dart';
import 'package:ma_poche/view/account_balance_view.dart';
import 'package:ma_poche/view/money_action_view.dart';
import 'package:ma_poche/view/statement_view.dart';
import 'package:ma_poche/view/page_login.dart';
import 'package:ma_poche/view/page_sign_up.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

dynamic route = MaterialPageRoute(builder: (_) => PageLogin());

class RouteGenerator{

    static Route<dynamic> generateRoute(RouteSettings routeSettings){
      final args = routeSettings.arguments;
      switch(routeSettings.name){
        case '/':{
          return route;
        }
        break;
        case '/signup':{
          return MaterialPageRoute(builder: (_) =>  PageSignUp(),settings: routeSettings);
        }
        break;
        case '/signin':{
          return MaterialPageRoute(builder: (_) => PageLogin(),settings: routeSettings);
        }
        break;
        case '/main':{
          return MaterialPageRoute(builder: (_) => MyMainPage(),settings: routeSettings);
        }
        break;
        case '/main/addops':{
          return MaterialPageRoute(builder: (_) => MoneyActionView(),settings: routeSettings);
        }
        break;
        case '/main/history':{
          return MaterialPageRoute(builder: (_) => StatementView(),settings: routeSettings);
        }
        break;
        // case '/main/user/information':{
        //   return MaterialPageRoute(builder: (_) => PageUser(),settings: routeSettings);
        // }
        // break;
        case '/main/account':{
          return MaterialPageRoute(builder: (_) => AccountBalanceView(),settings: routeSettings);
        }
        break;
        // case '/main/about':{
        //   return MaterialPageRoute(builder: (_) =>  PageAbout(),settings: routeSettings);
        // }
        // break;
        // case '/reset/password' :{
        //   return MaterialPageRoute(builder: (_)=> PageResetPassword(),settings: routeSettings);
        // }
        // break;
//        case '':{
//
//        }
      }
    }
}