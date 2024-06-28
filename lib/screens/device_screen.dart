//LAPTOP Code
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../utils/snackbar.dart';

// class DeviceScreen extends StatefulWidget {
//   final BluetoothDevice device;
//   DeviceScreen({required this.device});

//   @override
//   _DeviceScreenState createState() => _DeviceScreenState();
// }

// class _DeviceScreenState extends State<DeviceScreen> {
//   BluetoothService? targetService;
//   BluetoothCharacteristic? targetCharacteristic;
//   bool isReady = false;

//   @override
//   void initState() {
//     super.initState();
//     discoverServices();
//   }

//   // void discoverServices() async {
//   //   try {
//   //     List<BluetoothService> services = await widget.device.discoverServices();
//   //     for (BluetoothService service in services) {
//   //       if (service.uuid == Guid('YOUR_SERVICE_ID')) {
//   //         for (BluetoothCharacteristic characteristic in service.characteristics) {
//   //           if (characteristic.uuid == Guid('YOUR_CHARACTERISTIC_ID')) {
//   //             targetCharacteristic = characteristic;
//   //             setState(() {
//   //               isReady = true;
//   //             });
//   //             return;
//   //           }
//   //         }
//   //       }
//   //     }
//   //   } catch (e) {
//   //     // Handle error
//   //     print("Error discovering services: $e");
//   //   }
//   // }

//   void discoverServices() async {
//     try {
//       List<BluetoothService> services = await widget.device.discoverServices();
//       for (BluetoothService service in services) {
//         if (service.uuid == Guid('4fafc201-1fb5-459e-8fcc-c5c9c331914b')) {
//           Snackbar.show(ABC.b, "Entered into service uuid......!",
//               success: false);
//           for (BluetoothCharacteristic characteristic
//               in service.characteristics) {
//             if (characteristic.uuid ==
//                 Guid('beb5483e-36e1-4688-b7f5-ea07361b26a8')) {
//               targetCharacteristic = characteristic;
//               Snackbar.show(ABC.b, "successssss............!", success: false);
//               setState(() {
//                 isReady = true;
//               });
//               return;
//             }
//           }
//         }
//       }
//     } catch (e) {
//       // Handle error
//       print("Error discovering services: $e");
//       Snackbar.show(ABC.b, "Error discovering services:$e", success: false);
//     }
//   }

//   void sendData(String data) {
//     Snackbar.show(ABC.b, "Input Event...!$data", success: false);
//     if (targetCharacteristic != null) {
//       targetCharacteristic!.write(data.codeUnits);
//     } else {
//       print("Target characteristic is not set.");
//       Snackbar.show(ABC.b, "Target characteristic is not set. 80...!", success: false);
//     }
//   }

//   Future<void> readData() async {
//      Snackbar.show(ABC.b, "readData....method...!", success: false);
//     if (targetCharacteristic != null) {
//       var value = await targetCharacteristic!.read();
//        Snackbar.show(ABC.b, "Received Valuee....!:$value", success: false);
//       print('Received: $value');
//     } else {
//       print("Target characteristic is not set.");
//       Snackbar.show(ABC.b, "Target characteristic is not set.", success: false);
//     }
//   }

//   Future<void> manualConnect() async {
//     try {
//       await widget.device.connect();
//       setState(() {
//         isReady = true;
//       });
//     } catch (e) {
//       // Handle error
//       print("Error connecting to device: $e");
//     }
//   }

//   Future<void> disconnect() async {
//     try {
//       await widget.device.disconnect();
//       setState(() {
//         isReady = false;
//       });
//     } catch (e) {
//       print("Error disconnecting from device: $e");
//     }
//   }

//   Widget buildDataSection() {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             sendData('A');
//           },
//           child: Text('A Input'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             sendData('B');
//           },
//           child: Text('B Input'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             sendData('C20');
//           },
//           child: Text('Start'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             sendData('STOP');
//           },
//           child: Text('Stop'),
//         ),
//         ElevatedButton(
//           onPressed: readData,
//           child: Text('Read Data'),
//         ),
//       ],
//     );
//   }

//   Widget buildConnectionStatus() {
//     return Column(
//       children: [
//         Text('Connected to ${widget.device.name}'),
//         ElevatedButton(
//           onPressed: disconnect,
//           child: Text('Disconnect'),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.device.name)),
//       body: isReady
//           ? Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   buildConnectionStatus(),
//                   SizedBox(height: 20),
//                   Text('Data Section', style: Theme.of(context).textTheme.headline6),
//                   Divider(),
//                   buildDataSection(),
//                 ],
//               ),
//             )
//           : Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: manualConnect,
//                     child: Text('Manual Connect'),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../utils/snackbar.dart';

// class DeviceScreen extends StatefulWidget {
//   final BluetoothDevice device;

//   DeviceScreen({required this.device});

//   @override
//   _DeviceScreenState createState() => _DeviceScreenState();
// }

// class _DeviceScreenState extends State<DeviceScreen> {
//   BluetoothService? targetService;
//   BluetoothCharacteristic? targetCharacteristic;
//   final String serviceId = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
//   final String characteristicId = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
//   String receivedData = "";

//   @override
//   void initState() {
//     super.initState();
//     connectToDevice();
//   }

//   Future<void> connectToDevice() async {
//     try {
//       await widget.device.connect();
//       discoverServices();
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Connection Error:", e),
//           success: false);
//     }
//   }

//   Future<void> discoverServices() async {
//     try {
//       List<BluetoothService> services = await widget.device.discoverServices();
//       for (var service in services) {
//         if (service.uuid.toString() == serviceId) {
//           setState(() {
//             targetService = service;
//             targetCharacteristic = service.characteristics.firstWhere(
//               (c) => c.uuid.toString() == characteristicId,
//               orElse: () => throw Exception('Characteristic not found!'),
//             );
//           });
//           break;
//         }
//       }
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Discover Services Error:", e),
//           success: false);
//     }
//   }

//   Future<void> readData() async {
//     try {
//       var value = await targetCharacteristic?.read();
//       setState(() {
//         receivedData = value.toString();
//       });
//       print("Read value: $value");
//       Snackbar.show(ABC.b, "Read value: $value", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Read Error:", e), success: false);
//     }
//   }

//   Future<void> writeData(String data) async {
//     try {
//       await targetCharacteristic?.write(data.codeUnits, withoutResponse: true);
//       print("Written value: $data");
//       Snackbar.show(ABC.b, "Written value: $data", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
//     }
//   }

//   void sendData(String data) {
//     Snackbar.show(ABC.b, data, success: true);
//     if (targetCharacteristic != null) {
//       targetCharacteristic!.write(data.codeUnits);
//     } else {
//       print("Target characteristic is not set.");
//       Snackbar.show(ABC.b, "Target characteristic is not set.", success: false);
//     }
//   }

//   @override
//   void dispose() {
//     widget.device.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Device Screen'),
//       ),
//       body: Center(
//         child: targetCharacteristic == null
//             ? CircularProgressIndicator()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: readData,
//                     child: Text('Read Data'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => writeData('A'),
//                     child: Text('Write A'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => writeData('B'),
//                     child: Text('Write B'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       sendData('c20');
//                     },
//                     child: Text('Start'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       sendData('d');
//                     },
//                     child: Text('Stop'),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Received Data: ${receivedData ?? "No data received"}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../utils/snackbar.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class DeviceScreen extends StatefulWidget {
//   final BluetoothDevice device;

//   DeviceScreen({required this.device});

//   @override
//   _DeviceScreenState createState() => _DeviceScreenState();
// }

// class _DeviceScreenState extends State<DeviceScreen> {
//   BluetoothService? targetService;
//   BluetoothCharacteristic? targetCharacteristic;
//   final String serviceId = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
//   final String characteristicId = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
//   String receivedData = "No data received";
//   String receivedAngle = "No data received";
//   String receivedHeartRate = "No data received";

//   @override
//   void initState() {
//     super.initState();
//     connectToDevice();
//   }

//   Future<void> connectToDevice() async {
//     try {
//       await widget.device.connect();
//       discoverServices();
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Connection Error:", e),
//           success: false);
//     }
//   }

//   Future<void> discoverServices() async {
//     try {
//       List<BluetoothService> services = await widget.device.discoverServices();
//       for (var service in services) {
//         if (service.uuid.toString() == serviceId) {
//           setState(() {
//             targetService = service;
//             targetCharacteristic = service.characteristics.firstWhere(
//               (c) => c.uuid.toString() == characteristicId,
//               orElse: () => throw Exception('Characteristic not found!'),
//             );
//           });
//           // Set up notifications to listen for changes
//           await targetCharacteristic!.setNotifyValue(true);
//           targetCharacteristic!.value.listen((value) {
//             setState(() {
//               receivedData = String.fromCharCodes(value);
//                if(receivedData.length>4)
//                {
//                 // Splitting the string by comma
//                 List<String> tbarData = receivedData.split(',');

//                 // Finding the size of the list
//                 int size = tbarData.length;
//                 if(size>0)
//                 {
//                   // Outputting the results
//                   print("Original String: $receivedData");
//                   print("List after split: $tbarData");
//                   print("Size of list: $size");
//                   receivedAngle=tbarData[0];
//                   receivedHeartRate=tbarData[1];
//                 }
//                }
              
//             });
//             print("Received value: $receivedData");
//             Snackbar.show(ABC.b, "Received value: $receivedData", success: true);
//           });
//           break;
//         }
//       }
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Discover Services Error:", e),
//           success: false);
//     }
//   }

//   Future<void> readData() async {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('start reading...'),));
//     try {
//       var value = await targetCharacteristic?.read();
//       setState(() {
//         receivedData = String.fromCharCodes(value!);
//       });
//       print("Read value: $receivedData");
//       Snackbar.show(ABC.b, "Read value: $receivedData", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Read Error:", e), success: false);
//     }
//   }

//   Future<void> writeData(String data) async {
//     try {
//       await targetCharacteristic?.write(data.codeUnits, withoutResponse: true);
//       print("Written value: $data");
//       Snackbar.show(ABC.b, "Written value: $data", success: true);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Written value: $data"),backgroundColor: Colors.blue,));
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
//     }
//   }

//   void sendData(String data) {
//     Snackbar.show(ABC.b, data, success: true);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("input data..$data"),backgroundColor: Colors.blue,));
//     if (targetCharacteristic != null) {
//       targetCharacteristic!.write(data.codeUnits);
//     } else {
//       print("Target characteristic is not set.");
//       Snackbar.show(ABC.b, "Target characteristic is not set.", success: false);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Target characteristic is not set."),backgroundColor: Colors.blue,));
//     }
//   }

//   @override
//   void dispose() {
//     widget.device.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Device Screen'),
//       ),
//           body: Center(
//           child: targetCharacteristic == null
//               ? CircularProgressIndicator()
//               : GridView.count(
//                   crossAxisCount: 2, // Number of columns in the grid
//                   padding: EdgeInsets.all(16.0),
//                   mainAxisSpacing: 20.0,
//                   crossAxisSpacing: 20.0,
//                   childAspectRatio: 2.0, // Width to height ratio of grid items
//                   children: <Widget>[
//                     _buildGridItem('assets/images/download.png', 'Angle $receivedAngle'),
//                     _buildGridItem('assets/images/download.png', 'Heart Rate $receivedHeartRate'),
//                     _buildGridItem('assets/images/download.png', 'Start'),
//                     _buildGridItem('assets/images/download.png', 'Stop'),
//                     _buildGridItem('assets/images/download.png', 'Received Data: $receivedData'),
//                   ],
//                 ),
//           ),

//     );
//   }

//   Widget _buildGridItem(String? backgroundImage, String buttonText) {
//     return Container(
//       decoration: backgroundImage != null
//           ? BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(backgroundImage),
//                 fit: BoxFit.cover,
//               ),
//             )
//           : null,
//       child: ElevatedButton(
//         onPressed: () {
//           // Implement onPressed logic here
//           if (buttonText.startsWith('Angle')) {
//             readData(); // Example for Angle button
            
//           } else if (buttonText.startsWith('Heart Rate')) {
//             readData(); // Example for Heart Rate button
//           } else if (buttonText == 'Start') {
//             sendData('c20');
//           } else if (buttonText == 'Stop') {
//             sendData('d');
//           }
//         },
//         child: Text(buttonText),
//         style: ElevatedButton.styleFrom(
//           //primary: Colors.transparent, // Transparent background for the button
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../utils/snackbar.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  DeviceScreen({required this.device});

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  BluetoothService? targetService;
  BluetoothCharacteristic? targetCharacteristic;
  final String serviceId = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String characteristicId = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  String receivedData = "No data received";
  String receivedAngle = "0";
  String receivedHeartRate = "No data received";

  @override
  void initState() {
    super.initState();
    connectToDevice();
  }

  Future<void> connectToDevice() async {
    try {
      await widget.device.connect();
      discoverServices();
    } catch (e) {
      Snackbar.show(ABC.a, prettyException("Connection Error:", e), success: false);
    }
  }

  Future<void> discoverServices() async {
    try {
      List<BluetoothService> services = await widget.device.discoverServices();
      for (var service in services) {
        if (service.uuid.toString() == serviceId) {
          setState(() {
            targetService = service;
            targetCharacteristic = service.characteristics.firstWhere(
              (c) => c.uuid.toString() == characteristicId,
              orElse: () => throw Exception('Characteristic not found!'),
            );
          });
          // Set up notifications to listen for changes
          await targetCharacteristic!.setNotifyValue(true);
          targetCharacteristic!.value.listen((value) {
            setState(() {
              receivedData = String.fromCharCodes(value);
              if (receivedData.length > 4) {
                // Splitting the string by comma
                List<String> tbarData = receivedData.split(',');

                // Finding the size of the list
                int size = tbarData.length;
                if (size > 0) {
                  receivedAngle = tbarData[0];
                  receivedHeartRate = tbarData.length > 1 ? tbarData[1] : "No Heart Rate data";
                }
              }
            });
            print("Received value: $receivedData");
            Snackbar.show(ABC.a, "Received value: $receivedData", success: true);
          });
          break;
        }
      }
    } catch (e) {
      Snackbar.show(ABC.a, prettyException("Discover Services Error:", e), success: false);
    }
  }

  Future<void> readData() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reading data...')));
    try {
      var value = await targetCharacteristic?.read();
      setState(() {
        receivedData = String.fromCharCodes(value!);
        if (receivedData.length > 4) {
          // Splitting the string by comma
          List<String> tbarData = receivedData.split(',');

          // Finding the size of the list
          int size = tbarData.length;
          if (size > 0) {
            receivedAngle = tbarData[0];
            receivedHeartRate = tbarData.length > 1 ? tbarData[1] : "No Heart Rate data";
          }
        }
      });
      print("Read value: $receivedData");
      Snackbar.show(ABC.a, "Read value: $receivedData", success: true);
    } catch (e) {
      Snackbar.show(ABC.a, prettyException("Read Error:", e), success: false);
    }
  }

  Future<void> writeData(String data) async {
    try {
      await targetCharacteristic?.write(data.codeUnits, withoutResponse: true);
      print("Written value: $data");
      Snackbar.show(ABC.a, "Written value: $data", success: true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Written value: $data"), backgroundColor: Colors.blue));
    } catch (e) {
      Snackbar.show(ABC.a, prettyException("Write Error:", e), success: false);
    }
  }

  void sendData(String data) {
    Snackbar.show(ABC.a, data, success: true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sending data: $data"), backgroundColor: Colors.blue));
    if (targetCharacteristic != null) {
      targetCharacteristic!.write(data.codeUnits);
    } else {
      print("Target characteristic is not set.");
      Snackbar.show(ABC.a, "Target characteristic is not set.", success: false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Target characteristic is not set."), backgroundColor: Colors.blue));
    }
  }

  @override
  void dispose() {
    widget.device.disconnect();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Device Screen'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 500, // Adjust width as needed
            height: 500, // Adjust height as needed
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
                  majorTickStyle: MajorTickStyle(length: 6, thickness: 4, color: Colors.blue),
                  minorTickStyle: MinorTickStyle(length: 3, thickness: 3, color: Colors.green),
                  axisLabelStyle: GaugeTextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                  
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: double.parse(receivedAngle), // Convert receivedAngle to double
                      needleLength: 0.85,
                      enableAnimation: true,
                      animationType: AnimationType.easeInCirc,
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
                            SizedBox(height: 70),
                            Text('Angle $receivedAngle\u00B0', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                        colors: const<Color>[Colors.green, Colors.yellow, Colors.red],
                        stops: const<double>[0.0, 0.5, 1],
                      ),
                    ),
                  ],
                ),
              ],
              title: GaugeTitle(text: "T-Bar Angle"),
            ),
          ),
          //SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     readData();
          //   },
          //   child: Text('Read Data'),
          // ),
          //SizedBox(height: 20),
          ElevatedButton(
                style: ElevatedButton.styleFrom(
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(300, 50), //////// HERE
            ),
                onPressed: () {
                  //sendData('c20');
                },
                child: Text('Heart Rate $receivedHeartRate'),
              ),
              SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(300, 50), //////// HERE
            ),
                onPressed: () {
                  sendData('c20');
                },
                child: Text('Start'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(300, 50), //////// HERE
            ),
                onPressed: () {
                  sendData('d');
                },
                child: Text('Stop'),
              ),
            ],
          ),
          // SizedBox(height: 20),
          // Text('Received Data: $receivedData'),
        ],
      ),
    ),
  );
}

}
 