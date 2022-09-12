enum UserRoleOperations {
  registerAsUser,
  registerAsIncomingStudent,
  registerForCourse,
  registerForExam,
  checkStudentRecord,
  uploadFinalCourseGrades,
  uploadFinalExamGrades,
  checkFinalExamsDates,
  crudUsersAndRoles,
  resetAndSaveLogs,
  checkLog,
  adminCourse,
  adminFinalExamsAndInstances,
  adminStudentRecords,
  writeExamGrades,
  adminSyllabuses,

}

abstract class UserRoleOperation {
  String operationName();
}

class RegisterAsNewStudentOperation extends UserRoleOperation {
  @override
  String operationName() {
    return 'Inscripción a una carrera';
  }
}
