import 'package:flutter/material.dart';
import '../models/water_log.dart';
import '../services/firestore_service.dart';

class AddLogScreen extends StatefulWidget {
  const AddLogScreen({super.key});

  @override
  State<AddLogScreen> createState() => _AddLogScreenState();
}

class _AddLogScreenState extends State<AddLogScreen> {
  final controller = TextEditingController();
  String category = "shower";

  void save() async {
    final log = WaterLog(
      amount: double.parse(controller.text),
      category: category,
      date: DateTime.now(),
    );

    await FirestoreService().addLog(log);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Water Log")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Litres"),
            ),
            DropdownButton(
              value: category,
              items: ["shower", "drink", "laundry"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => category = val!),
            ),
            ElevatedButton(onPressed: save, child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}