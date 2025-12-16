import 'package:flutter/material.dart';

class changeColor extends StatefulWidget {
  const changeColor({super.key});

  @override
  State<changeColor> createState() => _changeColorState();
}

class _changeColorState extends State<changeColor> {
  Color buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (buttonColor == Colors.blue) {
                buttonColor = Colors.red;
                print('Button pressed');
              } else if (buttonColor == Colors.red) {
                buttonColor = Colors.green;
              } else if (buttonColor == Colors.blueGrey) {
                buttonColor = Colors.cyan;
              } else {
                buttonColor = Colors.blue;
              }
            });
          },
          child: Text('Change Color'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
        ),
      ),
    );
  }
}
