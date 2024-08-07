import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDataProvider extends ChangeNotifier {
  BluetoothDevice? _connectedDevice;
  BluetoothDevice _testDevice = BluetoothDevice(remoteId: DeviceIdentifier("sadas"));
  String _receivedData = "No data received";
  String _receivedAngle = "0";
  String _receivedHeartRate = "No data received";
  int _finalHeartRate = 0;
  BluetoothCharacteristic? _targetCharacteristic;
  List<double> _angleData = [];// List to store angle data
  double _maxAngle = 0.0;

  BluetoothDevice? get connectedDevice => _connectedDevice;
  BluetoothDevice get testDevice => _testDevice;
  String get receivedData => _receivedData;
  String get receivedAngle => _receivedAngle;
  String get receivedHeartRate => _receivedHeartRate;
  int get finalHeartRate => _finalHeartRate;
  BluetoothCharacteristic? get targetCharacteristic => _targetCharacteristic;
  List<double> get angleData => _angleData;

  void setConnectedDevice(BluetoothDevice device) {
    _connectedDevice = device;
    notifyListeners();
  }

  void setConnectedtESTDevice(BluetoothDevice device) {
    _testDevice = device;
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
        _angleData.add(double.tryParse(tbarData[0]) ?? 0.0);
      }
    }
    notifyListeners();
  }

  void refreshMaxAngle()
  {
    _maxAngle = 0.0;
    _angleData = [];
    notifyListeners();
  }
  double get maxAngle => _angleData.isNotEmpty ? _angleData.reduce((a, b) => a > b ? a : b) : 0.0;
  // Add other methods as needed for your application logic
}
