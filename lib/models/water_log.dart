import 'package:cloud_firestore/cloud_firestore.dart';

class WaterLog {
  final double amount;
  final String category;
  final DateTime date;

  WaterLog({
    required this.amount,
    required this.category,
    required this.date,
  });

  factory WaterLog.fromMap(Map<String, dynamic> data) {
    return WaterLog(
      amount: (data['amount'] as num).toDouble(),
      category: data['category'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'date': Timestamp.fromDate(date),
    };
  }
}