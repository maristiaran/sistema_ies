import 'package:flutter/material.dart';

class CenterCircleProgressBar extends StatelessWidget {
  const CenterCircleProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
