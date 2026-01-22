import 'package:flutter/material.dart';
import 'package:learnconnectmyself/Summarize_Text.dart';
import 'ai_service.dart';

class Summarizer extends StatefulWidget {
  const Summarizer({super.key});

  @override
  State<Summarizer> createState() => _SummarizerState();
}

class _SummarizerState extends State<Summarizer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 255, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 255, 252),
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: 15,
              left: 270,
              width: 130,
              height: 130,
              child: Image.asset('assets/images/Logo.png'),
            ),
            const Positioned(
              top: 60,
              left: 80,
              child: Text(
                'Summarizer',
                style: TextStyle(
                  fontFamily: 'Jersey',
                  fontSize: 40,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Summarize(),
    );
  }
}

class Summarize extends StatefulWidget {
  const Summarize({super.key});

  @override
  State<Summarize> createState() => _SummarizeState();
}

class _SummarizeState extends State<Summarize> {
  final _controller = TextEditingController();
  final AiService _aiService = AiService();
  bool isLoading = false;

  @override
  void dispose() {
    _controller.dispose(); // ← WICHTIG: Memory Leak vermeiden
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Expanded(
            child: Container(
              height: 400,
              child: TextField(
                controller: _controller,

                // ← DIESE ZWEI ZEILEN SIND DER FIX!
                maxLines: null, // ← Erlaubt unbegrenzte Zeilen (NICHT 0!)
                expands: true, // ← Füllt die Container-Höhe

                textAlignVertical: TextAlignVertical.top,

                decoration: InputDecoration(
                  hintText: 'Text eingeben...', // ← Hilfreich
                  filled: true, // ← Hintergrund
                  fillColor: Colors.white, // ← Weiß
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 4, color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 4, color: Colors.blue),
                  ),
                  contentPadding: const EdgeInsets.all(16), // ← Innenabstand
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.only(top: 100, left: 200),
          child: SizedBox(
            height: 150,
            width: 150,
            child: Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,

                  shape: CircleBorder(
                    side: BorderSide(color: Colors.blue, width: 5),
                  ),
                  padding: EdgeInsets.all(0),
                ),

                onPressed: () async {
                  setState(() => isLoading = true);

                  final result = await _aiService.summarizeText(
                    _controller.text,
                  );

                  setState(() => isLoading = false);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SummarizeText(resultText: result),
                    ),
                  );
                },

                child: Padding(
                  padding: EdgeInsetsGeometry.only(left: 3),
                  child: Icon(Icons.send, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
