import "package:firebase_core/firebase_core.dart";
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
// import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/core/domain/repositories/users_repository_port.dart';
import 'package:sistema_ies/crud_roles/crud_roles.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/home/domain/home.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/register_as_incoming_student/domain/registering_as_incoming_user.dart';
import 'package:sistema_ies/registering/domain/registering.dart';

enum IESSystemStateName {
  login,
  home,
  registering,
  registeringAsIncomingStudent,
  recoverypass
}

class IESSystem extends Operation {
  // IESSystem as a Singleton
  static final IESSystem _singleton = IESSystem._internal();

  // Repositories
  UsersRepositoryPort? _usersRepository;
  SyllabusesRepositoryPort? _syllabusesRepository;
  RolesAndOperationsRepositoryPort? _rolesAndOperationsRepository;

  // Use cases
  late LoginUseCase loginUseCase;
  late HomeUseCase homeUseCase;
  late RegisteringUseCase registeringUseCase;
  late CRUDRoleUseCase crudRolesUseCase;
  late RegisteringAsIncomingStudentUseCase registeringAsIncomingStudentUseCase;

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

  Future onReturnFromOperation() async {
    changeState(const OperationState(stateName: IESSystemStateName.home));
  }

  Future onHomeSelectedOperation(UserRoleOperation userOperation) async {
    registeringAsIncomingStudentUseCase = RegisteringAsIncomingStudentUseCase(
        iesUser: homeUseCase.currentIESUser);

    changeState(const OperationState(
        stateName: IESSystemStateName.registeringAsIncomingStudent));
  }

  startRegisteringNewUser() {
    registeringUseCase = RegisteringUseCase();
    // registeringUseCase.initializeUseCase();
    changeState(
        const OperationState(stateName: IESSystemStateName.registering));
  }

  restartLogin() {
    changeState(const OperationState(stateName: IESSystemStateName.login));
    // loginUseCase.initLogin();
  }

  onCurrentUserLogout() {}
}
