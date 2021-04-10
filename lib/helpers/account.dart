import 'dart:convert';

Account accountFromJson(String str) {
  final jsonData = json.decode(str);
  return Account.fromMap(jsonData);
}

String accountToJson(Account data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Account {
  int id;
  int userId;
  double value;
  double lastValue;
  int creationDateTime;
  int updateDateTime;

  Account({
    this.id,
    this.userId,
    this.value,
    this.lastValue,
    this.creationDateTime,
    this.updateDateTime
  });

  factory Account.fromMap(Map<String, dynamic> json) => new Account(
      id: json["id"],
      userId: json["user_id"],
      value: json["value"],
      lastValue: json["last_value"],
      creationDateTime: json["creation_datetime"],
      updateDateTime: json["update_datetime"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "value": value,
    "last_value": lastValue,
    "creation_datetime": creationDateTime,
    "update_datetime": updateDateTime,
  };
}