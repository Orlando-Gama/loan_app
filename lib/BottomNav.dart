import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tadza_loan/BottomScreens/HomeScreen.dart';
import 'package:tadza_loan/BottomScreens/ProfileScreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  final List _screens = [
    const HomeScreen(),


    const ProfileScreen()
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        items: [
          BottomNavigationBarItem(
              label: "Home",
              activeIcon: SvgPicture.asset(
                "assets/images/home-svgrepo-com.svg",
                color: Colors.black,
                height: 20,
              ),
              icon: SvgPicture.asset(
                "assets/images/home-svgrepo-com.svg",
                color: Colors.grey,
                height: 20,
              )),
          BottomNavigationBarItem(
              label: "Sales",
              activeIcon: SvgPicture.asset(
                "assets/images/transfer-fee-svgrepo-com.svg",
                color: Colors.black,
                height: 20,
              ),
              icon: SvgPicture.asset(
                "assets/images/transfer-fee-svgrepo-com.svg",
                color: Colors.grey,
                height: 20,
              )),
          BottomNavigationBarItem(
              label: "Customers",
              activeIcon: SvgPicture.asset(
                "assets/images/users-svgrepo-com.svg",
                color: Colors.black,
                height: 20,
              ),
              icon: SvgPicture.asset(
                "assets/images/users-svgrepo-com.svg",
                color: Colors.grey,
                height: 20,
              )),
          BottomNavigationBarItem(
              label: "Account",
              activeIcon: SvgPicture.asset(
                "assets/images/settings-svgrepo-com (2).svg",
                color: Colors.black,
                height: 20,
              ),
              icon: SvgPicture.asset(
                "assets/images/settings-svgrepo-com (2).svg",
                color: Colors.grey,
                height: 20,
              )),
        ],
      ),


    );
  }
}
