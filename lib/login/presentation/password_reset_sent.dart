import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

Widget passwordResetSent(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/core/assets/images/ok_tick.png"))),
        ),
        Container(
          constraints: const BoxConstraints(maxHeight: 100, maxWidth: 300),
          width: MediaQuery.of(context).size.width / 0.5,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 36, 110, 221),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextButton(
            onPressed: () {
              IESSystem().restartLogin();
            },
            child: const Text(
              'Aceptar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    ),
  );
}
