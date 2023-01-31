import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

Widget actionSuccessPage(context) {
  const bannerProfileImage = AssetImage("lib/core/assets/images/tick.jpg");
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: bannerProfileImage,
            ),
          ),
          width: 220,
          height: 220,
        ),
        const SizedBox(
          height: 50,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            "Se ha recuperado la contraseña.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          height: 50,
          width: 300,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 36, 110, 221),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextButton(
            onPressed: () {
              IESSystem().loginUseCase.returnToLogin();
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
