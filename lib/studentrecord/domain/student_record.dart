import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
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

@immutable
class PanelState {
  final List<bool> panelState;
  const PanelState({required this.panelState});
}

class PanelNotifier extends StateNotifier<PanelState> {
  PanelNotifier() : super(const PanelState(panelState: [true, false, false]));
  init(int index) {
    List<bool> states = [];
    for (var i = 0; i < index; i++) {
      i == 0 ? states.add(true) : states.add(false);
    }
    state = PanelState(panelState: states);
  }

  toggle(int index) {
    List<bool> newList = [];
    for (var x = 0; x < state.panelState.length; x++) {
      newList.add(false);
    }
    for (var i = 0; i < newList.length; i++) {
      if (i == index) {
        newList[i] = !state.panelState[i];
      } else {
        newList[i] = false;
      }
    }
    state = PanelState(panelState: newList);
  }
}

StateNotifierProvider<PanelNotifier, PanelState> panelStateNotifier =
    StateNotifierProvider<PanelNotifier, PanelState>(
        ((ref) => PanelNotifier()));
