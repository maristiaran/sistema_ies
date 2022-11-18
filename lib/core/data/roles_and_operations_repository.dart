import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class RolesAndOperationsRepositoryMemoryAdapter
    implements RolesAndOperationsRepositoryPort {
  final Map<UserRoleTypeName, UserRoleType> _cachedUserRoleTypes =
      <UserRoleTypeName, UserRoleType>{};
  final Map<UserRoleOperationName, UserRoleOperation>
      _cachedUserRoleOperations = <UserRoleOperationName, UserRoleOperation>{};

  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    _addCachedUserRoleType(
        {required UserRoleTypeName roleTypeName,
        required String title,
        required List<UserRoleOperationName> operationNames}) {
      _cachedUserRoleTypes[roleTypeName] = UserRoleType(
          name: roleTypeName, title: title, operationNames: operationNames);
    }

    _addAllUserRoleOperations() {
      <UserRoleOperationName, String>{
        UserRoleOperationName.registerAsIncomingStudent:
            'Inscripción a carrera',
        UserRoleOperationName.registerForCourse: 'Inscripción a cursar',
        UserRoleOperationName.registerForExam: 'Inscripción a mesa',
        UserRoleOperationName.checkStudentRecord:
            'Consultar trayecto estudiantil',
        UserRoleOperationName.uploadFinalCourseGrades:
            'Cargar notas de proceso',
        UserRoleOperationName.uploadFinalExamGrades:
            'Cargar notas de mesa final',
        UserRoleOperationName.checkFinalExamsDates: 'Consultar mesas finales',
        UserRoleOperationName.crudUsersAndRoles: 'Editar usuarios y roles',
        UserRoleOperationName.resetAndSaveLogs:
            'Resguardar y borrar registro de operaciones',
        UserRoleOperationName.checkLog: 'Consultar registro de operaciones',
        UserRoleOperationName.adminCourse: 'Editar curso',
        UserRoleOperationName.adminFinalExamsAndInstances:
            'Editar turnos y mesas finales',
        UserRoleOperationName.adminStudentRecords:
            'Editar trayectos estudiantiles',
        UserRoleOperationName.writeExamGrades: 'Cargar notas finales en papel',
        UserRoleOperationName.adminSyllabuses: 'Editar Planes de estudio',
      }.forEach((key, value) {
        _cachedUserRoleOperations[key] =
            UserRoleOperation(name: key, title: value);
      });
    }

    _addAllRoleTypes() {
      _addCachedUserRoleType(
          roleTypeName: UserRoleTypeName.guest,
          title: 'Invitado',
          operationNames: [UserRoleOperationName.registerAsIncomingStudent]);
      _addCachedUserRoleType(
          roleTypeName: UserRoleTypeName.incomingStudent,
          title: 'Ingresante',
          operationNames: [
            UserRoleOperationName.registerAsIncomingStudent,
            UserRoleOperationName.registerForCourse,
          ]);
      _addCachedUserRoleType(
          roleTypeName: UserRoleTypeName.student,
          title: 'Estudiante',
          operationNames: [
            UserRoleOperationName.registerAsIncomingStudent,
            UserRoleOperationName.registerForCourse,
            UserRoleOperationName.registerForExam,
            UserRoleOperationName.checkFinalExamsDates,
            UserRoleOperationName.checkStudentRecord,
          ]);
      _addCachedUserRoleType(
          roleTypeName: UserRoleTypeName.teacher,
          title: 'Docente',
          operationNames: [
            UserRoleOperationName.registerAsIncomingStudent,
            UserRoleOperationName.checkFinalExamsDates,
            UserRoleOperationName.uploadFinalCourseGrades,
            UserRoleOperationName.uploadFinalExamGrades,
          ]);
      _addCachedUserRoleType(
          roleTypeName: UserRoleTypeName.administrative,
          title: 'Administrativo',
          operationNames: [
            UserRoleOperationName.registerAsIncomingStudent,
            UserRoleOperationName.adminCourse,
            UserRoleOperationName.adminFinalExamsAndInstances,
            UserRoleOperationName.adminSyllabuses,
            UserRoleOperationName.crudUsersAndRoles,
            UserRoleOperationName.adminStudentRecords
          ]);
      _addCachedUserRoleType(
          roleTypeName: UserRoleTypeName.manager,
          title: 'Directivo',
          operationNames: [UserRoleOperationName.registerAsIncomingStudent]);
      _addCachedUserRoleType(
          roleTypeName: UserRoleTypeName.systemAdmin,
          title: 'Administrador de sistema',
          operationNames: [
            UserRoleOperationName.registerAsIncomingStudent,
            UserRoleOperationName.checkLog,
            UserRoleOperationName.resetAndSaveLogs,
            UserRoleOperationName.crudUsersAndRoles
          ]);
    }

//Adding all operations
    _addAllUserRoleOperations();
    //Adding all user types with  operations
    _addAllRoleTypes();

    return Right(Success('Ok'));
  }

  @override
  List<UserRoleOperation> getUserRoleOperations(
      UserRoleTypeName userRoleTypeName) {
    return getUserRoleType(userRoleTypeName)
        .operationNames
        .map((op) => _cachedUserRoleOperations[op]!)
        .toList();
  }

  @override
  UserRoleType getUserRoleType(UserRoleTypeName userRoleName) {
    if (_cachedUserRoleTypes[userRoleName] == null) {
      return _cachedUserRoleTypes[userRoleName]!;
    } else {
      return _cachedUserRoleTypes[userRoleName]!;
    }
    // return _cachedUserRoleTypes[userRoleName]!;
  }
}
