import 'package:flutter/material.dart';
import 'package:btapplication/commonscreen/homescreen.dart';
import '../commonscreen/profilescreen.dart'; // Assuming you have a profile screen
import 'BottomNavBar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of widgets to use as the main content for the Scaffold
  final List<Widget> _widgetOptions = [
   // DeviceScreen(),
    //ScanScreen(),
    ProfileScreen(), // Replace or reorder these widgets as necessary
    HomeScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavBar(onSelect: _onItemTapped),
    );
  }
}
