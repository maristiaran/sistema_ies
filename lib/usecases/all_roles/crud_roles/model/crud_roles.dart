import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/model/entities/syllabus.dart';
import 'package:sistema_ies/core/model/entities/users.dart';
import 'package:sistema_ies/core/model/ies_system.dart';
import 'package:sistema_ies/core/model/utils/operation_utils.dart';
import 'package:sistema_ies/core/model/utils/responses.dart';
import 'package:sistema_ies/usecases/all_roles/login/model/login.dart';
import 'package:sistema_ies/usecases/all_roles/registering/model/registering.dart';

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
  OperationState initialState() {
    return const OperationState(stateName: CRUDRoleState.initial);
  }

  Future addRoleToUser(
      {required IESUser user, required UserRole userRole}) async {
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
