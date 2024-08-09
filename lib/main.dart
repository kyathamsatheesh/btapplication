import 'package:btapplication/statemanagment/bluetooth_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainScreen.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

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
//       addUser();
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Firestore Example')),
//         body: FirestoreData(),
//       ),
//     );
//   }
// }

// Future<void> addUser() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   await users.add({
//     'angle': '15.00',
//     'hearrate': 90,
//     'name': 'KKKKKK K',
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