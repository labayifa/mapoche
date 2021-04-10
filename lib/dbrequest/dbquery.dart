
import 'package:ma_poche/dbrequest/dbprovider.dart';
import 'package:ma_poche/helpers/user.dart';
import 'package:sqflite/sqflite.dart';



Future<int> newUser(username, password) async{

  User user = new User(
    username: username,
    password: password,
    creationDateTime: DateTime.now().millisecondsSinceEpoch,
    updateDateTime: DateTime.now().millisecondsSinceEpoch
  );

  final result = await DBProvider.db.newUser(user);
  return result;
}