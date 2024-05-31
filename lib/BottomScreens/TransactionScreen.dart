import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tadza_loan/Screens/MoreDetailsScreen.dart';
import 'package:tadza_loan/daily.dart';
import 'package:tadza_loan/day.dart';
import 'package:tadza_loan/theme/colors.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  int activeDay = 30;

  List<String> categories = [
    "All",
    "Approved",
    "Pending",
    "Paid",
  ];

  int selectedIndex = 0;


  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        margin: const EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.pink : Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            categories[index],
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
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
            Text(
              "Daily Transaction",
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
                    top: 40, right: 20, left: 20, bottom: 25),
                child: Column(
                  children: [

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
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => buildCategory(index),
                ),
              ),



            selectedIndex == 0
                ?
            Column(
              children: [
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
                                    ? "Mwk 0.00"
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
            )
                :  selectedIndex == 1 ?
            Column(
              children: [
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
                                    ? "Mwk 0.00"
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
            )
                :  selectedIndex == 2 ?
            Column(
              children: [
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

                              .where('status', isEqualTo: "Pending")
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
                            .where('status', isEqualTo: "Pending")
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
            )
                :  selectedIndex == 3 ?
            Column(
              children: [
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
                            .where('status', isEqualTo: "Paid")
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
            ):Container(),

          ],
        ),
      ),
    );
  }
}
