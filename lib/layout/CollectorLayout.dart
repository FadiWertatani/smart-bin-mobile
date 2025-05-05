import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:smar_bin/modules/CollectorHomeScreen.dart';
import 'package:smar_bin/modules/Profile.dart';

class CollectorLayout extends StatefulWidget {
  const CollectorLayout({super.key});

  @override
  State<CollectorLayout> createState() => _CollectorLayoutState();
}

class _CollectorLayoutState extends State<CollectorLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CollectorHomeScreen(), // Replace with your actual screen
    Profile(), // Replace with your actual screen
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SlidingClippedNavBar(
          backgroundColor: Colors.white,
          onButtonPressed: _onTabTapped,
          iconSize: 30,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColor,
          selectedIndex: _currentIndex,
          barItems: [
            BarItem(
              icon: Iconsax.home_2,
              title: 'Home',
            ),
            BarItem(
              icon: Iconsax.user,
              title: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
