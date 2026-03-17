import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  final model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: 'API-KEY',
  );

  Future<String> getTips(double usage) async {
    final prompt = """
                    User used $usage litres of water today.
                    Give 3 short practical water saving tips.
                    """;

    final response = await model.generateContent([
      Content.text(prompt),
    ]);

    return response.text ?? "No tips";
  }
}