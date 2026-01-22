import 'package:flutter/material.dart';

class SummarizeText extends StatelessWidget {
  final String resultText;

  const SummarizeText({super.key, required this.resultText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summary")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          resultText,
          style: const TextStyle(
            fontSize: 25,
            fontFamily: 'Jersey',
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
