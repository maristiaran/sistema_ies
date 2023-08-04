// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/log.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/crud_log/presentation/widgets/listViewBuilder.dart';

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
    return listBuildLog(IESSystem().logUseCase.listaLogs);
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
    return listBuildLog(_filter);
  }
}
