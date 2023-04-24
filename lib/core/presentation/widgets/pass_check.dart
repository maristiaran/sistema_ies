import 'package:flutter/material.dart';

class PassCheck extends StatelessWidget {
  final bool toVerifyElement;
  final String tag;
  const PassCheck(
    this.toVerifyElement,
    this.tag, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: toVerifyElement
                ? Theme.of(context).colorScheme.outline
                : Colors.transparent,
            border: toVerifyElement
                ? Border.all(color: Colors.transparent)
                : Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(tag)
      ],
    );
  }
}
