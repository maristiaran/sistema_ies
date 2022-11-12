import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum StudentRecordStateName {
  init,
  failure,
  loading,
  studentRecordGetSuccesfully
}

class StudentRecordState extends OperationState {
  final IESUser currentIESUser;
  // final IESUser? currentIESUserRole;

  const StudentRecordState({required this.currentIESUser, required stateName})
      : super(stateName: stateName);

  StudentRecordState copyNewState({required StudentRecordStateName newState}) {
    return StudentRecordState(
        currentIESUser: currentIESUser, stateName: newState);
  }
}

// LOGIN USE CASE
class StudentRecordUsecase extends Operation<StudentRecordState> {
  List<StudentRecord> currentStudentRecords = [];
  IESUser currentIESUser;
//Auth Use Case initialization
  StudentRecordUsecase({required this.currentIESUser}) : super();

  @override
  StudentRecordState initializeUseCase() {
    return StudentRecordState(
        currentIESUser: currentIESUser, stateName: StudentRecordStateName.init);
  }

  void setAsLoading(currentIESUser) {
    changeState(
        currentState.copyNewState(newState: StudentRecordStateName.loading));
  }
  /////////////////////////
}
