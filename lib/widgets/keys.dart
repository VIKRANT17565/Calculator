import 'package:calculator/widgets/display.dart';
import 'package:flutter/material.dart';

class Keys extends StatelessWidget {
  final String value;
  final Function displayUpdate;

  const Keys(
      {super.key,
      required this.value,
      required this.displayUpdate});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return TextButton(
      onPressed: () {
        //Action here
        displayUpdate(value);
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
