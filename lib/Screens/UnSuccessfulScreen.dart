import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tadza_loan/RootApp.dart';

class UnSuccessfulScreen extends StatefulWidget {
  const UnSuccessfulScreen({super.key});

  @override
  State<UnSuccessfulScreen> createState() => _UnSuccessfulScreenState();
}

class _UnSuccessfulScreenState extends State<UnSuccessfulScreen> with SingleTickerProviderStateMixin {
  startTime() async {
    var _duration = Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() {
    finish(context);
    RootApp().launch(context, isNewTask: true);
  }

  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(

              radius: 100,
              backgroundImage: AssetImage(

                "images/1000_F_378676046_8gNLXCbqai6QSPSWS8Gfa12nUsYRk1Ki.jpg",

              )/* Image.asset(

                )*/,

            ),

            SizedBox(height: screenHeight * 0.1),
            Text(
              "We apologize!",
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Transaction process has failed",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "You will be redirected to the home page shortly\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Center(
              child: CircularProgressIndicator(
                color: Colors.pink,


              ),

            ),
          ],
        ),
      ) ,

    );
  }
}
