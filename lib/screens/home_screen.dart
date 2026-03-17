import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/water_log.dart';
import 'add_log_screen.dart';
import 'stats_screen.dart';
import 'ai_tips_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  double getTodayTotal(List<WaterLog> logs) {
    final today = DateTime.now();
    return logs
        .where((log) =>
            log.date.day == today.day &&
            log.date.month == today.month &&
            log.date.year == today.year)
        .fold(0, (sum, log) => sum + log.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AquaTrack 💧")),
      body: StreamBuilder<List<WaterLog>>(
        stream: FirestoreService().getLogs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          final logs = snapshot.data!;
          final total = getTodayTotal(logs);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Today's Usage",
                  style: Theme.of(context).textTheme.titleLarge),
              Text("$total L",
                  style: const TextStyle(fontSize: 40, color: Colors.blue)),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddLogScreen()),
                ),
                child: const Text("Add Log"),
              ),

              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StatsScreen()),
                ),
                child: const Text("Statistics"),
              ),

              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AITipsScreen()),
                ),
                child: const Text("AI Tips"),
              ),
            ],
          );
        },
      ),
    );
  }
}