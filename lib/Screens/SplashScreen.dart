import 'package:flutter/material.dart';
import 'package:tadza_loan/RootApp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void navigationPage() {


     Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => RootApp()));
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(color: Color(0xffffffff)),
        child: SafeArea(
          child: new Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                SizedBox(height: 250,),
                Center(
                  child: Opacity(
                      opacity: opacity.value,
                      child: Column(
                        children: [
                         /* new Image.asset('assets/images/Untitled design (1).png', height: 110, width: 220,),
*/
                          SizedBox(height: 20,),

                          Center(
                            child: CircularProgressIndicator(
                              color:Color(0xff000000) ,
                            ),
                          )
                        ],
                      )),
                ),
                Spacer(),
                Opacity(
                  opacity: opacity.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Color(0xff000000),),
                            children: [
                              TextSpan(text: 'Powered by '),
                              TextSpan(
                                  text: 'Gladlex CO.',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  ))
                            ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

}
}
