// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// import 'device_screen.dart';
// import '../utils/snackbar.dart';
// import '../widgets/system_device_tile.dart';
// import '../widgets/scan_result_tile.dart';
// import '../utils/extra.dart';

// class ScanScreen extends StatefulWidget {
//   const ScanScreen({Key? key}) : super(key: key);

//   @override
//   State<ScanScreen> createState() => _ScanScreenState();
// }

// class _ScanScreenState extends State<ScanScreen> {
//   List<BluetoothDevice> _systemDevices = [];
//   List<ScanResult> _scanResults = [];
//   bool _isScanning = false;
//   late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
//   late StreamSubscription<bool> _isScanningSubscription;

//   @override
//   void initState() {
//     super.initState();

//     _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
//       _scanResults = results;
//       if (mounted) {
//         setState(() {});
//       }
//     }, onError: (e) {
//       Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
//     });

//     _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
//       _isScanning = state;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scanResultsSubscription.cancel();
//     _isScanningSubscription.cancel();
//     super.dispose();
//   }

//   Future onScanPressed() async {
//     try {
//       _systemDevices = await FlutterBluePlus.systemDevices;
//     } catch (e) {
//       Snackbar.show(ABC.b, prettyException("System Devices Error:", e), success: false);
//     }
//     try {
//       await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
//     } catch (e) {
//       Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   Future onStopPressed() async {
//     try {
//       FlutterBluePlus.stopScan();
//     } catch (e) {
//       Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e), success: false);
//     }
//   }

//   void onConnectPressed(BluetoothDevice device) {
//     device.connectAndUpdateStream().catchError((e) {
//       Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
//     });
//     MaterialPageRoute route = MaterialPageRoute(
//         builder: (context) => DeviceScreen(device: device), settings: RouteSettings(name: '/DeviceScreen'));
//     Navigator.of(context).push(route);
//   }

//   Future onRefresh() {
//     if (_isScanning == false) {
//       FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
//     }
//     if (mounted) {
//       setState(() {});
//     }
//     return Future.delayed(Duration(milliseconds: 500));
//   }

//   Widget buildScanButton(BuildContext context) {
//     if (FlutterBluePlus.isScanningNow) {
//       return FloatingActionButton(
//         child: const Icon(Icons.stop),
//         onPressed: onStopPressed,
//         backgroundColor: Colors.red,
//       );
//     } else {
//       return FloatingActionButton(child: const Text("SCAN"), onPressed: onScanPressed);
//     }
//   }

//   List<Widget> _buildSystemDeviceTiles(BuildContext context) {
//     return _systemDevices
//         .map(
//           (d) => SystemDeviceTile(
//             device: d,
//             onOpen: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => DeviceScreen(device: d),
//                 settings: RouteSettings(name: '/DeviceScreen'),
//               ),
//             ),
//             onConnect: () => onConnectPressed(d),
//           ),
//         )
//         .toList();
//   }

//   List<Widget> _buildScanResultTiles(BuildContext context) {
//     return _scanResults
//         .map(
//           (r) => ScanResultTile(
//             result: r,
//             onTap: () => onConnectPressed(r.device),
//           ),
//         )
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldMessenger(
//       key: Snackbar.snackBarKeyB,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Find Devices'),
//         ),
//         body: RefreshIndicator(
//           onRefresh: onRefresh,
//           child: ListView(
//             children: <Widget>[
//               ..._buildSystemDeviceTiles(context),
//               ..._buildScanResultTiles(context),
//             ],
//           ),
//         ),
//         floatingActionButton: buildScanButton(context),
//       ),
//     );
//   }
// }

//LAPTOP Code
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'device_screen.dart';
// import '../utils/snackbar.dart';
// import '../widgets/system_device_tile.dart';
// import '../widgets/scan_result_tile.dart';
// import '../utils/extra.dart';

// class ScanScreen extends StatefulWidget {
//   const ScanScreen({Key? key}) : super(key: key);

//   @override
//   State<ScanScreen> createState() => _ScanScreenState();
// }

// class _ScanScreenState extends State<ScanScreen> {
//   List<BluetoothDevice> _systemDevices = [];
//   List<ScanResult> _scanResults = [];
//   bool _isScanning = false;
//   late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
//   late StreamSubscription<bool> _isScanningSubscription;

//   @override
//   void initState() {
//     super.initState();

//     _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
//       _scanResults = results;
//       if (mounted) {
//         setState(() {});
//       }
//     }, onError: (e) {
//       Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
//     });

//     _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
//       _isScanning = state;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scanResultsSubscription.cancel();
//     _isScanningSubscription.cancel();
//     super.dispose();
//   }

//   Future onScanPressed() async {
//     try {
//       _systemDevices = await FlutterBluePlus.systemDevices;
//     } catch (e) {
//       Snackbar.show(ABC.b, prettyException("System Devices Error:", e), success: false);
//     }
//     try {
//       await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
//     } catch (e) {
//       Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("BLE IoT App")),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: _scanResults.length,
//               itemBuilder: (context, index) {
//                 return ScanResultTile(
//                   result: _scanResults[index],
//                   onTap: () async {
//                     await _scanResults[index].device.connect();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DeviceScreen(device: _scanResults[index].device),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _isScanning ? null : onScanPressed,
//         child: Icon(_isScanning ? Icons.stop : Icons.search),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'device_screen.dart';
import '../utils/snackbar.dart';
import '../widgets/system_device_tile.dart';
import '../widgets/scan_result_tile.dart';
import '../utils/extra.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    int counter=0; 
    int counterForMain=0; 
    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
    
    for (var result in results) {
      
          // if (result.device.name == "ESP32_BLE") {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("We are found ESP32_BLE Device name"),backgroundColor: Colors.blueGrey,));
          //   break;
          // }
          //  break;
          
        if (result.device.name == "ESP32_BLE") {
            counterForMain++;
            counter++;
            if(counter==1)
            {
              print("device Name:-$result.device.name");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("We are found with ESP32_BLE Device name"),backgroundColor: Colors.blueGrey,));
               _connectToDevice(result.device);
               break;
            }
            else
              print("More than same device found");  
          }
          
        }
      //  if(counterForMain==0)
      //     {
      //       print("device Name:-");
      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("We are not found ESP32_BLE Device name"),backgroundColor: Colors.blueGrey,));
            
      //     }
        
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Scan Error::$e"),backgroundColor: Colors.red,));
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  // Method to start scanning for devices
  Future<void> _startScan() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Start Scan Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  // Method to connect to a specific Bluetooth device
  void _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      // Navigate to device screen after successful connection
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeviceScreen(device: device),
        ),
      );
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connect Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  Future onScanPressed() async {
    Snackbar.show(ABC.b, prettyException("Start Scan Error:", "Errorrr"), success: false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Scanning Started...'),backgroundColor: Colors.blue,));
    try {
      _systemDevices = await FlutterBluePlus.systemDevices;
      print("_systemDevices :------$_systemDevices");
    } catch (e) {
      print("error 215 $e");
      Snackbar.show(ABC.b, prettyException("System Devices Error:", e),
          success: false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("System Devices Error:$e"),backgroundColor: Colors.red,));
    }
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    } catch (e) {
      print("error 222 $e");
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e),
          success: false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("System Devices Error:$e"),backgroundColor: Colors.red,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BLE IoT App")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _scanResults.length,
              itemBuilder: (context, index) {
                return ScanResultTile(
                  result: _scanResults[index],
                  onTap: () async {
                    await _scanResults[index].device.connect();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DeviceScreen(device: _scanResults[index].device),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _isScanning ? null : onScanPressed,
      //   child: Icon(_isScanning ? Icons.stop : Icons.search),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isScanning ? null : _startScan,
        child: Icon(_isScanning ? Icons.stop : Icons.search),
      ),
    );
  }
}
