// lib/heart_rate_chart.dart
// import 'package:btapplication/model/data_model.dart';
// import 'package:btapplication/services/data_service.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class HeartRateChart extends StatefulWidget {
//   @override
//   _HeartRateChartState createState() => _HeartRateChartState();
// }

// class _HeartRateChartState extends State<HeartRateChart> {
//   final DataService dataService = DataService();
//   List<HeartRateData> heartRateData = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     List<HeartRateData> data = await dataService.fetchHeartRateData();
//     print("*********** Data length: ${data.length}");
//     print("*********** Data length: ${data}");
//     setState(() {
//       heartRateData = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Heart Rate Chart')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SizedBox(
//           height: 400, // Adjust the height as needed
//           child: LineChart(
//             LineChartData(
//               gridData: FlGridData(show: true, drawVerticalLine: true),
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     interval: 10, // Y-axis interval
//                     getTitlesWidget: (value, meta) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text(
//                           value.toInt().toString(),
//                           style: TextStyle(fontSize: 14, color: Colors.black),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     interval: 10, // X-axis interval
//                     getTitlesWidget: (value, meta) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text(
//                           '${value.toInt()}s',
//                           style: TextStyle(fontSize: 14, color: Colors.black),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: Colors.grey),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: heartRateData.isNotEmpty
//                       ? heartRateData.asMap().entries.map((entry) {
//                           int index = entry.key;
//                           HeartRateData data = entry.value;
//                           // Calculate x as seconds since the first data point
//                           // double x = (data.timestamp.millisecondsSinceEpoch -
//                           //         heartRateData
//                           //             .first.timestamp.millisecondsSinceEpoch) /
//                           //     1000;
//                           double x = (data.timestamp.millisecondsSinceEpoch -
//                                   heartRateData
//                                       .first.timestamp.millisecondsSinceEpoch) /
//                               1000;
//                           return FlSpot(x, data.heartRate.toDouble());
//                         }).toList()
//                       : [FlSpot(0, 0)], // Provide at least one point if no data
//                   isCurved: true,
//                   color: Colors.blue,
//                   barWidth: 4,
//                   belowBarData: BarAreaData(show: false),
//                 ),
//               ],
//               lineTouchData: LineTouchData(enabled: false),
//               minX: heartRateData.isNotEmpty
//                   ? (heartRateData.first.timestamp.millisecondsSinceEpoch -
//                           heartRateData
//                               .first.timestamp.millisecondsSinceEpoch) /
//                       1000
//                   : 0,
//               maxX: heartRateData.isNotEmpty
//                   ? (heartRateData.last.timestamp.millisecondsSinceEpoch -
//                           heartRateData
//                               .first.timestamp.millisecondsSinceEpoch) /
//                       1000
//                   : 1,
//               minY: 0,
//               maxY: 150,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Placeholder for your DataService
// class DataService {
//   Future<List<HeartRateData>> fetchHeartRateData() async {
//     // Simulate network delay
//     await Future.delayed(Duration(seconds: 2));

//     // Return sample data
//     return [
//       HeartRateData(
//           angle: 30, heartRate: 70, timestamp: DateTime.now(), seconds: 10),
//       HeartRateData(
//           angle: 45, heartRate: 75, timestamp: DateTime.now(), seconds: 20),
//       HeartRateData(
//           angle: 60, heartRate: 80, timestamp: DateTime.now(), seconds: 40),
//       HeartRateData(
//           angle: 90, heartRate: 85, timestamp: DateTime.now(), seconds: 60),
//     ];
//   }
// }

import 'package:btapplication/model/data_model.dart';
import 'package:btapplication/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Rate Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HeartRateChart(),
    );
  }
}

class HeartRateChart extends StatefulWidget {
  @override
  _HeartRateChartState createState() => _HeartRateChartState();
}

class _HeartRateChartState extends State<HeartRateChart> {
  final DataService dataService = DataService();
  List<HeartRateData> heartRateData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<HeartRateData> data = await dataService.fetchHeartRateData();
    print("*********** Data length: ${data.length}");

    for (HeartRateData d in data) {
      print("*********** Data: ${d.heartRate} : ${d.seconds}");
    }
    setState(() {
      heartRateData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Convert data to FlSpot format
    List<FlSpot> spots = heartRateData
        .map((entry) =>
            FlSpot(entry.seconds.toDouble(), entry.heartRate.toDouble()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Heart Rate Chart')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 600, // Fixed height for the chart
          width: double.infinity, // Fixed width to fill the available space
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blue, // Set color for the line
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  // tooltipBgColor:
                  //    Colors.blueAccent, // Set tooltip background color
                  tooltipPadding:
                      const EdgeInsets.all(8), // Set padding for the tooltip
                  tooltipMargin: 8, // Set margin for the tooltip
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '${spot.x.toInt()}s\n${spot.y.toInt()}bpm',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? touchResponse) {
                  // Handle touch events here
                },
                handleBuiltInTouches: true,
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    // margin: 8, // Space between titles and axis
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          '${value.toInt()} s', // Add "Seconds" label
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    // margin: 8, // Space between titles and axis
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          '${value.toInt()} bpm', // Add "Heart Rate" label
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}





// // HeartRateData model
// class HeartRateData {
//   final double angle;
//   final int heartRate;
//   final DateTime timestamp;
//   final int seconds;

//   HeartRateData({
//     required this.angle,
//     required this.heartRate,
//     required this.timestamp,
//     required this.seconds,
//   });
// }
