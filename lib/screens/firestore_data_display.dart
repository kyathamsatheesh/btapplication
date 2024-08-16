// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   runApp(FirestoreDataDisplay());
// }

// class FirestoreDataDisplay extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //addUser();
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Firestore Example')),
//         body: FirestoreData(),
//       ),
//     );
//   }
// }

// class FirestoreData extends StatelessWidget {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<QuerySnapshot>(
//       future: firestore.collection('serial_data_new').get(),
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
//                 title: Text(doc['username']),
//                 subtitle: Text(doc['angle'].toString()),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FirestoreDataDisplay());
}

class FirestoreDataDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Firestore User Wise Data')),
        body: FirestoreData(),
      ),
    );
  }
}

class FirestoreData extends StatefulWidget {
  @override
  _FirestoreDataState createState() => _FirestoreDataState();
}

class _FirestoreDataState extends State<FirestoreData> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedUsername;
  List<String> usernames = [];

  @override
  void initState() {
    super.initState();
    _fetchUsernames();
  }

  Future<void> _fetchUsernames() async {
    try {
      final snapshot = await firestore.collection('serial_data_new').get();
      final docs = snapshot.docs;
      final uniqueUsernames = <String>{};

      for (var doc in docs) {
        uniqueUsernames.add(doc['username']);
      }

      setState(() {
        usernames = uniqueUsernames.toList();
        if (usernames.isNotEmpty) {
          selectedUsername = usernames.first;
        }
      });
    } catch (e) {
      print("Error fetching usernames: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown for selecting username
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: selectedUsername,
            hint: Text('Select Username'),
            onChanged: (String? newValue) {
              setState(() {
                selectedUsername = newValue;
              });
            },
            items: usernames.map((username) {
              return DropdownMenuItem<String>(
                value: username,
                child: Text(username),
              );
            }).toList(),
          ),
        ),
        // Filtered ListView
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
            future: _fetchFilteredData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final data = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final doc = data[index];
                    return ListTile(
                      title: Text(doc['username']),
                      subtitle: Text(doc['angle'].toString()),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<QuerySnapshot> _fetchFilteredData() async {
    if (selectedUsername == null) {
      // Return an empty QuerySnapshot if no username is selected
      return FirebaseFirestore.instance
          .collection('serial_data_new')
          .limit(1)
          .get();
    } else {
      return firestore
          .collection('serial_data_new')
          .where('username', isEqualTo: selectedUsername)
          .get();
    }
  }
}
