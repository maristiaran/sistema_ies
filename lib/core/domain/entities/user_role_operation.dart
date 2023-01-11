enum UserRoleOperationName {
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

class UserRoleOperation {
  final UserRoleOperationName name;
  final String title;

  UserRoleOperation({required this.name, required this.title});
}
