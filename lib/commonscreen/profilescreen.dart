import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your semi-circular progress bar
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  startAngle: 180,
                  endAngle: 0,
                  axisLineStyle: AxisLineStyle(
                    thickness: 20,
                    color: Colors.blue,
                    thicknessUnit: GaugeSizeUnit.logicalPixel,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: 60,
                      width: 20,
                      color: Colors.green,
                      pointerOffset: -10,
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Profile Screen Content'),
          ],
        ),
      ),
    );
  }
}

