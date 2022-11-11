import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

enum Careers { Redes, Software }

class StudentRecordPage extends ConsumerWidget {
  StudentRecordPage({Key? key}) : super(key: key);
  final StateProvider<List<bool>> isOpen =
      StateProvider((ref) => <bool>[true, false, true]);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<bool> isExpanded = ref.watch(isOpen);
    final _currentStudentRecordState =
        ref.watch(IESSystem().studentRecordUseCase.stateNotifierProvider);
    final onSelectedItem = StateProvider((ref) => "One");

    const _studentRecords = <String>['One', 'Two', 'Three', 'Four'];
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            dropDownButtonStudentRecord(_studentRecords, onSelectedItem, ref),
            const ExpansionTile(
              title: Text("null"),
              children: [Text("data")],
            ),
          ],
        ),
      ),
    );
  }
}

Widget dropDownButtonStudentRecord(list, dropdownValue, ref) {
  return DropdownButton<String>(
    value: ref.watch(dropdownValue),
    icon: const Icon(Icons.arrow_downward),
    elevation: 16,
    style: const TextStyle(color: Colors.deepPurple),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: (String? value) {
      ref.read(dropdownValue.notifier).state = value;
      print(ref.watch(dropdownValue));
    },
    items: list.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}
