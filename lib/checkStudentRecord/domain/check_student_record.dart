import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/checkStudentRecord/utils/generate_subject_items.dart';

enum CheckStudentRecordStateName { init }

class CheckStudentRecordState extends OperationState {
  // final IESUser currentUser;
  final Student currentRole;
  const CheckStudentRecordState(
      {required Enum stateName, required this.currentRole})
      : super(stateName: stateName);
  CheckStudentRecordState copyChangingRole({required Student newUserRole}) {
    return CheckStudentRecordState(
        stateName: stateName, currentRole: newUserRole);
  }

  CheckStudentRecordState copyChangingState(
      {required CheckStudentRecordStateName newState}) {
    return CheckStudentRecordState(
        stateName: newState, currentRole: currentRole);
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
class CheckStudentRecordUseCase extends Operation<CheckStudentRecordState> {
  final IESUser currentIESUser;
  final Student studentRole;

  CheckStudentRecordUseCase(
      {required this.currentIESUser, required this.studentRole})
      : super(CheckStudentRecordState(
            stateName: CheckStudentRecordStateName.init,
            currentRole: studentRole));
}

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

class SubjectItemCard {
  SubjectSR subjectSR;
  bool isExpanded = false;
  SubjectItemCard({required this.subjectSR});
}

@immutable
class SubjectState {
  final List<SubjectItemCard> subjects;
  const SubjectState({required this.subjects});
}

class SubjectStateNotifier extends StateNotifier<SubjectState> {
  SubjectStateNotifier({required List<SubjectItemCard> subjects})
      : super(SubjectState(subjects: subjects));

  update(int index) {
    var items = state.subjects;
    for (var i = 0; i < state.subjects.length; i++) {
      if (i == index) {
        items[i].isExpanded = true;
      } else {
        items[i].isExpanded = false;
      }
    }

    state = SubjectState(subjects: items);
  }
}

final checkStudentRecordStatesProvider =
    ((ref) => IESSystem().checkStudentRecordUseCase.stateNotifierProvider);

StateNotifierProvider<SubjectStateNotifier, SubjectState> subjectStateNotifier =
    StateNotifierProvider<SubjectStateNotifier, SubjectState>(((ref) =>
        SubjectStateNotifier(
            subjects: generateSubjectItems(IESSystem()
                .checkStudentRecordUseCase
                .currentState
                .currentRole
                .srSubjects))));
