import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tadza_loan/Models/BarChartModel.dart';
import 'package:tadza_loan/day.dart';
import 'package:tadza_loan/theme/colors.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int activeDay = 3;

  bool showAvg = false;

 /* final List<BarChartModel> data = [
    BarChartModel(
      year: "Mon",
      financial: 2500,
      color: charts.ColorUtil.fromDartColor(Color(0xffa4c639)),
    ),
    BarChartModel(
      year: "Tue",
      financial: 300,
      color: charts.ColorUtil.fromDartColor(Color(0xffa4c639)),
    ),
    BarChartModel(
      year: "Wed",
      financial: 100,
      color: charts.ColorUtil.fromDartColor(Color(0xffa4c639)),
    ),
    BarChartModel(
      year: "Thurs",
      financial: 450,
      color: charts.ColorUtil.fromDartColor(Color(0xffa4c639)),
    ),
    BarChartModel(
      year: "Fri",
      financial: 630,
      color: charts.ColorUtil.fromDartColor(Color(0xffa4c639)),
    ),
    BarChartModel(
      year: "Sat",
      financial: 950,
      color: charts.ColorUtil.fromDartColor(Color(0xffa4c639)),
    ),
    BarChartModel(
      year: "Sun",
      financial: 400,
      color: charts.ColorUtil.fromDartColor(Color(0xffa4c639)),
    ),
  ];*/

  final List<String> _dropdownValues = [
    "View",
    "24 Hours",
    "15 Days",
    "30 Days",
    "60 Days"
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List expenses = [
      {
        "icon": Icons.arrow_back,
        "color": blue,
        "label": "Income",
        "cost": "\$6593.75"
      },
      {
        "icon": Icons.arrow_forward,
        "color": red,
        "label": "Expense",
        "cost": "\$2645.50"
      }
    ];


  /*  List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: data,
        domainFn: (BarChartModel series, _) => series.year,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];*/
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.05),
        appBar: AppBar(
          centerTitle: false,
          elevation: 1,
          automaticallyImplyLeading: false,
          actions: [],
          title:   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Statistics",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),

              /* Container(
                width: 40,
                height: 40,
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                alignment: Alignment.center,
                child:   IconButton(

                    onPressed: (){

                      finish(context);
                    },
                    icon: Icon(Icons.arrow_circle_left_outlined, color: Colors.grey)),
              ),
*/
              Container(
                width: 40,
                height: 40,
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                alignment: Alignment.center,
                child:   IconButton(

                      onPressed: (){},
                      icon:  Icon(AntDesign.ellipsis1)),

              )
              /*Image.asset(
                'images/menu.png',
                width: 16,
              )*/
            ],
          ),
        ),
     body:   SingleChildScrollView(
            child: Column(
                children: [
            Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
            padding: const EdgeInsets.only(
            top: 40, right: 20, left: 20, bottom: 25),
        child: Column(
        children: [


          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(months.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      activeDay = index;
                    });
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 40) / 6,
                    child: Column(
                      children: [
                        Text(
                          months[index]['label'],
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: activeDay == index
                                  ? primary
                                  : Colors.black.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: activeDay == index
                                      ? primary
                                      : Colors.black.withOpacity(0.1))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 7, bottom: 7),
                            child: Text(
                              months[index]['day'],
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: activeDay == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),


        ])
    )
     ),


                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                      spacing: 20,
                      children: [

                        Container(
                          width: (size.width - 60) / 2,
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.01),
                                  spreadRadius: 10,
                                  blurRadius: 3,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                 Colors.blue,),
                                  child: Center(
                                      child: Icon(
                                      Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Paid",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xff67727d)),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('transactions').
                                      where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)

                                          .where('status', isEqualTo: "Paid")
                                          .snapshots(),
                                      builder:
                                          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {

                                        if (snapshots.hasError) {
                                          return Text("Something went wrong");
                                        }


                                        int total2 = 0; // Initialize total2 to 0
                                        if (snapshots.hasData) {
                                          snapshots.data!.docs.forEach((doc) {

                                            int tot =  doc['total'];

                                            // int orderTotal = tot; // Assuming 'totalAmount' is a double
                                            total2 += tot; // Accumulate the total amount
                                          });

                                          return Text(
                                            (total2 == 0)
                                                ? "Mwk 0.00"
                                                : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        }

                                        return Text("loading");
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: (size.width - 60) / 2,
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.01),
                                  spreadRadius: 10,
                                  blurRadius: 3,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors. pink,
                                    ),
                                  child: Center(
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Approved",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xff67727d)),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),

                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('transactions').
                                      where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)

                                          .where('status', isEqualTo: "Approved")
                                          .snapshots(),
                                      builder:
                                          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {

                                        if (snapshots.hasError) {
                                          return Text("Something went wrong");
                                        }


                                        int total2 = 0; // Initialize total2 to 0
                                        if (snapshots.hasData) {
                                          snapshots.data!.docs.forEach((doc) {

                                            int tot =  doc['total'];

                                            // int orderTotal = tot; // Assuming 'totalAmount' is a double
                                            total2 += tot; // Accumulate the total amount
                                          });

                                          return Text(
                                            (total2 == 0)
                                                ? "Mwk 0.00"
                                                : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        }

                                        return Text("loading");
                                      },
                                    )

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                      ]
                      ),

                 /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Total Paid Interest", style: TextStyle(

                              color: Colors.grey,
                              fontSize: 16,

                            ),),
                            SizedBox(height: 10,),
                            Text("Mwk 35,200.00", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                            ),),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: Color(0xffa4c639), style: BorderStyle.solid, width: 2),
                          ),
                          child: DropdownButton(
                            items: _dropdownValues
                                .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                                .toList(),
                            onChanged: (value) {},
                            isExpanded: false,
                            value: _dropdownValues.first,
                          ),
                        ),

                      ],
                    ),
                  ),*/
                /*  Container(
                    decoration: BoxDecoration(

                    ),
                    height: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: charts.BarChart(
                      series,
                      animate: true,
                    ),
                  ),*/
                ],
    )
     )


    );
  }
}
