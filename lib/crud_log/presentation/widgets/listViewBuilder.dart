// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

listBuildLog(listaLogs) {
  return ListView.builder(
    itemCount: listaLogs.length,
    itemBuilder: (BuildContext context, int index) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
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
                                'Descripción: ${listaLogs[index].description}',
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
                                child: Row(
                                  children: [
                                    const Text("Usuario Modificado: "),
                                    InkWell(
                                      child: Text(
                                        // ignore: unnecessary_string_interpolations
                                        '${listaLogs[index].modifiedUsername}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.blue),
                                      ),
                                      onTap: () {
                                        // ignore: avoid_print
                                        print(
                                            'DNI: ${listaLogs[index].modifiedUserDNI}');
                                      },
                                    ),
                                  ],
                                )),
                          ),
                        ],
                        Container(
                          constraints: const BoxConstraints(maxHeight: 35),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 0.0, 3),
                            child: Text(
                              'Modificado por: ${listaLogs[index].actionUsername}(${listaLogs[index].rol})',
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
                          padding: const EdgeInsets.fromLTRB(0, 10.0, 10.0, 0),
                          child: Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            "Fecha y hora: " +
                                listaLogs[index].datetime.toString(),
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
