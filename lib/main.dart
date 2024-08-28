import 'package:btapplication/statemanagment/bluetooth_data_provider.dart';
import 'package:btapplication/widgets/connectivity_aware_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
//   runApp(FirestoreDataDisplay()); // Run your application
// }
  runApp(
    ChangeNotifierProvider(
      create: (context) => BluetoothDataProvider(),
      child: MyApp(),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MainScreen(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConnectivityAwareWidget(
        child: MainScreen(),
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Page')),
//       body: Center(child: Text('Welcome to the Home Page!')),
//     );
//   }
// }

//Internet connectivity testing - Start

// import 'package:btapplication/widgets/connectivity_aware_widget.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ConnectivityAwareWidget(
//         child: MyHomePage(),
//       ),
//     );
//   }
// }

//Internet connectivity testing - End

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Page')),
//       body: Center(child: Text('Welcome to the Home Page!')),
//     );
//   }
// }


// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

// import 'dart:async';
// import 'dart:developer' as developer;

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: const Color(0x9f4376f8),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

//   @override
//   void initState() {
//     super.initState();
//     initConnectivity();

//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initConnectivity() async {
//     late List<ConnectivityResult> result;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       developer.log('Couldn\'t check connectivity status', error: e);
//       return;
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return Future.value(null);
//     }

//     return _updateConnectionStatus(result);
//   }

//   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//     setState(() {
//       _connectionStatus = result;
//     });
//     // ignore: avoid_print
//     print('Connectivity changed: $_connectionStatus');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connectivity Plus Example'),
//         elevation: 4,
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Spacer(flex: 2),
//           Text(
//             'Active connection types:',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const Spacer(),
//           ListView(
//             shrinkWrap: true,
//             children: List.generate(
//                 _connectionStatus.length,
//                 (index) => Center(
//                       child: Text(
//                         _connectionStatus[index].toString(),
//                         style: Theme.of(context).textTheme.headlineSmall,
//                       ),
//                     )),
//           ),
//           const Spacer(flex: 2),
//         ],
//       ),
//     );
//   }
// }


//Firebase - Firestore configuration - this is testing code for integraion is working or not

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     addUser();
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Firestore Example')),
//         body: FirestoreData(),
//       ),
//     );
//   }
// }

// Future<void> addUser() async {
//   CollectionReference users =
//       FirebaseFirestore.instance.collection('serial_data');
//   await users.add({
//     'angle': 30.00,
//     'hearrate': 70,
//     'name': 'Satheesh',
//     'seconds': 60,
//   });
//   await users.add({
//     'angle': 30.00,
//     'hearrate': 85,
//     'name': 'Satheesh',
//     'seconds': 70,
//   });
//   await users.add({
//     'angle': 30.00,
//     'hearrate': 100,
//     'name': 'Satheesh',
//     'seconds': 100,
//   });
//   await users.add({
//     'angle': 30.00,
//     'hearrate': 95,
//     'name': 'Satheesh',
//     'seconds': 110,
//   });
//   await users.add({
//     'angle': 30.00,
//     'hearrate': 105,
//     'name': 'Satheesh',
//     'seconds': 200,
//   });
//   await users.add({
//     'angle': 30.00,
//     'hearrate': 95,
//     'name': 'Satheesh',
//     'seconds': 210,
//   });
//   await users.add({
//     'angle': 30.00,
//     'hearrate': 110,
//     'name': 'Satheesh',
//     'seconds': 300,
//   });
//   await users.add({
//     'angle': 30.00,
//     'hearrate': 100,
//     'name': 'Satheesh',
//     'seconds': 305,
//   });
// }

// class FirestoreData extends StatelessWidget {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<QuerySnapshot>(
//       future: firestore.collection('users').get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           final data = snapshot.data?.docs ?? [];
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               final doc = data[index];
//               return ListTile(
//                 title: Text(doc['name']),
//                 subtitle: Text(doc['angle']),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
