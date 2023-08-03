import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/log.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/crud_log/presentation/searchLogs.dart';

class LogsPage extends ConsumerWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
/*     final logStateProvider =
        ref.watch(IESSystem().logUseCase.stateNotifierProvider); */
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
      body: ListView.builder(
        itemCount: IESSystem().logUseCase.listaLogs.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1.5, 3, 1.5, 3),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 950),
                width: MediaQuery.of(context).size.width / 0.5,
                height: 150.0,
                color: const Color.fromARGB(255, 196, 196, 196),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 80),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 3, 0.0, 0.0),
                                  child: Text(
                                    'Descripción: ${IESSystem().logUseCase.listaLogs[index].description}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (IESSystem()
                                    .logUseCase
                                    .listaLogs[index]
                                    .modifiedUserDNI !=
                                0) ...[
                              Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 35),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(3, 0, 0.0, 3),
                                    child: InkWell(
                                      child: Text(
                                        'De: ${IESSystem().logUseCase.listaLogs[index].modifiedUsername}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.blue),
                                      ),
                                      onTap: () {
                                        // ignore: avoid_print
                                        print(
                                            'DNI: ${IESSystem().logUseCase.listaLogs[index].modifiedUserDNI}');
                                      },
                                    )),
                              ),
                            ],
                            Container(
                              constraints: const BoxConstraints(maxHeight: 35),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3, 0, 0.0, 3),
                                child: Text(
                                  'Modificado por: ${IESSystem().logUseCase.listaLogs[index].actionUsername}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 150),
                        width: MediaQuery.of(context).size.width / 0.5,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 10.0, 10.0, 0),
                              child: Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "FECHA: " +
                                    IESSystem()
                                        .logUseCase
                                        .listaLogs[index]
                                        .datetime
                                        .toString(),
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
