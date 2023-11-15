import "package:firebase_core/firebase_core.dart";
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/core/data/studentregister_firestore_repository.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/repositories/teachers_repository.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/core/domain/repositories/users_repository_port.dart';
import 'package:sistema_ies/crud_roles/domain/crud_roles.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/home/domain/home.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/register_as_incoming_student/domain/registering_as_incoming_user.dart';
import 'package:sistema_ies/recoverypass/domain/recoverypass.dart';
import 'package:sistema_ies/register_for_exam/domain/register_for_exam.dart';
import 'package:sistema_ies/registering/domain/registering.dart';
// import 'package:sistema_ies/registration_management/domain/registration_management.dart';

enum IESSystemStateName {
  login,
  home,
  registering,
  registeringAsIncomingStudent,
  checkStudentRecord,
  recoverypass,
  studentRecord,
  crudTeacherAndStudents,
  crudAllUsers,
  registerForExam
}

class IESSystem extends Operation {
  // IESSystem as a Singleton
  static final IESSystem _singleton = IESSystem._internal();

  // Repositories
  UsersRepositoryPort? _usersRepository;
  SyllabusesRepositoryPort? _syllabusesRepository;
  RolesAndOperationsRepositoryPort? _rolesAndOperationsRepository;
  StudentRepositoryPort? _studentRecordRepository;
  StudentsRegister? _studentRegisterExam;
  TeachersRepositoryPort? _teachersRepository;

  // Use cases
  late LoginUseCase loginUseCase;
  late HomeUseCase homeUseCase;
  late RegisteringUseCase registeringUseCase;
  late RecoveryPassUseCase recoveryPassUseCase;
  late RegisteringAsIncomingStudentUseCase registeringAsIncomingStudentUseCase;
  late CheckStudentRecordUseCase checkStudentRecordUseCase;
  late CRUDRoleUseCase crudTeachersAndStudentsUseCase;
  late CRUDRoleUseCase crudAllUseCase;
  late RegisterForExamUseCase registerForExamUseCase;
  // late RegistrationManagementUseCase registrationManagementUseCase;
  // IESSystem as a Singleton
  factory IESSystem() {
    return _singleton;
  }
  IESSystem._internal()
      : super(const OperationState(stateName: IESSystemStateName.login));

  UsersRepositoryPort getUsersRepository() {
    _usersRepository ??= usersRepository;
    return _usersRepository!;
  }

  TeachersRepositoryPort getTeachersRepository() {
    _teachersRepository ??= _teachersRepository;
    return _teachersRepository!;
  }

  SyllabusesRepositoryPort getSyllabusesRepository() {
    if (_syllabusesRepository == null) {
      _syllabusesRepository = syllabusesRepository;
      _syllabusesRepository!.initRepositoryCaches();
    }
    return _syllabusesRepository!;
  }

  RolesAndOperationsRepositoryPort getRolesAndOperationsRepository() {
    if (_rolesAndOperationsRepository == null) {
      _rolesAndOperationsRepository = rolesAndOperationsRepository;
      _rolesAndOperationsRepository!.initRepositoryCaches();
    }

    return _rolesAndOperationsRepository!;
  }

  StudentRepositoryPort getStudentRecordRepository() {
    _studentRecordRepository ??= studentRecordDatasource;
    return _studentRecordRepository!;
  }

  StudentsRegister getStudentsRepository() {
    _studentRegisterExam ??= registerExamDatasource;
    return _studentRegisterExam!;
  }

  // initializeStatesAndStateNotifier() {
  //   OperationStateNotifier newStateNotifier = (OperationStateNotifier(
  //       initialState:
  //           const OperationState(stateName: IESSystemStateName.home)));
  //   stateNotifierProvider =
  //       StateNotifierProvider<OperationStateNotifier, OperationState>((ref) {
  //     return newStateNotifier;
  //   });
  //   stateNotifier = newStateNotifier;
  // }
  // @override
  // OperationState initializeUseCase() {
  //   return const OperationState(stateName: IESSystemStateName.login);
  // }

  initializeIESSystem() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // initializeStatesAndStateNotifier();
    await startLogin();
  }

  startLogin() {
    loginUseCase = LoginUseCase();
    changeState(const OperationState(stateName: IESSystemStateName.login));
  }

  Future onUserLogged(IESUser userLogged) async {
    homeUseCase = HomeUseCase(currentIESUser: userLogged);
    changeState(const OperationState(stateName: IESSystemStateName.home));
  }

  void onReturningToHome() {
    changeState(const OperationState(stateName: IESSystemStateName.home));
  }

  Future onHomeSelectedOperation(UserRoleOperation userOperation) async {
    switch (userOperation.name) {
      case UserRoleOperationName.registerAsIncomingStudent:
        registeringAsIncomingStudentUseCase =
            RegisteringAsIncomingStudentUseCase(
                iesUser: homeUseCase.currentIESUser);

        changeState(const OperationState(
            stateName: IESSystemStateName.registeringAsIncomingStudent));
        break;
      case UserRoleOperationName.checkStudentRecord:
        checkStudentRecordUseCase = CheckStudentRecordUseCase(
            currentIESUser: homeUseCase.currentIESUser,
            studentRole:
                homeUseCase.currentIESUser.getCurrentRole() as Student);
        checkStudentRecordUseCase.getStudentRecords();
        changeState(const OperationState(
            stateName: IESSystemStateName.checkStudentRecord));
        break;
      case UserRoleOperationName.crudTeachersAndStudents:
        crudTeachersAndStudentsUseCase =
            CRUDRoleUseCase(allowedUserRoleTypeNames: [
          // UserRoleTypeName.incomingStudent,
          UserRoleTypeName.student,
          UserRoleTypeName.teacher
        ]);

        changeState(const OperationState(
            stateName: IESSystemStateName.crudTeacherAndStudents));
        break;

      case UserRoleOperationName.crudAll:
        crudTeachersAndStudentsUseCase =
            CRUDRoleUseCase(allowedUserRoleTypeNames: [
          UserRoleTypeName.incomingStudent,
          UserRoleTypeName.student,
          UserRoleTypeName.teacher,
          UserRoleTypeName.guest,
          UserRoleTypeName.administrative,
          UserRoleTypeName.manager
        ]);

        changeState(
            const OperationState(stateName: IESSystemStateName.crudAllUsers));
        break;

      case UserRoleOperationName.registerForExam:
        registerForExamUseCase = RegisterForExamUseCase(
            currentIESUser: homeUseCase.currentIESUser,
            studentRole:
                homeUseCase.currentIESUser.getCurrentRole() as Student);

        changeState(const OperationState(
            stateName: IESSystemStateName.registerForExam));
        break;

      default:
    }
  }

  startRegisteringNewUser() {
    registeringUseCase = RegisteringUseCase();
    changeState(
        const OperationState(stateName: IESSystemStateName.registering));
  }

  startRecoveryPass() {
    recoveryPassUseCase = RecoveryPassUseCase();
    changeState(
        const OperationState(stateName: IESSystemStateName.recoverypass));
  }

  restartLogin() {
    changeState(const OperationState(stateName: IESSystemStateName.login));
    // loginUseCase.initLogin();
  }

  onCurrentUserLogout() {}
}
