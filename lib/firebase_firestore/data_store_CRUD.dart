import 'package:cloud_firestore/cloud_firestore.dart';

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
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   await users.add({
//     'angle': '30.00',
//     'hearrate': 90,
//     'name': 'XXDSFDGJFGFJGDSGFDGF',
//   });
// }

class DataStoreCrud {
  Future<void> addUserSerialData(
      double angle, int heartRate, String name, int seconds) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('serial_data_new');
      // Print values being sent to Firestore
      print('Adding data to Firestore: '
          'angle: $angle, heartRate: $heartRate, name: $name, seconds: $seconds');

      await users.add({
        'angle': angle,
        'hearrate': heartRate,
        'username': name,
        'insertedon':
            FieldValue.serverTimestamp(), // Add current server timestamp
        'seconds': seconds,
        'cycle_unq_id': '1234',
        'max_angle_on_cycle': '',
      });
      print('Data added successfully!');
    } catch (e) {
      print('Error inserting data: ${e.toString()}');
    }
  }
}

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
