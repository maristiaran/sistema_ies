import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// const String useCaseInitStateName = 'useCaseInitStateName';
// const String useCaseOnFailureStateName = 'useCaseOnFailureStateName';

class UseCaseNotifier<T extends OperationState> extends StateNotifier<T> {
  UseCaseNotifier(T initialState) : super(initialState);

  void notifyStateChange(T operationState) {
    state = operationState;
  }

  OperationState currentState() {
    return state;
  }
}

@immutable
class OperationState<T> {
  final T stateName;
  final String stateInfo;

  const OperationState({required this.stateName, this.stateInfo = ""});
}

class OperationStateNotifier<T> extends StateNotifier<OperationState> {
  OperationStateNotifier({required OperationState initialState})
      : super(initialState);
  changeState(OperationState newOperationState) {
    state = newOperationState;
  }
}

abstract class Operation {
  initializeStateNotifiers();
//   late OperationStateNotifier stateNotifier;
//   // final Operation parentOperation;
//   // Operation({required this.parentOperation});

//   setInitialState(OperationState initialState) {
//     stateNotifier = OperationStateNotifier(initialState: initialState);
//   }

//   changeState(OperationState useCaseState) {
//     stateNotifier.changeState(useCaseState);
//   }
}
