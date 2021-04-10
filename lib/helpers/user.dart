
import 'dart:convert';


User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromMap(jsonData);
}

String userToJson(User data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class User {
  int id;
  String username;
  String password;
  int creationDateTime;
  int updateDateTime;

  User({
    this.id,
    this.username,
    this.password,
    this.creationDateTime,
    this.updateDateTime
  });

  factory User.fromMap(Map<String, dynamic> json) => new User(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    creationDateTime: json["creation_datetime"],
    updateDateTime: json["update_datetime"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "password": password,
    "creation_datetime": creationDateTime,
    "update_datetime": updateDateTime,
  };
}