import 'package:calculator/widgets/display.dart';
import 'package:calculator/widgets/keys.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.

          ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String displayText = '';

class _MyHomePageState extends State<MyHomePage> {
  final numKeys = [
    'C',
    '%',
    'CA',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  String displayOnScreen = '';
  String exp = '';
  void updateDisplay(String clickedValue) {
    switch (clickedValue) {
      case 'CA':
        displayOnScreen = '';
        exp = '';
        break;
      case 'C':
        if (displayOnScreen != '' && exp != '') {
          displayOnScreen = displayText.substring(0, displayText.length - 1);
          exp = displayText.substring(0, displayText.length - 1);
        }
        break;
      case 'x':
        displayOnScreen += 'x';
        exp += '*';
        break;
      case '%':
        displayOnScreen =
            'Currently % function not available\nPress CA to continue';
        // exp += '*';
        break;
      case '=':
        // displayOnScreen = (eval(displayText) as int).toString();
        // print(eval(exp).round());
        // print(exp);
        if (exp == '') {
          return;
        }

        try {
          Parser p = Parser();
          Expression expr = p.parse(exp);
          ContextModel cm = ContextModel();
          double eval = expr.evaluate(EvaluationType.REAL, cm);
          if (eval.round() == eval) {
            displayOnScreen = eval.round().toString();
          } else {
            displayOnScreen = eval.toString();
          }
        } catch (e) {
          displayOnScreen = 'Error';
          print(e);
        }

        exp = displayOnScreen;
        break;

      default:
        if (displayOnScreen == 'Error') {
          displayOnScreen = '';
          exp = '';
        }
        displayOnScreen += clickedValue;
        exp += clickedValue;
    }
    setState(() {
      displayText = displayOnScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double topH = MediaQuery.of(context).padding.top;
    final double bottomH = MediaQuery.of(context).padding.bottom;

    final deviceSizeHeight =
        MediaQuery.of(context).size.height - topH - bottomH;
    final deviceSizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Container(
        // color: Theme.of(context).accentColor,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     // color: Theme.of(context).dividerColor,
              //     width: 2,
              //   ),
              // ),
              child: Display(displayText),
            ),

            //
            Container(height: 1, color: Theme.of(context).dividerColor),

            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.red,
              //     width: 2,
              //   ),
              // ),
              alignment: Alignment.bottomCenter,
              // height: deviceSize.height * 0.62,
              height: deviceSizeHeight * 0.55,
              child: GridView.count(
                // childAspectRatio: deviceSizeHeight*0.55 > deviceSizeWidth ? deviceSizeHeight*0.55 / deviceSizeWidth : deviceSizeWidth / deviceSizeHeight*0.55,
                childAspectRatio: deviceSizeWidth /
                    (deviceSizeHeight * 0.55 - deviceSizeHeight * 0.55 * 0.25),
                crossAxisCount: 4,
                // mainAxisSpacing: 18,
                // crossAxisSpacing: 18,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  numKeys.length,
                  (index) {
                    return Keys(
                      value: numKeys[index],
                      displayUpdate: updateDisplay,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
