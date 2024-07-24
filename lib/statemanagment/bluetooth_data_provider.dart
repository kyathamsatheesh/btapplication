import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDataProvider extends ChangeNotifier {
  BluetoothDevice? _connectedDevice;
  String _receivedData = "No data received";
  String _receivedAngle = "0";
  String _receivedHeartRate = "No data received";
  int _finalHeartRate = 0;
  BluetoothCharacteristic? _targetCharacteristic;

  BluetoothDevice? get connectedDevice => _connectedDevice;
  String get receivedData => _receivedData;
  String get receivedAngle => _receivedAngle;
  String get receivedHeartRate => _receivedHeartRate;
  int get finalHeartRate => _finalHeartRate;
  BluetoothCharacteristic? get targetCharacteristic => _targetCharacteristic;

  void setConnectedDevice(BluetoothDevice device) {
    _connectedDevice = device;
    notifyListeners();
  }

  void setCharacteristicDevice(BluetoothCharacteristic characteristic) {
    _targetCharacteristic = characteristic;
    notifyListeners();
  }

  void updateData(String data) {
    _receivedData = data;
    if (_receivedData.length > 4) {
      List<String> tbarData = _receivedData.split(',');
      int size = tbarData.length;
      if (size > 0) {
        _receivedAngle = tbarData[0];
        _receivedHeartRate = tbarData.length > 1 ? tbarData[1] : "No Heart Rate data";
        _finalHeartRate = tbarData.length > 1 ? int.parse(tbarData[1]) : 0;
      }
    }
    notifyListeners();
  }

  // Add other methods as needed for your application logic
}
