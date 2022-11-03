import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum HomeStateName { init, calendar, selectingRole, selectingRoleOperation }

class HomeState extends OperationState {
  // final IESUser currentUser;
  final UserRole currentRole;
  const HomeState(
      {required Enum stateName,
      // required this.currentUser,
      required this.currentRole})
      : super(stateName: stateName);
  HomeState copyChangingRole({required UserRole newUserRole}) {
    return HomeState(stateName: stateName, currentRole: newUserRole);
  }

  HomeState copyChangingState({required HomeStateName newState}) {
    return HomeState(stateName: newState, currentRole: currentRole);
  }

  IESUser getCurrentUser() {
    return IESSystem().getCurrentIESUserIfAny()!;
  }

  UserRole getUserRole() {
    return IESSystem().getCurrentRoleIfAny()!;
  }

  UserRoleTypeName getUserRoleTypeName() {
    return IESSystem().getCurrentRoleIfAny()!.userRoleTypeName();
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
class HomeUseCase extends UseCase<HomeState> {
  //Accessors
  late List<Syllabus> syllabuses;
  late Syllabus currentSyllabus;

//Auth Use Case initialization
  HomeUseCase();

  @override
  HomeState initialState() {
    return HomeState(
        stateName: HomeStateName.init,
        currentRole: IESSystem().getCurrentRoleIfAny()!);
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
