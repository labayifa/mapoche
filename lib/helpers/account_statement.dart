import 'dart:convert';


AccountStatement accountStatementFromJson(String str) {
  final jsonData = json.decode(str);
  return AccountStatement.fromMap(jsonData);
}

String accountStatementToJson(AccountStatement data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class AccountStatement {
  int id;
  String lib;
  double credit;
  double debit;
  double solde;
  int accountId;
  int dateOps;
  int creationDateTime;
  int updateDateTime;

  AccountStatement({
    this.id,
    this.lib,
    this.credit,
    this.debit,
    this.solde,
    this.dateOps,
    this.accountId,
    this.creationDateTime,
    this.updateDateTime
  });

  factory AccountStatement.fromMap(Map<String, dynamic> json) => new AccountStatement(
      id: json["id"],
      lib: json["lib"],
      credit: json["credit"],
      debit: json["debit"],
      solde: json["solde"],
      accountId: json["account_id"],
      dateOps: json["date_ops"],
      creationDateTime: json["creation_datetime"],
      updateDateTime: json["update_datetime"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "lib": lib,
    "credit": credit,
    "debit": debit,
    "solde": solde,
    "account_id": accountId,
    "date_ops": dateOps,
    "creation_datetime": creationDateTime,
    "update_datetime": updateDateTime,
  };
}