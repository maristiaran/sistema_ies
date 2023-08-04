import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/log.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/crud_log/presentation/searchLogs.dart';
import 'package:sistema_ies/crud_log/presentation/widgets/listViewBuilder.dart';

class LogsPage extends ConsumerWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaLogss = IESSystem().logUseCase.listaLogs;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'LOGS',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          leading: IconButton(
            tooltip: 'Retroceder',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              IESSystem().onReturningToHome();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchLogsDelegate(ref),
                    );
                  },
                  icon: const Icon(Icons.search)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: IconButton(
                  onPressed: () {
                    IESSystem()
                        .logUseCase
                        .addLogWithModifiedUsernameAndModifiedUserDNISpecificChange(
                          LogsActions.deleteUserRol,
                          "Juan",
                          4355,
                          "Estudiante",
                        );
                    IESSystem()
                        .logUseCase
                        .addLogWithModifiedUsernameAndModifiedUserDNISpecificChange(
                            LogsActions.updateUser, "Pedro", 4355, "Nombre");
                    IESSystem()
                        .logUseCase
                        .addLogWithModifiedUsernameAndModifiedUserDNISpecificChange(
                            LogsActions.deleteUser, "Pedro", 43509910, "Pedro");
                    IESSystem().logUseCase.addLogsWithSpecificChange(
                          LogsActions.deleteSubject,
                          "Tecnicatura Superior en Computación y Redes",
                        );
                    IESSystem().logUseCase.addLogsWithSpecificChange(
                        LogsActions.updateSubject,
                        "Tecnico Superio de Desarrollo de Software");
                    IESSystem().logUseCase.addLogsWithSpecificChange(
                          LogsActions.addSubject,
                          "Ingles",
                        );
                  },
                  icon: const Icon(Icons.warning)),
            )
          ],
          centerTitle: true,
        ),
        body: listBuildLog(listaLogss));
  }
}
