import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/water_log.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> addLog(WaterLog log) async {
    await _db.collection('logs').add(log.toMap());
  }

  Stream<List<WaterLog>> getLogs() {
    return _db
        .collection('logs')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => WaterLog.fromMap(doc.data())).toList());
  }
}