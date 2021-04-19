
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ma_poche/helpers/account.dart';
import 'package:ma_poche/helpers/account_statement.dart';
import 'package:ma_poche/helpers/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MaPocheDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE User ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "username TEXT UNIQUE,"
          "password TEXT,"
          "creation_datetime INTEGER,"
          "update_datetime INTEGER"
          ")");

      await db.execute("CREATE TABLE Account ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "user_id INTEGER,"
          "value REAL,"
          "last_value REAL,"
          "creation_datetime INTEGER,"
          "update_datetime INTEGER,"
          "FOREIGN KEY (user_id) REFERENCES User (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          ")");

      await db.execute("CREATE TABLE AccountStatement ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "account_id INTEGER,"
          "lib TEXT,"
          "debit REAL,"
          "credit REAL,"
          "solde REAL,"
          "date_ops INTEGER,"
          "creation_datetime INTEGER,"
          "update_datetime INTEGER,"
          "FOREIGN KEY (account_id) REFERENCES Account (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          ")");
    });
  }

  Future<int> newUser(User newUser) async {
    final db = await database;


    final res =  await db.rawInsert(
        "INSERT Into User (username, password, creation_datetime, update_datetime)"
            " VALUES (?,?,?,?)",
        [newUser.username, newUser.password, DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );

    final res2 = await db.rawInsert(
        "INSERT Into Account (user_id, value, last_value, creation_datetime, update_datetime)"
            " VALUES (?,?,?,?,?)",
        [res, 0, 0, DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );
    return res;
  }

  newStatement(AccountStatement statement, Account account) async {
    final db = await database;

    final res =  await db.rawInsert(
        "INSERT Into AccountStatement (account_id, credit, debit, solde, lib, date_ops, creation_datetime, update_datetime)"
            " VALUES (?,?,?,?,?,?,?,?)",
        [statement.accountId, statement.credit, statement.debit, statement.solde, statement.lib,
        statement.dateOps,DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );

    var res2 = await db.update("Account", account.toMap(),
        where: "id = ?", whereArgs: [account.id]);
    return res;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    var res = await db.query("User");
    List<User> list =
    res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  Future<Account> getUserAccount(int userId) async {
    final db = await database;
    var res =await  db.query("Account", where: "user_id = ?", whereArgs: [userId]);
    return res.isNotEmpty ? Account.fromMap(res.first) : Null ;
  }

  Future<Account> getAccountById(int id) async {
    final db = await database;
    var res =await  db.query("Account", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Account.fromMap(res.first) : Null ;
  }

  Future<User> getUserById(int id) async {
    final db = await database;
    var res =await  db.query("User", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? User.fromMap(res.first) : Null ;
  }

  Future<List<AccountStatement>> getStatementByAccountId(int accountId) async {
    final db = await database;
    var res  = await  db.query("AccountStatement", where: "account_id = ?", whereArgs: [accountId], orderBy: "id  DESC");
    List<AccountStatement> list =
    res.isNotEmpty ? res.map((c) => AccountStatement.fromMap(c)).toList() : [];
    return list;
  }

  Future<User> getUserByUsername(String username) async{
    final db = await database;
    var res =await  db.query("User", where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? User.fromMap(res.first) : Null ;
  }
}

