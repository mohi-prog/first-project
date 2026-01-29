import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          if (resultText.trim().isNotEmpty) {
            Share.share(resultText, subject: 'Meine Zusammenfassung');
          }
        },
        child: const Icon(Icons.share, color: Colors.amber),
      ),
    );
  }
}
