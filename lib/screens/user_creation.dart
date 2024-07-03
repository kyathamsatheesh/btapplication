// import 'package:btapplication/db.sqlite/database_helper.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(UserCreationApp());
// }

// class UserCreationApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'User Creation',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: UserCreationScreen(),
//     );
//   }
// }

// class UserCreationScreen extends StatefulWidget {
//   @override
//   _UserCreationScreenState createState() => _UserCreationScreenState();
// }
// List<Map<String, dynamic>> _items = [];
// class _UserCreationScreenState extends State<UserCreationScreen> {
//   String userName = '';
//   double userWeight = 0.0;

//   void _saveUser() async{
//     // Example of saving user data (printing for demonstration)
//     print('User Name: $userName');
//     print('User Weight: $userWeight');
//     //final DatabaseHelper dbHelper = DatabaseHelper();
//     await DatabaseHelper().insertItem({'name': '$userName', 'angle': '$userWeight'});
//    _items=  await DatabaseHelper().getItems();
//     print('User Weight123: $_items');
//   }

// void _loadUser() async{
//    _items=  await DatabaseHelper().getItems();
//     print('User Weight123: $_items');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create User'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Name',
//                 hintText: 'Enter your name',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   userName = value;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//               decoration: InputDecoration(
//                 labelText: 'Weight',
//                 hintText: 'Enter your weight',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   userWeight = double.tryParse(value) ?? 0.0;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//               decoration: InputDecoration(
//                 labelText: 'Angle',
//                 hintText: 'Enter Angle',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   userWeight = double.tryParse(value) ?? 0.0;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _saveUser,
//               child: Text('Save'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _loadUser,
//               child: Text('Load'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:btapplication/db.sqlite/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(UserCreationApp());
}

class UserCreationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Creation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserCreationScreen(),
    );
  }
}

class UserCreationScreen extends StatefulWidget {
  @override
  _UserCreationScreenState createState() => _UserCreationScreenState();
}
// List<Map<String, dynamic>> _items = [];

class _UserCreationScreenState extends State<UserCreationScreen> {
  String userName = '';
  double userWeight = 0.0;
  double userAngle = 0.0;
  List<Map<String, dynamic>> _items = [];

  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    List<Map<String, dynamic>> items = await _databaseHelper.getItems();
    setState(() {
      _items = items;
    });
    print(" Total $_items");
  }

  void _saveUser() async {
    await _databaseHelper.insertItem({
      'name': userName,
      'weight': userWeight,
      'angle': userAngle,
    });
    _loadItems();
    _resetFields();
  }
   void _deleteItem(int id) async {
    await _databaseHelper.deleteItem(id);
    _loadItems();
  }

  void _updateUser(int id, String newName, double newWeight, double newAngle) async {
    await _databaseHelper.updateItem({
      'id': id,
      'name': newName,
      'weight': newWeight,
      'angle': newAngle,
    });
    _loadItems();
  }

  void _resetFields() {
    setState(() {
      userName = '';
      userWeight = 0.0;
      userAngle = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                 if (value == null || value.isEmpty) {
                    print("&*&*&*&&&&");
                    return 'Please enter some text';
                  }
                  else
                  {
                      print("&*&*&*&");
                      return "*********************************";
                  }
                  return "*********************************";
                },
              decoration: InputDecoration(
                labelText: 'Name1',
                hintText: 'Enter your name',
              ),
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
              controller: TextEditingController(text: userName),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
              decoration: InputDecoration(
                labelText: 'Weight',
                hintText: 'Enter your weight',
              ),
              onChanged: (value) {
                setState(() {
                  userWeight = double.tryParse(value) ?? 0;
                  // userWeight = value;
                });
              },
              controller: TextEditingController(text: userWeight.toStringAsFixed(2)),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Angle',
                hintText: 'Enter Angle',
              ),
              onChanged: (value) {
                setState(() {
                  userAngle = double.tryParse(value) ?? 0.0;
                });
              },
              controller: TextEditingController(text: userAngle.toString()),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveUser,
              child: Text('Save'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _loadItems,
              child: Text('Load'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]['name']),
                    subtitle: Text('Weight: ${_items[index]['weight']}, Angle: ${_items[index]['angle']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Implement update functionality here
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Update User'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    hintText: 'Enter your name',
                                  ),
                                  controller: TextEditingController(text: _items[index]['name']),
                                  onChanged: (value) {
                                    setState(() {
                                      _items[index]['name'] = value;
                                    });
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  decoration: InputDecoration(
                                    labelText: 'Weight',
                                    hintText: 'Enter your weight',
                                  ),
                                  controller: TextEditingController(text: _items[index]['weight'].toString()),
                                  onChanged: (value) {
                                    setState(() {
                                      _items[index]['weight'] = double.tryParse(value) ?? 0.0;
                                    });
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  decoration: InputDecoration(
                                    labelText: 'Angle',
                                    hintText: 'Enter Angle',
                                  ),
                                  controller: TextEditingController(text: _items[index]['angle'].toString()),
                                  onChanged: (value) {
                                    setState(() {
                                      _items[index]['angle'] = double.tryParse(value) ?? 0.0;
                                    });
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _updateUser(
                                    _items[index]['id'],
                                    _items[index]['name'],
                                    _items[index]['weight'],
                                    _items[index]['angle'],
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text('Update'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteItem(_items[index]['id']),
                ),
              ],


                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
