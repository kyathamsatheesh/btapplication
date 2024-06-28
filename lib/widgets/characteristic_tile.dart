//LAPTOP Code

// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// import "../utils/snackbar.dart";

// import "descriptor_tile.dart";

// class CharacteristicTile extends StatefulWidget {
//   final BluetoothCharacteristic characteristic;
//   final List<DescriptorTile> descriptorTiles;

//   const CharacteristicTile({Key? key, required this.characteristic, required this.descriptorTiles}) : super(key: key);

//   @override
//   State<CharacteristicTile> createState() => _CharacteristicTileState();
// }

// class _CharacteristicTileState extends State<CharacteristicTile> {
//   List<int> _value = [];

//   late StreamSubscription<List<int>> _lastValueSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _lastValueSubscription = widget.characteristic.lastValueStream.listen((value) {
//       _value = value;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _lastValueSubscription.cancel();
//     super.dispose();
//   }

//   BluetoothCharacteristic get c => widget.characteristic;

//   List<int> _getRandomBytes() {
//     final math = Random();
//     return [math.nextInt(255), math.nextInt(255), math.nextInt(255), math.nextInt(255)];
//   }

//   Future onReadPressed() async {
//     try {
//       await c.read();
//       Snackbar.show(ABC.c, "Read: Success", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Read Error:", e), success: false);
//     }
//   }

//   Future onWritePressed() async {
//     try {
//       await c.write(_getRandomBytes(), withoutResponse: c.properties.writeWithoutResponse);
//       Snackbar.show(ABC.c, "Write: Success", success: true);
//       if (c.properties.read) {
//         await c.read();
//       }
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
//     }
//   }

//   Future onSubscribePressed() async {
//     try {
//       String op = c.isNotifying == false ? "Subscribe" : "Unubscribe";
//       await c.setNotifyValue(c.isNotifying == false);
//       Snackbar.show(ABC.c, "$op : Success", success: true);
//       if (c.properties.read) {
//         await c.read();
//       }
//       if (mounted) {
//         setState(() {});
//       }
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Subscribe Error:", e), success: false);
//     }
//   }

//   Widget buildUuid(BuildContext context) {
//     String uuid = '0x${widget.characteristic.uuid.str.toUpperCase()}';
//     return Text(uuid, style: TextStyle(fontSize: 13));
//   }

//   Widget buildValue(BuildContext context) {
//     String data = _value.toString();
//     return Text(data, style: TextStyle(fontSize: 13, color: Colors.grey));
//   }

//   Widget buildReadButton(BuildContext context) {
//     return TextButton(
//         child: Text("Read"),
//         onPressed: () async {
//           await onReadPressed();
//           if (mounted) {
//             setState(() {});
//           }
//         });
//   }

//   Widget buildWriteButton(BuildContext context) {
//     bool withoutResp = widget.characteristic.properties.writeWithoutResponse;
//     return TextButton(
//         child: Text(withoutResp ? "WriteNoResp" : "Write"),
//         onPressed: () async {
//           await onWritePressed();
//           if (mounted) {
//             setState(() {});
//           }
//         });
//   }

//   Widget buildSubscribeButton(BuildContext context) {
//     bool isNotifying = widget.characteristic.isNotifying;
//     return TextButton(
//         child: Text(isNotifying ? "Unsubscribe" : "Subscribe"),
//         onPressed: () async {
//           await onSubscribePressed();
//           if (mounted) {
//             setState(() {});
//           }
//         });
//   }

//   Widget buildButtonRow(BuildContext context) {
//     bool read = widget.characteristic.properties.read;
//     bool write = widget.characteristic.properties.write;
//     bool notify = widget.characteristic.properties.notify;
//     bool indicate = widget.characteristic.properties.indicate;
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (read) buildReadButton(context),
//         if (write) buildWriteButton(context),
//         if (notify || indicate) buildSubscribeButton(context),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       title: ListTile(
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Text('Characteristic'),
//             buildUuid(context),
//             buildValue(context),
//           ],
//         ),
//         subtitle: buildButtonRow(context),
//         contentPadding: const EdgeInsets.all(0.0),
//       ),
//       children: widget.descriptorTiles,
//     );
//   }
// }


import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import "../utils/snackbar.dart";

import "descriptor_tile.dart";
import 'package:fluttertoast/fluttertoast.dart';

class CharacteristicTile extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;

  const CharacteristicTile({Key? key, required this.characteristic, required this.descriptorTiles}) : super(key: key);

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  List<int> _value = [];

  late StreamSubscription<List<int>> _lastValueSubscription;

  @override
  void initState() {
    super.initState();
    _lastValueSubscription = widget.characteristic.lastValueStream.listen((value) {
      _value = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _lastValueSubscription.cancel();
    super.dispose();
  }

  BluetoothCharacteristic get c => widget.characteristic;

  List<int> _getRandomBytes() {
    final math = Random();
    return [math.nextInt(255), math.nextInt(255), math.nextInt(255), math.nextInt(255)];
  }

  Future onReadPressed() async {
    try {
      await c.read();
      Snackbar.show(ABC.c, "Read: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Read Error:", e), success: false);
    }
  }

  Future onWritePressed(List<int> data) async {
    try {
      await c.write(data, withoutResponse: c.properties.writeWithoutResponse);
      Snackbar.show(ABC.c, "Write: Success", success: true);
      if (c.properties.read) {
        await c.read();
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
    }
  }

  Future onSubscribePressed() async {
    try {
      String op = c.isNotifying == false ? "Subscribe" : "Unsubscribe";
      await c.setNotifyValue(c.isNotifying == false);
      Snackbar.show(ABC.c, "$op : Success", success: true);
      if (c.properties.read) {
        await c.read();
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Subscribe Error:", e), success: false);
    }
  }

  Widget buildServiceUuid(BuildContext context) {
    String serviceUuid = '0x${widget.characteristic.serviceUuid.toString().toUpperCase()}';
    Fluttertoast.showToast(
    msg: "serviceUuid: $serviceUuid",
    toastLength: Toast.LENGTH_SHORT, // Duration for which the toast is shown
    gravity: ToastGravity.BOTTOM, // Location where the toast appears on the screen
    timeInSecForIosWeb: 1, // Specific to iOS, not used on Android
    backgroundColor: Colors.grey, // Background color of the toast
    textColor: Colors.white, // Text color of the toast
    fontSize: 16.0 // Font size of the text
);
    String expectedServiceUuid = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Service UUID:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          serviceUuid,
          style: TextStyle(fontSize: 13),
        ),
        if (serviceUuid != expectedServiceUuid)
          Text(
            'Unexpected/Invalid Service UUID. Expected: $expectedServiceUuid',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Widget buildCharacteristicUuid(BuildContext context) {
    String characteristicUuid = '0x${widget.characteristic.uuid.str.toUpperCase()}';
    Fluttertoast.showToast(
    msg: "characteristicUuid : -$characteristicUuid",
    toastLength: Toast.LENGTH_SHORT, // Duration for which the toast is shown
    gravity: ToastGravity.BOTTOM, // Location where the toast appears on the screen
    timeInSecForIosWeb: 1, // Specific to iOS, not used on Android
    backgroundColor: Colors.grey, // Background color of the toast
    textColor: Colors.white, // Text color of the toast
    fontSize: 16.0 // Font size of the text
);
    String expectedCharacteristicUuid = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Characteristic UUID:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          characteristicUuid,
          style: TextStyle(fontSize: 13),
        ),
        if (characteristicUuid != expectedCharacteristicUuid)
          Text(
            'Unexpected/Invalid Characteristic UUID. Expected: $expectedCharacteristicUuid',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Widget buildValue(BuildContext context) {
    String data = _value.toString();
    return Text(data, style: TextStyle(fontSize: 13, color: Colors.grey));
  }

  Widget buildReadButton(BuildContext context) {
    return TextButton(
        child: Text("Read Data"),
        onPressed: () async {
          await onReadPressed();
          if (mounted) {
            setState(() {});
          }
        });
  }

  Widget buildWriteButton(BuildContext context) {
    return TextButton(
        child: Text("Write Random Data"),
        onPressed: () async {
          await onWritePressed(_getRandomBytes());
          if (mounted) {
            setState(() {});
          }
        });
  }

  Widget buildSubscribeButton(BuildContext context) {
    bool isNotifying = widget.characteristic.isNotifying;
    return TextButton(
        child: Text(isNotifying ? "Unsubscribe" : "Subscribe"),
        onPressed: () async {
          await onSubscribePressed();
          if (mounted) {
            setState(() {});
          }
        });
  }

  Widget buildButtonRow(BuildContext context) {
    bool read = widget.characteristic.properties.read;
    bool write = widget.characteristic.properties.write;
    bool notify = widget.characteristic.properties.notify;
    bool indicate = widget.characteristic.properties.indicate;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (read) buildReadButton(context),
        if (write) buildWriteButton(context),
        if (notify || indicate) buildSubscribeButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Characteristic'),
            buildServiceUuid(context),
            buildCharacteristicUuid(context),
            buildValue(context),
          ],
        ),
        subtitle: buildButtonRow(context),
        contentPadding: const EdgeInsets.all(0.0),
      ),
      children: widget.descriptorTiles,
    );
  }
}