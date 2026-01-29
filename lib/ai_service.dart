import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  final _apiKey = dotenv.env['GEMINI_KEY'];

  Future<String> sendMessage(String message) async {
    if (_apiKey == null) {
      throw Exception('GEMINI_KEY not found in .env');
    }

    final model = GenerativeModel(
      model: 'gemini-2.5-flash', // Schnelles Modell
      apiKey: _apiKey,
    );

    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);

      return response.text ?? 'No response from AI';
    } catch (e) {
      print('❌ Gemini Error: $e');
      throw Exception('Failed to get AI response: $e');
    }
  }

  Future<String> summarizeText(String text) async {
    final prompt =
        '''
Fasse den folgenden Text kurz, einfach und max. 50 Wörtern zusammen, also deine Antwort soll sehr gut zusammengefasst sein und mach die Länge, wenn der Nutzer etwas dazu sagt, passend zu seiner Anforderung, wenn nichts gesagt wird fasse es so zusammen, wie es zu diesem Text/Textart passt und dann punkt und mach es in einer einfachen Sprache so b1-b2 niveau:

$text
''';

    return await sendMessage(prompt);
  }
}
