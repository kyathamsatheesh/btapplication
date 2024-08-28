import 'package:btapplication/services/connectivity_service.dart';
import 'package:flutter/material.dart';

class ConnectivityAwareWidget extends StatefulWidget {
  final Widget child;

  ConnectivityAwareWidget({required this.child});

  @override
  _ConnectivityAwareWidgetState createState() =>
      _ConnectivityAwareWidgetState();
}

class _ConnectivityAwareWidgetState extends State<ConnectivityAwareWidget> {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _connectivityService.connectivityStream.listen((connected) {
      if (!connected) {
        _showNoInternetPage();
      } else {
        if (!mounted) return;
        setState(() {
          _isConnected = true;
        });
      }
    });
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    final connected = await _connectivityService.isConnected;
    if (!connected) {
      _showNoInternetPage();
    }
  }

  void _showNoInternetPage() {
    if (mounted) {
      setState(() {
        _isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      return Scaffold(
        appBar: AppBar(title: Text('No Internet')),
        body: Center(
            child: Text('No internet connection. Please check your settings.')),
      );
    }
    return widget.child;
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }
}
