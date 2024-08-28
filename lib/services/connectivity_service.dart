import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectivityController =
      StreamController<bool>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityController.add(result != ConnectivityResult.none);
    });
  }

  Stream<bool> get connectivityStream => _connectivityController.stream;

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void dispose() {
    _connectivityController.close();
  }
}
