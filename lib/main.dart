import 'package:btapplication/statemanagment/bluetooth_data_provider.dart';
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

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
