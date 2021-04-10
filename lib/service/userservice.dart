

import 'package:ma_poche/dbrequest/dbprovider.dart';
import 'package:ma_poche/dbrequest/dbquery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{
  Future<bool>  createUser(username, password) async{

    // Lancer la connexion avec une méthode async et un loader
    print([username, password, "Connect Test"]);
    final token = await newUser(username, password);

    print(token);
    if(token != null && token > 0){
      print('1-Creéation en cours sur le telephone');
      print('212-Creéation en cours sur le telephone');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', token);
      prefs.setString("username", username);
      prefs.setString("password", password);
      final account  = await DBProvider.db.getUserAccount(token);
      print(account.userId);
      prefs.setInt('account_id', account.id);
      return true;
    }else{
      return false;
    }
  }

  Future<bool> logout() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool>  updatePassword(newPassword, String username) async {
    // Lancer la connexion avec une méthode async et un loader
  }

  Future<bool>  login(String username, String password) async{
    // Lancer la connexion avec une méthode async et un loader
    print([username, password, "Connect Test"]);
    final token = await DBProvider.db.getUserByUsername(username);

    print(token);
    if(token != null){
      if(token.password.compareTo(password) == 0){
        print('1-Connexion en cours sur le telephone');
        print('212-Connexion en cours sur le telephone');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('userId', token.id);
        prefs.setString("username", username);
        prefs.setString("password", password);
        final account  = await DBProvider.db.getUserAccount(token.id);
        print(account.userId);
        prefs.setInt('account_id', account.id);
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
}