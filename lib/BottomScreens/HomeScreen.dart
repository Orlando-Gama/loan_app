import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tadza_loan/Screens/MoreDetailsScreen.dart';
import 'package:tadza_loan/Screens/notificationscreen.dart';
import 'package:tadza_loan/daily.dart';
import 'package:tadza_loan/day.dart';
import 'package:tadza_loan/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int activeDay = 3;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        actions: [],
        title:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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

                  onPressed: (){

                    finish(context);
                  },
                  icon: Icon(Icons.home_max_outlined, color: Colors.pink)),
            ),

            Container(
              width: 40,
              height: 40,
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              alignment: Alignment.center,
              child:    Stack(
                children: [
                  IconButton(
                    onPressed: () {
                     Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => notificationscreen()));

                    },
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.pink,
                      size: 30,
                    ),
                  ),



                  Positioned(
                    top: 1,
                    right:1,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffffffff),
                      ),
                      child:   Center(
                        child:



                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('transactions')
                              .where('status',isEqualTo: "Approved"  )

                              .where('seen',isEqualTo: "NO" )
                              . where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child:  Text("0"));
                            }
                            return

                              Text(
                                snapshot.data!.docs.length.toString().toUpperCase(),
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              );},
                        ),),
                    ),
                  ),
                ],
              ), /* IconButton(

                  onPressed: (){},
                  icon: Icon(Icons.question_mark_outlined, color: Colors.grey))*/
            )
            /*Image.asset(
                'images/menu.png',
                width: 16,
              )*/
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                    top: 10, right: 20, left: 20, bottom: 25),
                child: Column(
                  children: [

                    SizedBox(
                      height: 25,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(days.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeDay = index;
                              });
                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 40) / 7,
                              child: Column(
                                children: [
                                  Text(
                                    days[index]['label'],
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: activeDay == index
                                            ? primary
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: activeDay == index
                                                ? primary
                                                : Colors.black.withOpacity(0.1))),
                                    child: Center(
                                      child: Text(
                                        days[index]['day'],
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
                        }))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding:   EdgeInsets.only(top: 5),
                    child:   StreamBuilder<QuerySnapshot>(
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
          ? "K 0.00"
          : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    );
    }

    return Text("loading");
    },
                    ) ,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child:

    StreamBuilder<QuerySnapshot>  (
    stream: FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('status', isEqualTo: "Approved")
        .limit(4)
    //.orderBy('date', descending: false)
        .snapshots(),
    builder: (context, snapshot) {

    if (snapshot.hasError) {
    return Center(child: Text("Something went wrong"));
    }
    else if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator(
    color: Colors.white,
    ));
    }

    else {
    return ListView.builder(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemCount: snapshot.data!.docs.length,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
    DocumentSnapshot doc = snapshot.data!.docs[index];

    return

                      GestureDetector(
                        onTap: (){


                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MoreDetailsScreen(

                                 id: doc['id'],

                              )));

                        },
                        child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Image.network(
                                          doc['image'][0] ,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc['type'] ,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            doc['createdAt'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black.withOpacity(0.5),
                                                fontWeight: FontWeight.w400),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(

                                child:
                                    Text(
      "Mwk ${(doc['total'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00"
                                     ,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.green),

                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 65, top: 8),
                            child: Divider(
                              thickness: 0.8,
                            ),
                          )
                        ],
                    ),
                      );}
    );}})
                  ),



          ],
        ),
      ),
    );
  }
}
