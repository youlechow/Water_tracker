import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../widgets/water_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistics")),
      body: StreamBuilder(
        stream: FirestoreService().getLogs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return WaterChart(logs: snapshot.data!);
        },
      ),
    );
  }
}