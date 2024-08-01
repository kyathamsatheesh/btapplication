import 'package:btapplication/commonscreen/homescreen.dart';
import 'package:btapplication/screens/device_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:btapplication/db.sqlite/database_helper.dart';
import 'package:btapplication/statemanagment/bluetooth_data_provider.dart';
import 'package:btapplication/utils/snackbar.dart';

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

class _UserCreationScreenState extends State<UserCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  double userWeight = 0.0;
  double userAngle = 0.0;
  List<Map<String, dynamic>> _items = [];

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Declare TextEditingController instances
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _angleController = TextEditingController();


  @override
  void initState() {
    super.initState();    
    _loadItems();
  }

  @override
  void dispose() {
    // Dispose TextEditingController instances
    _nameController.dispose();
    _weightController.dispose();
    _angleController.dispose();
    super.dispose();
  }

  void _loadItems() async {
    List<Map<String, dynamic>> items = await _databaseHelper.getItems();
    setState(() {
      _items = items;
    });
    print(" Total $_items");
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _databaseHelper.insertItem({
        'name': userName,
        'weight': userWeight,
        'angle': _angleController.text,
      });
      _loadItems();
      _resetFields();
    }
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
    // Clear TextEditingController values
    _nameController.clear();
    _weightController.clear();
    _angleController.clear();
  }

  void sendData(String data) {
    Snackbar.show(ABC.a, data, success: true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Sending data: $data"),
      backgroundColor: Colors.blue,
    ));
    if (targetCharacteristic != null) {
      targetCharacteristic!.write(data.codeUnits);
    } else {
      print("Target characteristic is not set.");
      Snackbar.show(ABC.a, "Target characteristic is not set.", success: false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Target characteristic is not set."),
        backgroundColor: Colors.blue,
      ));
    }
  }

  BluetoothCharacteristic? targetCharacteristic;
  BluetoothDevice _connectedDevice = BluetoothDevice(remoteId: DeviceIdentifier("DAD"));
  @override
  Widget build(BuildContext context) {
    final bluetoothDataProvider = Provider.of<BluetoothDataProvider>(context);
    String receivedAngle = bluetoothDataProvider.receivedAngle;
    targetCharacteristic = bluetoothDataProvider.targetCharacteristic;
    _connectedDevice = bluetoothDataProvider.testDevice;
    
    String startBtn = 'Start to read the data';
    String angleLbl = 'Angle';
    String hintTxtAngle = 'Enter Angle';
    String nameLbl = 'Name';
    String hintTxtName = 'Enter your name';
    String weightLbl = 'Weight';
    String hintTxtweight = 'Enter your weight';
    String saveBtn = 'Save';
    String updateBtn = 'Update';
    String cancelBtn = 'Cancel';
    String updateUserLbl = 'Update User Screen';
    _angleController.text = bluetoothDataProvider.receivedAngle.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create User $receivedAngle'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 500,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 35,
                      labelOffset: 5,
                      startAngle: 180,
                      endAngle: 0,
                      axisLineStyle: AxisLineStyle(
                        thicknessUnit: GaugeSizeUnit.factor,
                        thickness: 0.03,
                      ),
                      majorTickStyle: MajorTickStyle(
                          length: 6, thickness: 4, color: Colors.blue),
                      minorTickStyle: MinorTickStyle(
                          length: 3, thickness: 3, color: Colors.green),
                      axisLabelStyle: GaugeTextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: double.parse(receivedAngle),
                          needleLength: 0.85,
                          enableAnimation: true,
                          animationType: AnimationType.linear,
                          needleStartWidth: 1.5,
                          needleEndWidth: 6,
                          needleColor: Colors.red,
                          knobStyle: KnobStyle(knobRadius: 0.09),
                        ),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 90),
                                Text('$receivedAngle\u00B0',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          angle: 90,
                          positionFactor: 0.75,
                        ),
                      ],
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: 200,
                          sizeUnit: GaugeSizeUnit.factor,
                          startWidth: 0.03,
                          endWidth: 0.03,
                          gradient: SweepGradient(
                            colors: const <Color>[
                              Colors.green,
                              Colors.yellow,
                              Colors.red
                            ],
                            stops: const <double>[0.0, 0.5, 1],
                          ),
                        ),
                      ],
                    ),
                  ],
                  title: GaugeTitle(
                    text: angleLbl,
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    minimumSize: Size(300, 50),
                  ),
                  onPressed: () {
                    sendData('c');
                  },
                  child: Text(startBtn),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController, // Assign TextEditingController
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: nameLbl,
                          hintText: hintTxtName,
                        ),
                        onChanged: (value) {
                          setState(() {
                            userName = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                         controller: _weightController, // Assign TextEditingController
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}$')),
                        ],
                         validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a weight';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: weightLbl,
                          hintText: hintTxtweight,
                        ),
                        onChanged: (value) {
                          setState(() {
                            userWeight = double.tryParse(value) ?? 0;
                          });
                        },
                        //controller: TextEditingController(text: userWeight.toString()),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _angleController, // Assign TextEditingController
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                         validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a angle';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: angleLbl,
                          hintText: hintTxtAngle,
                        ),
                        onChanged: (value) {
                          setState(() {
                            userAngle = double.tryParse(_angleController.text) ?? 0.0;
                          });
                        },
                        //controller: TextEditingController(text: receivedAngle.toString()),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _saveUser,
                        child: Text(saveBtn),
                      ),
                      SizedBox(height: 16.0),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: _items.length,
                      //     itemBuilder: (context, index) {
                      //       // Declare TextEditingController instances for each field
                      //       TextEditingController nameController = TextEditingController();
                      //       TextEditingController weightController = TextEditingController();
                      //       TextEditingController angleController = TextEditingController();
                      //       nameController.text = _items[index]['name'];
                      //       weightController.text = _items[index]['weight'].toString();
                      //       angleController.text = _items[index]['angle'].toString();
                      //       double storedAngle = _items[index]['angle'];
                      //       // angleController.text =  _angleController.text;
                      //       return ListTile(
                      //         title: Text(_items[index]['name']),
                      //         subtitle:
                      //             Text('Weight: ${_items[index]['weight']}, Angle: ${_items[index]['angle']}'),
                      //         trailing: Row(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             IconButton(
                      //               icon: Icon(Icons.edit),
                      //               onPressed: () {
                      //                 // Get the latest receivedAngle from the Provider
                      //                    String dialogAngle = Provider.of<BluetoothDataProvider>(context, listen: true).receivedAngle;
                      //                   //  String dialogAngle = Provider.of<BluetoothDataProvider>(context).receivedAngle;
                      //                 print("sdfajfgdvasfgdsfhsgdfsdahfkjsdfhkjsdhfkjsdhf$dialogAngle");
                      //                 showDialog(
                      //                       context: context,
                      //                       builder: (context) => AlertDialog(
                      //                         // title: Text(updateUserLbl),
                      //                         title: Text(receivedAngle),
                      //                         content: Column(
                      //                           mainAxisSize: MainAxisSize.min,
                      //                           children: [
                      //                             TextFormField(
                      //                               controller: nameController,
                      //                               decoration: InputDecoration(
                      //                                 labelText: nameLbl,
                      //                                 hintText: hintTxtName,
                      //                               ),
                      //                             ),
                      //                             SizedBox(height: 16.0),
                      //                             TextFormField(
                      //                               keyboardType: TextInputType.numberWithOptions(decimal: true),
                      //                               decoration: InputDecoration(
                      //                                 labelText: weightLbl,
                      //                                 hintText: hintTxtweight,
                      //                               ),
                      //                               controller: weightController,
                      //                             ),
                      //                             SizedBox(height: 16.0),
                      //                             TextFormField(
                      //                               keyboardType: TextInputType.numberWithOptions(decimal: true),
                      //                               decoration: InputDecoration(
                      //                                 labelText: angleLbl,
                      //                                 hintText: hintTxtAngle,
                      //                               ),
                      //                               controller: angleController,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                         actions: [
                      //                           TextButton(
                      //                             onPressed: () {
                      //                               Navigator.pop(context);
                      //                             },
                      //                             child: Text(cancelBtn),
                      //                           ),
                      //                           ElevatedButton(
                      //                             onPressed: () {
                      //                               _updateUser(
                      //                                 _items[index]['id'],
                      //                                 nameController.text,
                      //                                 double.tryParse(weightController.text) ?? 0.0,
                      //                                 double.tryParse(angleController.text) ?? 0.0,
                      //                               );
                      //                               Navigator.pop(context);
                      //                             },
                      //                             child: Text(updateBtn),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     );

                      //               },
                      //             ),
                      //             IconButton(
                      //               icon: Icon(Icons.delete),
                      //               onPressed: () =>
                      //                   _deleteItem(_items[index]['id']),
                      //             ),
                      //             IconButton(
                      //               icon: Icon(Icons.forward),
                      //               onPressed: () =>
                      //                   Navigator.push(context,MaterialPageRoute(builder: (context) =>  DeviceScreen(device: _connectedDevice,angleFromUserScreen: storedAngle),),)
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      Expanded(
  child: ListView.builder(
    itemCount: _items.length,
    itemBuilder: (context, index) {
      TextEditingController nameController = TextEditingController();
      TextEditingController weightController = TextEditingController();
      TextEditingController angleController = TextEditingController();

      nameController.text = _items[index]['name'];
      weightController.text = _items[index]['weight'].toString();
      angleController.text = _items[index]['angle'].toString();
      double storedAngle = _items[index]['angle'];

      return ListTile(
        title: Text(_items[index]['name']),
        subtitle: Text('Weight: ${_items[index]['weight']}, Angle: ${_items[index]['angle']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<BluetoothDataProvider>(
                      builder: (context, bluetoothDataProvider, child) {
                        String dialogAngle = bluetoothDataProvider.receivedAngle;
                        angleController.text = dialogAngle;
                        return AlertDialog(
                          title: Text(updateUserLbl),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: nameLbl,
                                  hintText: hintTxtName,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  labelText: weightLbl,
                                  hintText: hintTxtweight,
                                ),
                                controller: weightController,
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  labelText: angleLbl,
                                  hintText: hintTxtAngle,
                                ),
                                controller: angleController,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(cancelBtn),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _updateUser(
                                  _items[index]['id'],
                                  nameController.text,
                                  double.tryParse(weightController.text) ?? 0.0,
                                  double.tryParse(angleController.text) ?? 0.0,
                                );
                                Navigator.pop(context);
                              },
                              child: Text(updateBtn),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteItem(_items[index]['id']),
            ),
            IconButton(
              icon: Icon(Icons.forward),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceScreen(
                    device: _connectedDevice,
                    angleFromUserScreen: storedAngle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
)

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
