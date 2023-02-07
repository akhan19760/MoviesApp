import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Widget bottomNavbar(int _selectedIndex, onTabTapped) {
  return GNav(
    activeColor: Color(0xff246fdb),
    backgroundColor: Color(0xFF00172F),
    tabBackgroundColor: Colors.blue.withOpacity(0.1),
    rippleColor: Colors.grey.shade300,
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    curve: Curves.easeIn,
    tabs: [
      GButton(
        icon: Icons.home_sharp,
        iconColor: Colors.grey.shade300,
        text: 'Home',
      ),
      GButton(
        icon: Icons.favorite_border_outlined,
        iconColor: Colors.grey.shade300,
        text: 'Favorites',
      ),
      GButton(
        icon: Icons.person_sharp,
        iconColor: Colors.grey.shade300,
        text: 'Profile',
      )
    ],
    selectedIndex: _selectedIndex,
    onTabChange: onTabTapped,
  );
}
