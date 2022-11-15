import "package:firebase_core/firebase_core.dart";
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/core/domain/repositories/users_repository_port.dart';
import 'package:sistema_ies/crud_roles/crud_roles.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/home/domain/home.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/registering/domain/registering.dart';
import 'package:sistema_ies/studentrecord/domain/student_record.dart';

enum IESSystemStateName {
  login,
  home,
  registering,
  recoverypass,
  studentrecord
}

// class IESSystemState extends OperationState {
//   IESSystemState({required IESSystemStateName  stateName}):super(stateName: stateName);
// }

class IESSystem extends Operation {
  // IESSystem as a Singleton
  static final IESSystem _singleton = IESSystem._internal();

  // Repositories
  UsersRepositoryPort? _usersRepository;
  SyllabusesRepositoryPort? _syllabusesRepository;
  RolesAndOperationsRepositoryPort? _rolesAndOperationsRepository;
  StudentRecordRepositoryPort? _studentRecordRepository;

  // Use cases
  late StudentRecordUseCase studentRecordUseCase;
  late LoginUseCase loginUseCase;
  late HomeUseCase homeUseCase;
  late RegisteringUseCase registeringUseCase;
  late CRUDRoleUseCase crudRolesUseCase;

  // IESSystem as a Singleton
  factory IESSystem() {
    return _singleton;
  }
  IESSystem._internal();

  UsersRepositoryPort getUsersRepository() {
    _usersRepository ??= usersRepository;
    return _usersRepository!;
  }

  SyllabusesRepositoryPort getSyllabusesRepository() {
    _syllabusesRepository ??= syllabusesRepository;
    return _syllabusesRepository!;
  }

  RolesAndOperationsRepositoryPort getRolesAndOperationsRepository() {
    if (_rolesAndOperationsRepository == null) {
      _rolesAndOperationsRepository = rolesAndOperationsRepository;
      _rolesAndOperationsRepository!.initRepositoryCaches();
    }

    return _rolesAndOperationsRepository!;
  }

  StudentRecordRepositoryPort? getStudentRecordRepository() {
    _studentRecordRepository ??= studentRecordFakeDatasource;
    return _studentRecordRepository;
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
  @override
  OperationState initializeUseCase() {
    return const OperationState(stateName: IESSystemStateName.login);
  }

  initializeIESSystem() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // initializeStatesAndStateNotifier();
    await startLogin();
  }

  startLogin() {
    loginUseCase = LoginUseCase();
    print("start login");
    changeState(const OperationState(stateName: IESSystemStateName.login));
  }

  Future onUserLogged(IESUser userLogged) async {
    homeUseCase = HomeUseCase(currentIESUser: userLogged);
    // homeUseCase.initializeUseCase();
    changeState(const OperationState(stateName: IESSystemStateName.home));
  }

  startRegisteringNewUser() {
    registeringUseCase = RegisteringUseCase();
    changeState(
        const OperationState(stateName: IESSystemStateName.registering));
  }

  restartLogin() {
    changeState(const OperationState(stateName: IESSystemStateName.login));
    // loginUseCase.initLogin();
  }

  startStudentRecord(IESUser userLogged) async {
    studentRecordUseCase = StudentRecordUseCase(currentIESUser: userLogged);
    IESSystem().studentRecordUseCase.getStudentRecord();
    changeState(
        const OperationState(stateName: IESSystemStateName.studentrecord));
  }

  onCurrentUserLogout() {}
}
