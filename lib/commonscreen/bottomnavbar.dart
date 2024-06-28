import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home'),
    Text('Index 1: Search'),
    Text('Index 2: Profile'),
    Text('Index 3: Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          duration: Duration(milliseconds: 800),
          tabBackgroundColor: Theme.of(context).primaryColor,
          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            ),
            GButton(
              icon: LineIcons.cog,
              text: 'Settings',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
            // Navigate to the corresponding screen based on index
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home');
                break;
              case 1:
                Navigator.pushNamed(context, '/home');
                break;
              case 2:
                Navigator.pushNamed(context, '/profile');
                break;
              case 3:
                Navigator.pushNamed(context, '/home');
                break;
            }
          },
        ),
      ),
    );
  }
}
