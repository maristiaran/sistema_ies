import 'package:sistema_ies/core/domain/entities/student_record.dart';
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
  final IESUser currentIESUser;
  const StudentRecordState({required stateName, required this.currentIESUser})
      : super(stateName: stateName);

  StudentRecordState copyChangingState(
      {required StudentRecordStateName newState}) {
    return StudentRecordState(
        currentIESUser: currentIESUser, stateName: newState);
  }
}

class StudentRecordUseCase extends Operation<StudentRecordState> {
  //Accessors
  final IESUser currentIESUser;
  List<StudentRecord> currentStudentRecords = [];

//Auth Use Case initialization
  StudentRecordUseCase({required this.currentIESUser});
  @override
  StudentRecordState initializeUseCase() {
    return StudentRecordState(
        currentIESUser: currentIESUser, stateName: StudentRecordStateName.init);
  }

  void addNewStudentRecord(List<StudentRecord> studentRecordGot) {
    currentStudentRecords = studentRecordGot;
  }

  void setAsLoading() {
    changeState(currentState.copyChangingState(
        newState: StudentRecordStateName.loading));
  }

  Future getStudentRecord() async {
    var response;
    setAsLoading();
    await IESSystem()
        .getStudentRecordRepository()
        ?.getAllStudentRecord()
        .then((value) => value.fold((failure) {
              response = StudentRecordStateName.failure;
            }, (studentRecord) {
              changeState(StudentRecordState(
                  currentIESUser: currentIESUser,
                  stateName:
                      StudentRecordStateName.studentRecordGetSuccesfully));
              addNewStudentRecord(studentRecord);
              response = StudentRecordStateName.studentRecordGetSuccesfully;
            }));
    return response;
  }

  returnToHome() {
    IESSystem().onUserLogged(currentIESUser);
  }
  /////////////////////////
}
