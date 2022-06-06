import 'package:flutter/foundation.dart';

const String useCaseInitStateName = 'useCaseInitStateName';
const String useCaseOnFailureStateName = 'useCaseOnFailureStateName';

@immutable
class UseCaseState {
  final String _stateName;
  final String _displayName;

  const UseCaseState(this._stateName, this._displayName);

  String get displayName {
    return _displayName;
  }

  String get stateName {
    return _stateName;
  }

  bool onEvent(String eventName) {
    return _displayName == eventName;
  }
}
