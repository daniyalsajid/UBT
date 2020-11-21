import 'package:UBT/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:UBT/screens/progress_screens/user_entry.dart';
import 'package:UBT/screens/progress_screens/week_progress.dart';

import 'package:UBT/screens/progress_screens/user_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    Userdata(),
    Weekprogress(),
    UserEntry(),
    ProfileScreen(),
  ];
  // user_screen(),details_screen(),progress_screen()WeekReportSubPage(),UserEntry(),
  void _onPageChanged(int index) {}
  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        iconSize: 40,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green,

        selectedFontSize: 20,
        // backgroundColor: Colors.green[300],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('Fortschritt'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.highlight),
            title: Text('Verlauf'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            title: Text('Activity'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
