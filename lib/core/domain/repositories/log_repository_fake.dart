import 'package:sistema_ies/core/domain/entities/log.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';

abstract class LogRepositoyFakePort extends RepositoryPort {
  Future<List<Log>> getAllLogsAsync();
  List<Log> getAllLogs();
  createLogs(Log log);
}
