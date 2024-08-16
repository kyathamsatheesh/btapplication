// lib/data_model.dart
//import 'package:cloud_firestore/cloud_firestore.dart';

class HeartRateData {
  final double angle;
  final int heartRate;
  final DateTime timestamp;
  final int seconds;

  HeartRateData(
      {required this.angle,
      required this.heartRate,
      required this.timestamp,
      required this.seconds});
}
