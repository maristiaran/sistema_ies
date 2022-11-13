import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';

class StudentRecordDetailsPage extends StatelessWidget {
  const StudentRecordDetailsPage({Key? key, required this.studentRecord})
      : super(key: key);
  final StudentRecord studentRecord;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [Text(studentRecord.name)],
      ),
    );
  }
}
