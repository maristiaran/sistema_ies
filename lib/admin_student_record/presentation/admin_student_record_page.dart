import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class AdminStudentRecordPage extends StatelessWidget {
  const AdminStudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              IESSystem().onUserLogged(IESSystem().homeUseCase.currentIESUser),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
      ),
      body: const Text('Text'),
    );
  }
}
// TODO: I have to choose how it will to works