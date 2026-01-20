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
}
