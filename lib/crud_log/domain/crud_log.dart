import 'package:sistema_ies/core/domain/entities/log.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/log_repository_fake.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum LogStateName { init, loading, failure }

class LogState extends OperationState {
  const LogState({required stateName}) : super(stateName: stateName);
  LogState copyChaingState({required LogStateName newState}) {
    return LogState(stateName: newState);
  }

  getLogs() {
    List<Log> listLog = IESSystem().getLogsRepository().getAllLogs();
    return listLog;
  }
}

// LOG CASOS DE USO
class LogUseCase extends Operation<LogState> {
  List<Log> listaLogs = [];
  final IESUser currentIESUser;

  LogUseCase({required this.currentIESUser})
      : super(const LogState(stateName: LogStateName.failure));

  getLogsAsync() async {
    changeState(currentState.copyChaingState(newState: LogStateName.loading));
    LogRepositoyFakePort listaLogss = IESSystem().getLogsRepository();
    listaLogs = await listaLogss.getAllLogsAsync();
    if (listaLogs.isNotEmpty) {
      changeState(currentState.copyChaingState(newState: LogStateName.init));
    } else {
      changeState(currentState.copyChaingState(newState: LogStateName.failure));
    }
    return listaLogss;
  }

  // agregar log con usuario modificado y cambio especifico ej de espefico: rol eliminado
  addLogWithModifiedUsernameAndModifiedUserDNISpecificChange(
      LogsActions logsActions,
      modifiedUsername,
      modifiedUserDNI,
      String specificChange) {
    final UserRole currentRole = currentIESUser.getDefaultRole();

    String titleRol = IESSystem()
        .getRolesAndOperationsRepository()
        .getUserRoleType(currentRole.userRoleTypeName())
        .title;
    final dateTime = DateTime.now();
    switch (logsActions) {
      case LogsActions.deleteUserRol:
        IESSystem().getLogsRepository().createLogs(Log(
            datetime: dateTime,
            actionUsername: currentIESUser.firstname,
            modifiedUserDNI: modifiedUserDNI,
            rol: titleRol,
            modifiedUsername: modifiedUsername,
            description: "Se elimino el rol de $specificChange"));
        break;
      case LogsActions.updateUser:
        IESSystem().getLogsRepository().createLogs(Log(
            datetime: dateTime,
            actionUsername: currentIESUser.firstname,
            modifiedUserDNI: modifiedUserDNI,
            rol: titleRol,
            modifiedUsername: modifiedUsername,
            description: "Se actualizo el $specificChange de usuario"));
        break;
      case LogsActions.deleteUser:
        IESSystem().getLogsRepository().createLogs(Log(
            datetime: dateTime,
            actionUsername: currentIESUser.firstname,
            modifiedUserDNI: modifiedUserDNI,
            rol: titleRol,
            modifiedUsername: modifiedUsername,
            description: "Se elimino el usuario de $specificChange"));
        break;

      default:
    }
  }

  addLogsWithSpecificChange(LogsActions logsActions, String specificChange) {
    final UserRole currentRole = currentIESUser.getDefaultRole();
    String titleRol = IESSystem()
        .getRolesAndOperationsRepository()
        .getUserRoleType(currentRole.userRoleTypeName())
        .title;
    final dateTime = DateTime.now();
    switch (logsActions) {
      case LogsActions.addSubject:
        IESSystem().getLogsRepository().createLogs(Log(
            datetime: dateTime,
            actionUsername: currentIESUser.firstname,
            modifiedUserDNI: 0,
            rol: titleRol,
            modifiedUsername: "",
            description: "Se agrego la asinatura de $specificChange"));
        break;
      case LogsActions.updateSubject:
        IESSystem().getLogsRepository().createLogs(Log(
            datetime: dateTime,
            actionUsername: currentIESUser.firstname,
            modifiedUserDNI: 0,
            rol: titleRol,
            modifiedUsername: "",
            description: "Se actualizo la asignatura de $specificChange"));
        break;
      case LogsActions.deleteSubject:
        IESSystem().getLogsRepository().createLogs(Log(
            datetime: dateTime,
            actionUsername: currentIESUser.firstname,
            modifiedUserDNI: 0,
            rol: titleRol,
            modifiedUsername: "",
            description: "Se elimino la asignatura de $specificChange"));
        break;
      default:
    }
  }
}
