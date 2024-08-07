import 'package:btapplication/statemanagment/bluetooth_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainScreen.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp();
  runApp(ChangeNotifierProvider(create: (context) => BluetoothDataProvider(),
  child: MyApp(),
  ),
  );
}
// Future<void> addUser() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   await users.add({
//     'angle': '22.00',
//     'hearrate': 88,
//     'name': 'Satheesh K',
//   });
// }

// Stream<QuerySnapshot> getUsers() {
//   Firebase.initializeApp();
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   return users.snapshots();
// }


class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp( home: MainScreen(),);
    
  }
}
// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: getUsers(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         if (snapshot.hasData) {
//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               return ListTile(
//                 title: Text(document['name']),
//                 subtitle: Text(document['hearrate']),
//               );
//             }).toList(),
//           );
//         }
//         return Text('No data found');
//       },
//     );
//   }
// }