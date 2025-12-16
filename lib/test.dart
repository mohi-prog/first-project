import 'package:flutter/material.dart';

class MiniCalc extends StatefulWidget {
  @override
  State<MiniCalc> createState() => _MiniCalcState();
}

class _MiniCalcState extends State<MiniCalc> {
  final num1 = TextEditingController();
  final num2 = TextEditingController();
  String result = "";

  void calc() {
    final a = double.tryParse(num1.text);
    final b = double.tryParse(num2.text);

    if (a == null || b == null) {
      setState(() => result = "Eingabe fehlerhaft");
      return;
    }

    setState(() => result = "Ergebnis: ${a + b}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mini Rechner")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: num1,
              decoration: InputDecoration(labelText: "Zahl 1"),
            ),
            TextField(
              controller: num2,
              decoration: InputDecoration(labelText: "Zahl 2"),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: calc, child: Text("Addieren")),

            SizedBox(height: 20),

            Text(result, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
