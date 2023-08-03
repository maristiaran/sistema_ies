// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/log.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class SearchLogsDelegate extends SearchDelegate<Log> {
  SearchLogsDelegate(this.ref);
  WidgetRef ref;
  // ignore: unused_field
  List<Log> _filter = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _filter.length,
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
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              constraints: const BoxConstraints(maxHeight: 80),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3, 3, 0.0, 0.0),
                                child: Text(
                                  'Descripción: ${_filter[index].description}',
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
                              constraints: const BoxConstraints(maxHeight: 35),
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
                                ),
                              ),
                            ),
                          ],
                          Container(
                            constraints: const BoxConstraints(maxHeight: 35),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0.0, 3),
                              child: Text(
                                'Modificado por: ${_filter[index].actionUsername}',
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
                              "FECHA: " + _filter[index].datetime.toString(),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final logStateProvider =
        ref.watch(IESSystem().logUseCase.stateNotifierProvider);
    List<Log> logs = logStateProvider.getLogs();
    // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    _filter = logs.where((Log) {
      return Log.datetime
          .toString()
          .toLowerCase()
          .contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: _filter.length,
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
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              constraints: const BoxConstraints(maxHeight: 80),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3, 3, 0.0, 0.0),
                                child: Text(
                                  'Descripción: ${_filter[index].description}',
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
                              constraints: const BoxConstraints(maxHeight: 35),
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
                                ),
                              ),
                            ),
                          ],
                          Container(
                            constraints: const BoxConstraints(maxHeight: 35),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0.0, 3),
                              child: Text(
                                'Modificado por: ${_filter[index].actionUsername}',
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
                              "FECHA: " + _filter[index].datetime.toString(),
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
    );
  }
}
