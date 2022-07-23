abstract class UserRoleOperation {
  String operationName();
}

class RegisterAsNewStudentOperation extends UserRoleOperation {
  @override
  String operationName() {
    return 'Inscripción a una carrera';
  }
}
