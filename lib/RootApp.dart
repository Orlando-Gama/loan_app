import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:tadza_loan/BottomScreens/BorrowScreen.dart';
import 'package:tadza_loan/BottomScreens/HomeScreen.dart';
import 'package:tadza_loan/BottomScreens/ProfileScreen.dart';
import 'package:tadza_loan/BottomScreens/StatisticsScreen.dart';
import 'package:tadza_loan/BottomScreens/TransactionScreen.dart';
import 'package:tadza_loan/theme/colors.dart';
class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {

  int pageIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    StatisticsScreen(),
    BorrowScreen(),
    TransactionScreen(),
    ProfileScreen(),

   //
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
             // selectedTab(4);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BorrowScreen(

                  )),
                      (route) => false);
            },
            child: Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
            backgroundColor: Colors.pink
          //params
        ),
        );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.md_calendar,
      Ionicons.md_stats,
      Ionicons.md_add,
      Ionicons.md_list_box,
      Ionicons.ios_person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
     // gapLocation: GapLocation.center,
       notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 0,
      iconSize: 25,
      rightCornerRadius: 0,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
