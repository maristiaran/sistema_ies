import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

import '../../../core/domain/utils/datetime.dart';

class DetailsStudentRecordCard extends StatelessWidget {
  final MovementStudentRecord movementStudentRecord;
  const DetailsStudentRecordCard(this.movementStudentRecord, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(-4, 4),
          spreadRadius: -2,
          blurRadius: 4,
          color: Color.fromRGBO(0, 0, 0, 0.1),
        )
      ]),
      width: MediaQuery.of(context).size.width / 3,
      child: ExpansionTile(
          collapsedBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Text(movementStudentRecord.movementName.name.toString()),
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 120.0,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 207, 221, 240)),
                child: Text(dateToString(movementStudentRecord.date)))
          ]),
    ));
  }
}
// const Color.fromARGB(255, 207, 221, 240)