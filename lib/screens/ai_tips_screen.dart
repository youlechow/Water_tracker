import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../services/firestore_service.dart';

class AITipsScreen extends StatefulWidget {
  const AITipsScreen({super.key});

  @override
  State<AITipsScreen> createState() => _AITipsScreenState();
}

class _AITipsScreenState extends State<AITipsScreen> {
  String tips = "Press button to generate tips";

  void generateTips() async {
    final logs = await FirestoreService().getLogs().first;
    double total =
        logs.fold(0, (sum, log) => sum + log.amount);

    final result = await AIService().getTips(total);

    setState(() => tips = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Water Tips")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(tips),
            ElevatedButton(
              onPressed: generateTips,
              child: const Text("Generate Tips"),
            )
          ],
        ),
      ),
    );
  }
}