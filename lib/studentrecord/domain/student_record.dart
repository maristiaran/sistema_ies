import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum StudentRecordStateName {
  init,
  failure,
  loading,
  studentRecordGetSuccesfully
}

class StudentRecordState extends OperationState {
  final IESUser currentUser;
  final StudentRecord? studentRecord;
  const StudentRecordState(this.currentUser, this.studentRecord,
      {required Enum stateName})
      : super(stateName: stateName);
  StudentRecordState copyNewState(
      {required StudentRecordStateName newState,
      required StudentRecord? studentRecord}) {
    return StudentRecordState(currentUser, studentRecord, stateName: stateName);
  }
}

class StudentRecordUseCase extends Operation<StudentRecordState> {
  final IESUser currentIESUser;

  StudentRecordUseCase({required this.currentIESUser});

  @override
  StudentRecordState initializeUseCase() {
    return StudentRecordState(currentIESUser, null,
        stateName: StudentRecordStateName.init);
  }

  // Define methods here //
  /////////////////////////
  getStudentRecords(currentIESUser, syllabusId) async {
    changeState(currentState.copyNewState(
        newState: StudentRecordStateName.loading, studentRecord: null));
    await IESSystem()
        .getStudentRecordRepository()
        ?.getStudentRecord(syllabusId, currentIESUser)
        .fold(
            (left) => changeState(currentState.copyNewState(
                newState: StudentRecordStateName.failure, studentRecord: null)),
            (right) => {
                  changeState(currentState.copyNewState(
                      newState:
                          StudentRecordStateName.studentRecordGetSuccesfully,
                      studentRecord: right))
                });
  }
  /////////////////////////
}
