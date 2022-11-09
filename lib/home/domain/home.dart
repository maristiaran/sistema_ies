// import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum HomeStateName { init, calendar, selectingRole, selectingRoleOperation }

class HomeState extends OperationState {
  // final IESUser currentUser;
  final UserRole currentRole;
  const HomeState({required Enum stateName, required this.currentRole})
      : super(stateName: stateName);
  HomeState copyChangingRole({required UserRole newUserRole}) {
    return HomeState(stateName: stateName, currentRole: newUserRole);
  }

  HomeState copyChangingState({required HomeStateName newState}) {
    return HomeState(stateName: newState, currentRole: currentRole);
  }

  UserRoleTypeName getUserRoleTypeName() {
    return currentRole.userRoleTypeName();
  }

  List<ParameretizedUserRoleOperation>
      getCurrentUserRoleParameterizedOperations() {
    return IESSystem()
        .getRolesAndOperationsRepository()
        .getUserRoleType(getUserRoleTypeName())
        .parameterizedOperations;
  }
}

// AUTORIZATION
class HomeUseCase extends Operation<HomeState> {
  //Accessors
  // late List<Syllabus> syllabuses;
  // late Syllabus currentSyllabus;
  final IESUser currentIESUser;

//Auth Use Case initialization
  HomeUseCase({required this.currentIESUser});
  @override
  HomeState initializeUseCase() {
    return HomeState(
        stateName: HomeStateName.init, currentRole: currentIESUser.defaultRole);
  }

  void startSelectingUserRole() async {
    changeState(
        currentState.copyChangingState(newState: HomeStateName.selectingRole));
  }

  void startSelectingUserRoleOperation() async {
    changeState(currentState.copyChangingState(
        newState: HomeStateName.selectingRoleOperation));
  }
}
