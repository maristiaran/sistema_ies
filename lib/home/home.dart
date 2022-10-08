//Registering states

//Auth State Names
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum HomeState { init, calendar, selectingRole, selectingRoleOperation }

// AUTORIZATION
class HomeUseCase extends UseCase {
  //Accessors
  late List<Syllabus> syllabuses;
  late Syllabus currentSyllabus;

//Auth Use Case initialization
  HomeUseCase();

  @override
  OperationState initialState() {
    return const OperationState(stateName: HomeState.init);
  }

  void startSelectingUserRole() async {
    changeState(const OperationState(stateName: HomeState.selectingRole));
  }

  void startSelectingUserRoleOperation() async {
    changeState(
        const OperationState(stateName: HomeState.selectingRoleOperation));
  }
}
