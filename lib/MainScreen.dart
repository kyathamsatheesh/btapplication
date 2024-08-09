import 'package:btapplication/screens/dashboard.dart';
import 'package:btapplication/screens/user_creation.dart';
import 'package:flutter/material.dart';
import '../commonscreen/profilescreen.dart'; // Assuming you have a profile screen
import 'BottomNavBar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const FlutterBlueApp(),
    UserCreationScreen(),
   const ProfileScreen(),
   const ProfileScreen()
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
