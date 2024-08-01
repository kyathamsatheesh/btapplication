// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
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
//   String receivedData = "No data received";
//   String receivedAngle = "0";
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
//       Snackbar.show(ABC.a, prettyException("Connection Error:", e), success: false);
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
//               if (receivedData.length > 4) {
//                 // Splitting the string by comma
//                 List<String> tbarData = receivedData.split(',');

//                 // Finding the size of the list
//                 int size = tbarData.length;
//                 if (size > 0) {
//                   receivedAngle = tbarData[0];
//                   receivedHeartRate = tbarData.length > 1 ? tbarData[1] : "No Heart Rate data";
//                 }
//               }
//             });
//             print("Received value: $receivedData");
//             Snackbar.show(ABC.a, "Received value: $receivedData", success: true);
//           });
//           break;
//         }
//       }
//     } catch (e) {
//       Snackbar.show(ABC.a, prettyException("Discover Services Error:", e), success: false);
//     }
//   }

//   Future<void> readData() async {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reading data111111...')));
//     try {
//       var value = await targetCharacteristic?.read();
//       setState(() {
//         receivedData = String.fromCharCodes(value!);
//         if (receivedData.length > 4) {
//           // Splitting the string by comma
//           List<String> tbarData = receivedData.split(',');

//           // Finding the size of the list
//           int size = tbarData.length;
//           if (size > 0) {
//             receivedAngle = tbarData[0];
//             receivedHeartRate = tbarData.length > 1 ? tbarData[1] : "No Heart Rate data";
//           }
//         }
//       });
//       print("Read value: $receivedData");
//       Snackbar.show(ABC.a, "Read value: $receivedData", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.a, prettyException("Read Error:", e), success: false);
//     }
//   }

//   Future<void> writeData(String data) async {
//     try {
//       await targetCharacteristic?.write(data.codeUnits, withoutResponse: true);
//       print("Written value: $data");
//       Snackbar.show(ABC.a, "Written value: $data", success: true);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Written value: $data"), backgroundColor: Colors.blue));
//     } catch (e) {
//       Snackbar.show(ABC.a, prettyException("Write Error:", e), success: false);
//     }
//   }

//   void sendData(String data) {
//     Snackbar.show(ABC.a, data, success: true);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sending data: $data"), backgroundColor: Colors.blue));
//     if (targetCharacteristic != null) {
//       targetCharacteristic!.write(data.codeUnits);
//     } else {
//       print("Target characteristic is not set.");
//       Snackbar.show(ABC.a, "Target characteristic is not set.", success: false);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Target characteristic is not set."), backgroundColor: Colors.blue));
//     }
//   }

//   @override
//   void dispose() {
//     widget.device.disconnect();
//     super.dispose();
//   }

//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Device Screen'),
//     ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: 500, // Adjust width as needed
//             height: 500, // Adjust height as needed
//             child: SfRadialGauge(
//               enableLoadingAnimation: true,
//               axes: <RadialAxis>[
//                 RadialAxis(
//                   minimum: 0,
//                   maximum: 35,
//                   labelOffset: 5,
//                   startAngle: 180,
//                   endAngle: 0,
//                   axisLineStyle: AxisLineStyle(
//                     thicknessUnit: GaugeSizeUnit.factor,
//                     thickness: 0.03,
//                   ),
//                   majorTickStyle: MajorTickStyle(length: 6, thickness: 4, color: Colors.blue),
//                   minorTickStyle: MinorTickStyle(length: 3, thickness: 3, color: Colors.green),
//                   axisLabelStyle: GaugeTextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                  
//                   pointers: <GaugePointer>[
//                     NeedlePointer(
//                       value: double.parse(receivedAngle), // Convert receivedAngle to double
//                       needleLength: 0.85,
//                       enableAnimation: true,
//                       animationType: AnimationType.easeInCirc,
//                       needleStartWidth: 1.5,
//                       needleEndWidth: 6,
//                       needleColor: Colors.red,
//                       knobStyle: KnobStyle(knobRadius: 0.09),
//                     ),
//                   ],
//                   annotations: <GaugeAnnotation>[
//                     GaugeAnnotation(
//                       widget: Container(
//                         child: Column(
//                           children: <Widget>[
//                             SizedBox(height: 70),
//                             Text('Angle $receivedAngle\u00B0', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ),
//                       angle: 90,
//                       positionFactor: 0.75,
//                     ),
//                   ],
//                   ranges: <GaugeRange>[
//                     GaugeRange(
//                       startValue: 0,
//                       endValue: 200,
//                       sizeUnit: GaugeSizeUnit.factor,
//                       startWidth: 0.03,
//                       endWidth: 0.03,
//                       gradient: SweepGradient(
//                         colors: const<Color>[Colors.green, Colors.yellow, Colors.red],
//                         stops: const<double>[0.0, 0.5, 1],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//               title: GaugeTitle(text: "T-Bar Angle"),
//             ),
//           ),
//           SizedBox(
//             width: 500, // Adjust width as needed
//             height: 300, // Adjust height as needed
//             child: SfRadialGauge(
//             axes: <RadialAxis>[
//               RadialAxis(
//                 minimum: 0,
//                 maximum: 100,
//                 showLabels: false,
//                 showTicks: false,
//                 axisLineStyle: AxisLineStyle(
//                   thickness: 0.2,
//                   cornerStyle: CornerStyle.bothCurve,
//                   color: const Color.fromARGB(30, 0, 169, 181),
//                   thicknessUnit: GaugeSizeUnit.factor,
//                 ),
//                 annotations: <GaugeAnnotation>[
//                   GaugeAnnotation(
//                     widget: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             'Heart Rate',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             '$receivedHeartRate',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 30.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     angle: 90,
//                     positionFactor: 0.2,
//                         ),
//                       ],
//                       pointers: <GaugePointer>[
//                         NeedlePointer(
//                           value: 10,
//                           needleColor: Colors.red,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 //SizedBox(height: 20),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     readData();
//                 //   },
//                 //   child: Text('Read Data'),
//                 // ),
//                 //SizedBox(height: 20),
//                 ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                       shadowColor: Colors.greenAccent,
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32.0)),
//                       minimumSize: Size(300, 50), //////// HERE
//                   ),
//                       onPressed: () {
//                         //sendData('c20');
//                       },
//                       child: Text('Heart Rate $receivedHeartRate'),
//                     ),
//                     SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                       shadowColor: Colors.greenAccent,
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32.0)),
//                       minimumSize: Size(300, 50), //////// HERE
//                   ),
//                       onPressed: () {
//                         sendData('c20');
//                       },
//                       child: Text('Start'),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                       shadowColor: Colors.greenAccent,
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32.0)),
//                       minimumSize: Size(300, 50), //////// HERE
//                   ),
//                       onPressed: () {
//                         sendData('d');
//                       },
//                       child: Text('Stop'),
//                     ),
                    
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                       shadowColor: Colors.greenAccent,
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32.0)),
//                       minimumSize: Size(300, 50), //////// HERE
//                   ),
//                       onPressed: () {
//                         readData();
//                       },
//                       child: Text('Read'),
//                     ),

//                   ]
//                 ),
//                 // SizedBox(height: 20),
//                 // Text('Received Data: $receivedData'),
//               ],
//             ),
//     ),
//   );
// }

// }


//import 'dart:ffi';

import 'package:btapplication/statemanagment/bluetooth_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../utils/snackbar.dart';
import 'package:vibration/vibration.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;
  final BluetoothDevice? device1;
  final double? angleFromUserScreen;
  DeviceScreen({required this.device, this.device1, this.angleFromUserScreen});

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
  int finalHeartRate=0;
  String angleText = "Angle";
  String heartText = "Heart Rate";

  int _selectedIndex = 0; // Track the selected index

  @override
  void initState() {
    super.initState();
    connectToDevice();
  }

  Future<void> connectToDevice() async {
    try {
      await widget.device.connect();
      discoverServices();
      // Update connected device in provider
      Provider.of<BluetoothDataProvider>(context, listen: false).setConnectedDevice(widget.device);
      Provider.of<BluetoothDataProvider>(context, listen: false).setConnectedtESTDevice(widget.device);
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
                  print('427******'+tbarData[0]);
                  receivedHeartRate = tbarData.length > 1 ? tbarData[1] : "No Heart Rate data";
                  finalHeartRate = tbarData.length > 1 ? int.parse(tbarData[1]) : 0;
                }
              }
            });
            print("Received value: $receivedData");
            Snackbar.show(ABC.a, "Received value: $receivedData", success: true);
            Provider.of<BluetoothDataProvider>(context, listen: false).updateData(receivedData);
            Provider.of<BluetoothDataProvider>(context, listen: false).setCharacteristicDevice(targetCharacteristic!);
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
            finalHeartRate = tbarData.length > 1 ? int.parse(tbarData[1]) : 0;
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
  _callVibration() async {
    // Vibration.vibrate(); //default and one time vibrate
    Vibration.vibrate(pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500],intensities: [0, 128, 0, 255, 0, 64, 0, 255],); 
    //Pattern: wait 0.5s, vibrate 1s, wait 0.5s, vibrate 2s, wait 0.5s, vibrate 3s, wait 0.5s, vibrate 0.5s
  }

  @override
Widget build(BuildContext context) {

    //final bluetoothDataProvider = Provider.of<BluetoothDataProvider>(context);

  // Determine the color based on the heart rate value
    Color heartRateColor;
    String inputangle='20';
    if (finalHeartRate < 80) {
      heartRateColor = Colors.green; // Low heart rate
    } else if (finalHeartRate <= 140) {
      heartRateColor = Colors.orange; // Normal heart rate
      //_callVibration();
    } else if (finalHeartRate <= 200) {
      heartRateColor = Colors.red; // Elevated heart rate
      //_callVibration();
    } else {
      heartRateColor = Colors.red; // High heart rate
      //_callVibration();
    }
    if(finalHeartRate>=100)
    {
      
      _callVibration();
    }
    if(widget.angleFromUserScreen!=0.00)
    {
      print("530*******");
      inputangle=widget.angleFromUserScreen.toString();
    }
    else{
      inputangle='20';
      print("534*******");  
    }
    

  return Scaffold(
    appBar: AppBar(
      title: Text('Device Screen'),
    ),
    body: SingleChildScrollView(
        child: Center(
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
                                Text('$receivedAngle\u00B0', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
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
                            colors: const <Color>[Colors.green, Colors.yellow, Colors.red],
                            stops: const <double>[0.0, 0.5, 1],
                          ),
                        ),
                      ],
                    ),
                  ],
                  title: GaugeTitle(
                    text: angleText,
                    textStyle: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.blue,),
                  ),
                ),
              ),
              SizedBox(
                width: 700, // Adjust width as needed
                height: 500, // Adjust height as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 200,
                            ranges: <GaugeRange>[
                              GaugeRange(startValue: 0, endValue: 80, color: Colors.green),
                              GaugeRange(startValue: 80, endValue: 140, color: Colors.orange),
                              GaugeRange(startValue: 140, endValue: 200, color: Colors.red),
                            ],
                            pointers: <GaugePointer>[
                              //NeedlePointer(value: 75),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Container(
                                  child: Text('$finalHeartRate', style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold,color: heartRateColor)),
                                ),
                                angle: 90,
                               // positionFactor: 1.0,
                              ),
                            ],
                          ),
                        ],
                        title: GaugeTitle(
                          text: heartText,
                          textStyle: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.blue,),
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(16.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Container(width: 16, height: 16, color: Colors.green),
                    //           SizedBox(width: 8),
                    //           Text('Low (0-80)'),
                    //         ],
                    //       ),
                    //       SizedBox(height: 30),
                    //       Row(
                    //         children: [
                    //           Container(width: 16, height: 16, color: Colors.orange),
                    //           SizedBox(width: 8),
                    //           Text('Medium (80-140)'),
                    //         ],
                    //       ),
                    //       SizedBox(height: 30),
                    //       Row(
                    //         children: [
                    //           Container(width: 16, height: 16, color: Colors.red),
                    //           SizedBox(width: 8),
                    //           Text('High (140-200)'),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(width: 16, height: 16, color: Colors.green),
                          SizedBox(width: 10),
                          Text('Low (0-80)'),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Container(width: 16, height: 16, color: Colors.orange),
                          SizedBox(width: 10),
                          Text('Medium (80-140)'),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Container(width: 16, height: 16, color: Colors.red),
                          SizedBox(width: 10),
                          Text('High (140-200)'),
                        ],
                      ),
                    ],
                  ),
                ),
                    // SizedBox(height: 20),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     shadowColor: Colors.greenAccent,
                    //     elevation: 3,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(32.0),
                    //     ),
                    //     minimumSize: Size(300, 50),
                    //   ),
                    //   onPressed: () {
                    //     //  sendData('c20');
                    //   },
                    //   child: Text('Heart Rate $receivedHeartRate'),
                    // ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.greenAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            minimumSize: Size(300, 50),
                          ),
                          onPressed: () {
                            // Start action
                            // sendData('c'+inputangle);
                            print('749************'+inputangle);
                            //sendData('c$inputangle');
                            sendData('c20');
                          },
                          child: Text('Startaa'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.greenAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            minimumSize: Size(300, 50),
                          ),
                          onPressed: () {
                            sendData('d');
                          },
                          child: Text('Stop'),
                        ),
                      ],
                    ),
                    // SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         shadowColor: Colors.greenAccent,
                    //         elevation: 3,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(32.0),
                    //         ),
                    //         minimumSize: Size(300, 50),
                    //       ),
                    //       onPressed: () {
                    //         readData();
                    //         _callVibration();
                    //       },
                    //       child: Text('Read'),
                    //     ),
                    //   ],
                    // ),
                  ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //     // Handle navigation based on the selected index
      //     // Example: Navigator.pushNamed(context, '/newScreen');
      //   },
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
  );
}

}
 
