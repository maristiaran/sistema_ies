class Failure {
  Enum failureName;
  String message;
  Failure({required this.failureName, this.message = ""});
}

class Success {
  String message;
  Success(this.message);
}
