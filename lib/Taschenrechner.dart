import 'package:flutter/material.dart';

class CAlculator extends StatefulWidget {
  const CAlculator({super.key});

  @override
  State<CAlculator> createState() => _CAlculatorState();
}

class _CAlculatorState extends State<CAlculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        foregroundColor: Colors.blueGrey,
        backgroundColor: Colors.yellowAccent,
      ),
      body: Textfields(),
      backgroundColor: const Color.fromARGB(255, 196, 117, 44),
    );
  }
}

class Textfields extends StatelessWidget {
  const Textfields({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 200,
          left: 30,
          right: 150,
          bottom: 150,
          child: Container(
            width: 100,
            height: 110,

            child: TextField(
              decoration: InputDecoration(
                hintText: 'Etwas eingeben',
                border: OutlineInputBorder(),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                contentPadding: EdgeInsets.all(5),
              ),
            ),
          ),
        ),
        Positioned(
          top: 330,
          left: 30,
          right: 150,
          bottom: 110,
          child: Container(
            width: 100,
            height: 110,

            child: TextField(
              decoration: InputDecoration(
                hintText: 'Etwas eingeben',
                border: OutlineInputBorder(),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                contentPadding: EdgeInsets.all(5),
              ),
            ),
          ),
        ),
        Positioned(
          top: 230,
          left: 270,

          width: 100,
          height: 100,

          child: ElevatedButton(onPressed: () {}, child: Text('Answer')),
        ),
      ],
    );
  }
}
