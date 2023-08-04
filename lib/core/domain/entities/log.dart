enum LogsActions {
  deleteUserRol,
  changeUserRol,
  addUserRol,
  addSubject,
  updateSubject,
  deleteSubject,
  updateUser,
  deleteUser,
}

class Log {
  DateTime datetime;
  String actionUsername;
  int? modifiedUserDNI;
  String rol;
  String modifiedUsername;
  String description;

  Log(
      {required this.datetime,
      required this.actionUsername,
      required this.modifiedUserDNI,
      required this.rol,
      required this.modifiedUsername,
      required this.description});
}
