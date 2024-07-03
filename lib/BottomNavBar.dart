// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:line_icons/line_icons.dart';

// class BottomNavBar extends StatelessWidget {
//   final Function(int) onSelect;  // Callback for when a tab is selected
//   const BottomNavBar({Key? key, required this.onSelect}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GNav(
//       gap: 8,
//       activeColor: Colors.white,
//       iconSize: 24,
//       padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
//       duration: Duration(milliseconds: 800),
//       tabBackgroundColor: Theme.of(context).primaryColor,
      
      
//       tabs: [
//         GButton(
//           icon: LineIcons.bluetooth,
//           text: 'Devices',
//         ),
//         GButton(
//           icon: LineIcons.plus,
//           text: 'Add User',
//         ),
//         GButton(
//           icon: LineIcons.user,
//           text: 'User List',
//         ),
//         GButton(
//           icon: LineIcons.airbnb,
//           text: 'Tbar read',
//         ),
//       ],
//       onTabChange: onSelect,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onSelect; // Callback for when a tab is selected
  const BottomNavBar({Key? key, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust padding and iconSize based on screen width
        double screenWidth = MediaQuery.of(context).size.width;
        double padding = screenWidth > 800 ? 100 : 20; // Adjust as needed
        double iconSize = screenWidth > 600 ? 28 : 24; // Adjust as needed

        return GNav(
          gap: 8,
          activeColor: Colors.white,
          iconSize: iconSize,
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 15),
          duration: Duration(milliseconds: 800),
          tabBackgroundColor: Theme.of(context).primaryColor,
          tabs: [
            GButton(
              icon: LineIcons.bluetooth,
              text: 'Devices',
            ),
            GButton(
              icon: LineIcons.plus,
              text: 'Add User',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'User List',
            ),
            GButton(
              icon: LineIcons.airbnb,
              text: 'Tbar read',
            ),
          ],
          onTabChange: onSelect,
        );
      },
    );
  }
}
