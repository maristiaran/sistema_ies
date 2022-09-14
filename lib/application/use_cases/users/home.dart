import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';

//Registering states

//Auth State Names
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
