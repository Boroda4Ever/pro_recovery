import 'package:pro_recovery/screens/appointment/my_appointment_screen.dart';
import 'package:pro_recovery/screens/doctors/doctors_screen.dart';
import 'package:pro_recovery/screens/home/home_screen.dart';
import 'package:pro_recovery/screens/patients/patients_screen.dart';
import 'package:pro_recovery/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    HomePage(),
    PatientsScreen(),
    MyAppointmentScreen(),
    ProfileScreen(),
  ];
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(defaultPadding),
        color: Colors.white,
        child: SafeArea(
          child: GNav(
            haptic: true,
            tabBorderRadius: 15,
            curve: Curves.ease,
            duration: Duration(milliseconds: 350),
            gap: 8,
            color: Colors.grey[800],
            activeColor: Colors.white,
            iconSize: 24,
            tabBackgroundColor: primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Главное',
              ),
              GButton(
                icon: Icons.people,
                text: 'Пациенты',
              ),
              GButton(
                icon: Icons.content_paste,
                text: 'Встречи',
              ),
              GButton(
                icon: Icons.person,
                text: 'Профиль',
              )
            ],
            onTabChange: (pageNum) {
              setState(() {
                _selectedPage = pageNum;
              });
            },
          ),
        ),
      ),
    );
  }
}
