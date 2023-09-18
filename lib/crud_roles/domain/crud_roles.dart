import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/registering/domain/registering.dart';

//Registering states

//Auth State Names
enum CRUDRoleStateName {
  initial,
  failure,
}

class CRUDRoleState extends OperationState {
  const CRUDRoleState({required Enum stateName}) : super(stateName: stateName);

  @override
  List<Object?> get props => [stateName];
}

class CRUDRoleInitialState extends CRUDRoleState {
  final IESUser? selectedUser;
  final List<UserRole> roles;
  final UserRole? currentRole;
  const CRUDRoleInitialState(
      {this.selectedUser, this.currentRole, required this.roles})
      : super(stateName: CRUDRoleStateName.initial);

  @override
  List<Object?> get props => [stateName, currentRole];

  CRUDRoleInitialState copyChangingIESUser({required IESUser selectedIESUser}) {
    return CRUDRoleInitialState(
        selectedUser: selectedIESUser, roles: selectedIESUser.roles);
  }

  CRUDRoleInitialState copyChangingSelectedRole(
      {required UserRole selectedUserRole}) {
    return CRUDRoleInitialState(currentRole: selectedUserRole, roles: roles);
  }
}

// AUTORIZATION
class CRUDRoleUseCase extends Operation<OperationState> {
  // Use cases
  late LoginUseCase loginUseCase;
  late RegisteringUseCase registeringUseCase;
  IESUser? currentUser;
  //Accessors
  late List<Syllabus> syllabuses;
  late Syllabus currentSyllabus;
  //allowedUserRoleTypes
  List<UserRoleTypeName> allowedUserRoleTypeNames;
//Auth Use Case initialization
  CRUDRoleUseCase({required this.allowedUserRoleTypeNames})
      : super(const CRUDRoleInitialState(roles: []));

  // @override
  // OperationState initializeUseCase() {
  //   return const OperationState(stateName: CRUDRoleState.initial);
  // }

  Future selectUser({required IESUser user}) async {
    currentUser = user;

    changeState(
        CRUDRoleInitialState(selectedUser: currentUser, roles: user.roles));
  }

  Future addRoleToUser(
      {required IESUser user, required UserRole userRole}) async {
    Either<Failure, Success> response = await IESSystem()
        .getUsersRepository()
        .addUserRole(user: user, userRole: userRole);
    response.fold(
        (failure) => changeState(
            const OperationState(stateName: CRUDRoleStateName.failure
                // ,
                // changes: {'failure': failure.message}
                )), (success) {
      user.addRole(userRole);
      changeState(
          CRUDRoleInitialState(selectedUser: currentUser, roles: user.roles));
      // changeState(const OperationState(stateName: LoginStateName.init));
    });
  }
}
