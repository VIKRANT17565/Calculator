import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  final String displayText; // = "display screen";

  const Display(this.displayText, {super.key});

  void test() {
    print(displayText);
  }

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  //
  String displayOnScreen = '';
  void updateDisplay() {
    setState(() {
      displayOnScreen += widget.displayText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double topH = MediaQuery.of(context).padding.top;
    final double bottomH = MediaQuery.of(context).padding.bottom;

    final deviceSizeHeight = MediaQuery.of(context).size.height - topH - bottomH;
    final deviceSizeWidth = MediaQuery.of(context).size.width;

    return Container(
      height: deviceSizeHeight * 0.35, //150,
      width: double.infinity,
      // color: Theme.of(context).accentColor,
      alignment: Alignment.bottomRight,
      child: Text(
        widget.displayText,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 37),
      ),
    );
  }
}
