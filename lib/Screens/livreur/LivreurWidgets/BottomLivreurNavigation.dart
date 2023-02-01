import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/Screens/livreur/LivreurScreens/MesCourse.dart';
import 'package:monlivreur/Screens/profile/profile_screen.dart';

import '../LivreurScreens/AlertJob.dart';


class BottomLivreurNavigation extends StatefulWidget {
  static String bottomLivreurNavigation = '/bottomLivreurNavigation';
  BottomLivreurNavigation({super.key});

  @override
  State<BottomLivreurNavigation> createState() =>
      _BottomLivreurNavigationState();
}

class _BottomLivreurNavigationState extends State<BottomLivreurNavigation> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    PublierLivreurAnnonce(),
    AlertJob(),
    ProfileScreen(userType: 1,),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          backgroundColor: PrimaryColorY,
          unselectedItemColor: MonLTextGrey,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Mes Courses',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.motorcycle,
            //   ),
            //   label: 'Mes Courses',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Alerte d\'emploi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),
    );
  }
}
