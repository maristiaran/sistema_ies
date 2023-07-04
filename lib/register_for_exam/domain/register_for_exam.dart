import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/register_for_exam/utils/generate_subject_items.dart';

enum RegisterForExamStateName { init }

class RegisterForExamState extends OperationState {
  // final IESUser currentUser;
  final Student currentRole;
  const RegisterForExamState(
      {required Enum stateName, required this.currentRole})
      : super(stateName: stateName);
  RegisterForExamState copyChangingRole({required Student newUserRole}) {
    return RegisterForExamState(stateName: stateName, currentRole: newUserRole);
  }

  RegisterForExamState copyChangingState(
      {required RegisterForExamStateName newState}) {
    return RegisterForExamState(stateName: newState, currentRole: currentRole);
  }

  UserRoleTypeName getUserRoleTypeName() {
    return currentRole.userRoleTypeName();
  }

  List<UserRoleOperation> getCurrentUserRoleOperations() {
    RolesAndOperationsRepositoryPort operationsAndRolesRepo =
        IESSystem().getRolesAndOperationsRepository();

    return operationsAndRolesRepo.getUserRoleOperations(getUserRoleTypeName());
  }
}

// AUTORIZATION
class RegisterForExamUseCase extends Operation<RegisterForExamState> {
  final IESUser currentIESUser;
  final Student studentRole;

  RegisterForExamUseCase(
      {required this.currentIESUser, required this.studentRole})
      : super(RegisterForExamState(
            stateName: RegisterForExamStateName.init,
            currentRole: studentRole));

  List<Subject> getSubjectsToRegister() {
    List<Subject> registerSubjects =
        IESSystem().registerForExamUseCase.studentRole.syllabus.subjects;

    return registerSubjects;
  }

  List<MovementStudentRecord> getStudentRecordMovements(int subjectId) {
    List<MovementStudentRecord> movements = [];
    IESSystem()
        .getStudentRecordRepository()
        .getStudentRecordMovements(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabusId:
                (IESSystem().homeUseCase.currentIESUser.defaultRole as Student)
                    .syllabus
                    .administrativeResolution,
            subjectId: subjectId)
        .then((value) => movements = value);
    movements.sort((a, b) => a.date.isBefore(b.date) ? 1 : -1);
    return movements;
  }
}

// Legacy Provider for... what?

@immutable
class PanelState {
  final List<bool> panelState;
  const PanelState({required this.panelState});
}

class PanelNotifier extends StateNotifier<PanelState> {
  PanelNotifier() : super(const PanelState(panelState: []));
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

class SubjectICard {
  StudentRecordSubject subjectSR;
  bool isExpanded = false;
  SubjectICard({required this.subjectSR});
}

// Subject State Provider Legacy
@immutable
class SubjectState {
  final List<SubjectICard> subjects;
  const SubjectState({required this.subjects});
}

class SubjectStateNotifier extends StateNotifier<SubjectState> {
  SubjectStateNotifier({required List<SubjectICard> subjects})
      : super(SubjectState(subjects: subjects));

  update(int index) {
    var items = state.subjects;
    for (var i = 0; i < state.subjects.length; i++) {
      if (i == index) {
        items[i].isExpanded = !items[i].isExpanded;
      } else {
        items[i].isExpanded = false;
      }
    }

    state = SubjectState(subjects: items);
  }
}

final registerForExamStatesProvider =
    ((ref) => IESSystem().registerForExamUseCase.stateNotifierProvider);

StateNotifierProvider<SubjectStateNotifier, SubjectState> subjectStateNotifier =
    StateNotifierProvider<SubjectStateNotifier, SubjectState>(((ref) =>
        SubjectStateNotifier(
            subjects: genSubjectItems(IESSystem()
                .registerForExamUseCase
                .currentState
                .currentRole
                .srSubjects))));

// Register Provider
@immutable
class Register {
  final List<bool> subjects;
  const Register({required this.subjects});
}
