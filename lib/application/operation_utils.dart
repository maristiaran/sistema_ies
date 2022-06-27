import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class OperationState {
  final Enum stateName;
  final Map<String, dynamic>? changes;

  const OperationState({required this.stateName, this.changes});

  OperationState copyWith({Map<String, dynamic>? changesData}) =>
      OperationState(stateName: stateName, changes: changesData);
}

class OperationStateNotifier extends StateNotifier<OperationState> {
  OperationStateNotifier({required OperationState initialState})
      : super(initialState);

  notifyStateChange(OperationState newOperationState) {
    state = newOperationState;
  }
}

abstract class Operation {
  late OperationState currentState;
  late OperationStateNotifier stateNotifier;
  late StateNotifierProvider<OperationStateNotifier, OperationState>
      stateNotifierProvider;

  changeState(OperationState newOperationState) {
    currentState = newOperationState;
    stateNotifier.notifyStateChange(newOperationState);
  }

  notifyStateChanges({Map<String, dynamic>? changes}) {
    stateNotifier
        .notifyStateChange(currentState.copyWith(changesData: changes));
  }
}

abstract class UseCase extends Operation {
  final Operation parentOperation;
  UseCase({required this.parentOperation});

  Future<void> initializeUseCase() async {
    await initializeRepositories();
    initializeStateNotifierProvider(initialState());
  }

  Future<void> initializeRepositories() async {}
  OperationState initialState();

  initializeStateNotifierProvider(OperationState initialState) {
    OperationStateNotifier newStateNotifier =
        OperationStateNotifier(initialState: initialState);
    stateNotifierProvider =
        StateNotifierProvider<OperationStateNotifier, OperationState>((ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
  }
}
