// lib/data_service.dart
import 'package:btapplication/model/data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  Future<List<HeartRateData>> fetchHeartRateData() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('serial_data_new');

    try {
      QuerySnapshot snapshot =
          await collection.orderBy('seconds', descending: true).get();

      return snapshot.docs.map((doc) {
        return HeartRateData(
          angle: doc['angle'],
          heartRate: doc['hearrate'],
          timestamp: (doc['insertedon'] as Timestamp).toDate(),
          // timestamp: '2024-02-12',
          seconds: doc['seconds'],
          // seconds: (doc['seconds']),
        );
      }).toList();
    } catch (e) {
      print('Error fetching data: $e'); // Log any error
      return []; // Return empty list on error
    }
  }
}
