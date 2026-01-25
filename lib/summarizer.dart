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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 255, 252),
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: 0,
              left: 270,
              width: 130,
              height: 130,
              child: Image.asset('assets/images/Logo.png'),
            ),
            const Positioned(
              top: 45,
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: 400,
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Text eingeben...',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 4, color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 4, color: Colors.blue),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          SizedBox(
            height: 120,
            width: 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: const CircleBorder(
                  side: BorderSide(color: Colors.blue, width: 5),
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () async {
                      if (_controller.text.trim().isEmpty ||
                          _controller.text.length < 5) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: Colors.amber,
                            title: const Text(
                              'Fehler',
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Jersey',
                                fontSize: 30,
                              ),
                            ),
                            content: const Text(
                              'Bitte geben Sie einen Text ein oder einen Text mit mindestens 5 Wörtern ein.',
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Jersey',
                                fontSize: 25,
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.white,
                                  ),
                                  shape: MaterialStateProperty.all(
                                    CircleBorder(
                                      side: BorderSide(
                                        color: Colors.blue,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),

                                child: const Text(
                                  'OK',

                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'Jersey',
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.amber,
                          content: Text(
                            'Zusammenfassung erstellt!',
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Jersey',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.send, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
