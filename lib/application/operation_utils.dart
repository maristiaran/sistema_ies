import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class OperationState<N> {
  final N stateName;
  final Map<String, dynamic>? changes;

  const OperationState({required this.stateName, this.changes});

  OperationState<N> copyWith({Map<String, dynamic>? changes}) =>
      OperationState(stateName: stateName, changes: changes);
}

class OperationStateNotifier<S> extends StateNotifier<OperationState<S>> {
  OperationStateNotifier({required OperationState<S> initialState})
      : super(initialState);

  notifyStateChange(OperationState<S> newOperationState) {
    state = newOperationState;
  }
}

abstract class Operation<S> {
  late OperationState<S> currentState;
  late OperationStateNotifier<S> stateNotifier;
  late StateNotifierProvider<OperationStateNotifier<S>, OperationState<S>>
      stateNotifierProvider;

  changeState(OperationState<S> newOperationState) {
    currentState = newOperationState;
    stateNotifier.notifyStateChange(newOperationState);
  }

  notifyStateChanges({Map<String, dynamic>? changes}) {
    // stateNotifier.notifyStateChange(currentState.copyWith(changes: changes));
  }
}

abstract class UseCase<S> extends Operation<S> {
  final Operation parentOperation;
  UseCase({required this.parentOperation});

  Future<void> initializeUseCase() async {
    await initializeRepositories();
    initializeStateNotifierProvider(initialState());
  }

  Future<void> initializeRepositories() async {}
  OperationState<S> initialState();

  initializeStateNotifierProvider(OperationState<S> initialState) {
    OperationStateNotifier<S> newStateNotifier =
        OperationStateNotifier<S>(initialState: initialState);
    stateNotifierProvider =
        StateNotifierProvider<OperationStateNotifier<S>, OperationState<S>>(
            (ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
  }
}
