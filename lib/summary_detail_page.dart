import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'summary_item.dart';

class SummaryDetailPage extends StatelessWidget {
  final SummaryItem item;
  final String resultText;

  const SummaryDetailPage({
    super.key,
    required this.item,
    required this.resultText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(
            fontFamily: 'Jersey',
            fontSize: 50,
            color: Colors.blueGrey,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mein Text:',
              style: TextStyle(
                fontFamily: 'Jersey',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.inputText,
              style: const TextStyle(
                fontFamily: 'Jersey',
                fontSize: 25,
                color: Colors.amber,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Zusammenfassung:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Jersey',
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.summaryText,
              style: const TextStyle(
                fontFamily: 'Jersey',
                fontSize: 18,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // if (resultText.trim().isNotEmpty) {
          //   Share.share(resultText, subject: 'Meine Zusammenfassung');
          //}
          final textToShare =
              'Dein Text:\n${item.inputText}\n\nZusammenfassung:\n${item.summaryText}';

          Share.share(textToShare, subject: 'Meine Zusammenfassung');
        },
        child: const Icon(Icons.share, color: Colors.amber),
      ),
    );
  }
}
