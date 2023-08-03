/* import 'dart:convert';

import 'package:sistema_ies/core/domain/entities/log.dart';

LogModel logModelFromJson(String str) => LogModel.fromJson(json.decode(str));
String logModelToJson(LogModel data) => json.encode(data.toJson());

class LogModel implements Log {
  LogModel(
      {required this.datetime,
      required this.userid,
      required this.username,
      required this.rol,
      required this.description});
  @override
  String datetime;

  @override
  String description;

  @override
  String rol;

  @override
  int userid;

  @override
  String username;

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
      datetime: json["datetime"],
      userid: json["userid"],
      username: json["username"],
      rol: json["rol"],
      description: json["description"]);

  Map<String, dynamic> toJson() => {
        "datetime": datetime,
        "userid": userid,
        "username": username,
        "rol": rol,
        "description": description
      };
} */
