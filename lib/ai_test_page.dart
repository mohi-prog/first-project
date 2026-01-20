import 'package:flutter/material.dart';
import 'ai_service.dart';

class AiTest extends StatefulWidget {
  const AiTest({super.key});

  @override
  State<AiTest> createState() => _AiTestState();
}

class _AiTestState extends State<AiTest> {
  final AiService _aiService = AiService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, String>> messages = [];
  bool isLoading = false;

  Future<void> send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || isLoading) return;

    setState(() {
      messages.add({"role": "user", "text": text});
      isLoading = true;
    });

    _controller.clear();
    scrollDown();

    try {
      final reply = await _aiService.sendMessage(text);

      setState(() {
        messages.add({"role": "ai", "text": reply});
        isLoading = false;
      });

      scrollDown();
    } catch (e) {
      setState(() => isLoading = false);
      print("Fehler beim AI Service: $e");
    }
  }

  void scrollDown() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("AI Chat"),
        backgroundColor: Colors.black45,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // CHAT LIST
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, i) {
                  final msg = messages[i];
                  final isUser = msg["role"] == "user";
                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(maxWidth: 280),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.blue
                            : const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg["text"]!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),

            // INPUT BAR
            Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom + 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Schreib etwas...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: isLoading ? null : send,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 22, 162, 57),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
