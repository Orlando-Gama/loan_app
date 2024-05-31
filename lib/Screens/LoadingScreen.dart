import 'package:flutter/material.dart';

loading(context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => WillPopScope(

      onWillPop: () async{

        return  false;
      },
      child: Center(
        child: Container(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff000000)),
          ),
        ),
      ),
    ));
