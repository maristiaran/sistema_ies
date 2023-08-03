import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/log.dart';
import 'package:sistema_ies/core/domain/repositories/log_repository_fake.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class LogRepositoryFakeAdapter implements LogRepositoyFakePort {
  List<Log>? _cacheLogs;

  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    buildLogFromJson(Map<String, dynamic> json) {
      List<Log> newLogs = [];
      for (Map<String, dynamic> logJson in json['logs']) {
        Log newLog = Log(
            datetime: logJson['datetime'],
            actionUsername: logJson['actionUsername'],
            modifiedUserDNI: logJson['modifiedUserDNI'],
            rol: logJson['rol'],
            modifiedUsername: logJson['modifiedUsername'],
            description: logJson['description']);
        newLogs.add(newLog);
      }
      return newLogs;
    }

    List<Log> buildLog() {
      Map<String, dynamic> newJson = {
        'logs': [
          {
            'datetime': DateTime(2023, 8, 5, 17, 30),
            'actionUsername': "Mónica",
            'modifiedUserDNI': 11111,
            'rol': "Administrativo",
            'modifiedUsername': "Pedro",
            'description': "Se elimino el rol de Pedro"
          },
          {
            'datetime': DateTime(2023, 8, 5, 17, 30),
            'actionUsername': "Mónica",
            'modifiedUserDNI': 11111,
            'rol': "Administrativo",
            'modifiedUsername': "Brian",
            'description': "Se actualizo el nombre de usuario"
          },
          {
            'datetime': DateTime(2023, 7, 5, 17, 30),
            'actionUsername': "Mónica",
            'modifiedUserDNI': 43509910,
            'rol': "Administrativo",
            'modifiedUsername': "Mauro",
            'description': "Se elimino el usuario de Mauro"
          },
          {
            'datetime': DateTime(2023, 8, 4, 17, 30),
            'actionUsername': "Mónica",
            'modifiedUserDNI': 0,
            'rol': "Administrativo",
            'modifiedUsername': "",
            'description': "Se agrego la asinatura de Ingles"
          },
          {
            'datetime': DateTime(2022, 8, 3, 17, 30),
            'actionUsername': "Mónica",
            'modifiedUserDNI': 0,
            'rol': "Administrativo",
            'modifiedUsername': "",
            'description':
                "Se actualizo la asignatura deTecnico Superio de Desarrollo de Software "
          },
          {
            'datetime': DateTime(2022, 9, 7, 17, 30),
            'actionUsername': "Mónica",
            'modifiedUserDNI': 0,
            'rol': "Administrativo",
            'modifiedUsername': "",
            'description':
                "Se elimino la asignatura de Tecnicatura Superior en Computación y Redes"
          },
        ]
      };
      return buildLogFromJson(newJson);
    }

    if (_cacheLogs == null) {
      _cacheLogs = [];
      _cacheLogs = buildLog();
    }

    return Right(Success("OK"));
  }

  @override
  Future<List<Log>> getAllLogsAsync() async {
    await Future.delayed(const Duration(seconds: 2));
    return _cacheLogs ?? [];
  }

  @override
  List<Log> getAllLogs() {
    return _cacheLogs ?? [];
  }

  @override
  createLogs(Log log) {
    // ignore: avoid_print
    print(
        "${log.datetime}\n${log.actionUsername}\n${log.modifiedUserDNI},\n${log.modifiedUsername},\n${log.rol},\n${log.description}");
  }
}
