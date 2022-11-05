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
enum CRUDRoleState { initial, failure, addedRole, removedRole }

// AUTORIZATION
class CRUDRoleUseCase extends UseCase {
  // Use cases
  late LoginUseCase loginUseCase;
  late RegisteringUseCase registeringUseCase;

  //Accessors
  late List<Syllabus> syllabuses;
  late Syllabus currentSyllabus;

//Auth Use Case initialization
  CRUDRoleUseCase({required Operation parentOperation});

  @override
  OperationState initializeUseCase() {
    return const OperationState(stateName: CRUDRoleState.initial);
  }

  Future addRoleToUser(
      {required IESUser user, required UserRoleType userRole}) async {
    Either<Failure, Success> response = await IESSystem()
        .getUsersRepository()
        .addUserRole(user: user, userRole: userRole);
    response.fold(
        (failure) =>
            changeState(const OperationState(stateName: CRUDRoleState.failure
                // ,
                // changes: {'failure': failure.message}

                )), (success) {
      changeState(const OperationState(stateName: CRUDRoleState.addedRole));
      // changeState(const OperationState(stateName: LoginStateName.init));
    });
  }
}
