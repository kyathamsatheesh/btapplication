import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onSelect;  // Callback for when a tab is selected
  const BottomNavBar({Key? key, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 8,
      activeColor: Colors.white,
      iconSize: 24,
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      duration: Duration(milliseconds: 800),
      tabBackgroundColor: Theme.of(context).primaryColor,
      tabs: [
        GButton(
          icon: LineIcons.bluetooth,
          text: 'Device',
        ),
        GButton(
          icon: LineIcons.plus,
          text: 'Add',
        ),
        GButton(
          icon: LineIcons.user,
          text: 'User List',
        ),
      ],
      onTabChange: onSelect,
    );
  }
}
