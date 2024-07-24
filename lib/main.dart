//LAPTOP Code

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'screens/bluetooth_off_screen.dart';
// import 'screens/scan_screen.dart';

// void main() {
//   FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
//   runApp(const FlutterBlueApp());
// }

// class FlutterBlueApp extends StatefulWidget {
//   const FlutterBlueApp({Key? key}) : super(key: key);

//   @override
//   State<FlutterBlueApp> createState() => _FlutterBlueAppState();
// }

// class _FlutterBlueAppState extends State<FlutterBlueApp> {
//   BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

//   late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
//       _adapterState = state;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _adapterStateStateSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget screen = _adapterState == BluetoothAdapterState.on
//         ? const ScanScreen()
//         : BluetoothOffScreen(adapterState: _adapterState);

//     return MaterialApp(
//       color: Colors.lightBlue,
//       home: screen,
//       navigatorObservers: [BluetoothAdapterStateObserver()],
//     );
//   }
// }

// class BluetoothAdapterStateObserver extends NavigatorObserver {
//   StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//     if (route.settings.name == '/DeviceScreen') {
//       _adapterStateSubscription ??= FlutterBluePlus.adapterState.listen((state) {
//         if (state != BluetoothAdapterState.on) {
//           navigator?.pop();
//         }
//       });
//     }
//   }

//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//     _adapterStateSubscription?.cancel();
//     _adapterStateSubscription = null;
//   }
// }


// import 'package:flutter/material.dart';
// import 'MainScreen.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'Device App',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: MainScreen(),
//   ));
// }

// import 'package:flutter/material.dart';
// import 'MainScreen.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'Device App',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: MainScreen(),
//   ));
// }


import 'package:btapplication/statemanagment/bluetooth_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainScreen.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => BluetoothDataProvider(),
  child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp( home: MainScreen(),);
    
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'screens/bluetooth_off_screen.dart';
// import 'screens/scan_screen.dart';

// void main() {
//   FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
//   runApp(const FlutterBlueApp());
// }

// class FlutterBlueApp extends StatefulWidget {
//   const FlutterBlueApp({Key? key}) : super(key: key);

//   @override
//   State<FlutterBlueApp> createState() => _FlutterBlueAppState();
// }

// class _FlutterBlueAppState extends State<FlutterBlueApp> {
//   BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

//   late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _adapterStateStateSubscription =
//         FlutterBluePlus.adapterState.listen((state) {
//       _adapterState = state;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _adapterStateStateSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget screen = _adapterState == BluetoothAdapterState.on
//         ? const ScanScreen()
//         : BluetoothOffScreen(adapterState: _adapterState);

//     return MaterialApp(
//       color: Colors.lightBlue,
//       home: screen,
//       navigatorObservers: [BluetoothAdapterStateObserver()],
//     );
//   }
// }

// class BluetoothAdapterStateObserver extends NavigatorObserver {
//   StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//     if (route.settings.name == '/DeviceScreen') {
//       _adapterStateSubscription ??=
//           FlutterBluePlus.adapterState.listen((state) {
//         if (state != BluetoothAdapterState.on) {
//           navigator?.pop();
//         }
//       });
//     }
//   }

//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//     _adapterStateSubscription?.cancel();
//     _adapterStateSubscription = null;
//   }
// }
