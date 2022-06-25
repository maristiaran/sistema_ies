import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class OperationState<N> {
  final N stateName;
  final Operation operation;

  const OperationState({required this.stateName, required this.operation});
}

class OperationStateNotifier<S> extends StateNotifier<S> {
  OperationStateNotifier({required S initialState}) : super(initialState);
  notifyStateChange(S newOperationState) {
    state = newOperationState;
  }
}

abstract class Operation<S, N> {
  late S currentState;
  late OperationStateNotifier<S> stateNotifier;
  late StateNotifierProvider<OperationStateNotifier<S>, S>
      stateNotifierProvider;

  changeState(S newOperationState) {
    currentState = newOperationState;
    stateNotifier.notifyStateChange(newOperationState);
  }

  notifyCurrentState() {
    stateNotifier.notifyStateChange(currentState);
  }
}

abstract class UseCase<S, N> extends Operation<S, N> {
  final Operation parentOperation;
  UseCase({required this.parentOperation});
  initializeUseCase();
}
