import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tadza_loan/BottomScreens/BorrowScreen.dart';
import 'package:tadza_loan/Screens/SplashNotScreen.dart';
import 'package:tadza_loan/theme/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _email =
  TextEditingController(text: "abbie_wilson@gmail.com");
  TextEditingController dateOfBirth = TextEditingController(text: "04-19-1992");
  TextEditingController password = TextEditingController(text: "123456");

  _logoutAlert(context) {
    Alert (

        context: context,
        type: AlertType.error,


        desc: "Are you sure to logout?",

        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () =>Navigator.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle( fontSize: 20),
            ),
          ),
          DialogButton(
            color: Colors.white,
            onPressed: () async{

              await FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashNotScreen()));
            },
            child: Text(
              "OK",
              style: TextStyle(color: Color(0xFFFF7426), fontSize: 20),
            ),
          )
        ]).show();
  }
  int total2 = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                "Profile",
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
                child:  IconButton(

                    onPressed: (){},
                    icon:  Icon(AntDesign.setting)),
              )
              /*Image.asset(
                'images/menu.png',
                width: 16,
              )*/
            ],
          ),
        ),

     body:  StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)

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


    return SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
    top: 30, right: 20, left: 20, bottom: 25),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      CircleAvatar(
        radius: 45,
        backgroundColor: Colors.white,
        backgroundImage: CachedNetworkImageProvider(doc['profilePic']),

      ),

    Row(
    children: [
    /*  Container(
                            width: (size.width - 40) * 0.4,
                            child: Container(
                              child: Stack(
                                children: [
                                  RotatedBox(
                                    quarterTurns: -2,
                                    child: CircularPercentIndicator(
                                        circularStrokeCap: CircularStrokeCap.round,
                                        backgroundColor: Colors.grey.withOpacity(0.3),
                                        radius: 70.0,
                                        lineWidth: 6.0,
                                        percent: 0.53,
                                        progressColor: primary),
                                  ),
                                  Positioned(
                                    top: 16,
                                    left: 13,
                                    child: Container(
                                      width: 85,
                                      height: 85,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                                              fit: BoxFit.cover)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),*/

    SizedBox(width: 20,),
    Container(
    width: (size.width - 40) * 0.6,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
      doc['name'],
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black),
    ),
    SizedBox(
    height: 10,
    ),
    Text(
      doc['email'],
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black.withOpacity(0.4)),
    ),
    ],
    ),
    )
    ],
    ),
    SizedBox(
    height: 25,
    ),
    Container(
    width: double.infinity,
    decoration: BoxDecoration(
    color: primary,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: primary.withOpacity(0.01),
    spreadRadius: 10,
    blurRadius: 3,
    // changes position of shadow
    ),
    ]),
    child: Padding(
    padding: const EdgeInsets.only(
    left: 20, right: 20, top: 25, bottom: 25),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    "Total Balance ",
    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Colors.white),
    ),
    SizedBox(
    height: 10,
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

    int total1 = 0;
   // Initialize total2 to 0
    if (snapshots.hasData) {
    snapshots.data!.docs.forEach((doc) {

    int tot =  doc['total'];

    // int orderTotal = tot; // Assuming 'totalAmount' is a double
    total2 += tot; // Accumulate the total amount
    total1 += tot; // Accumulate the total amount
    });

    return
    Text(
      (total1 == 0)
          ? "Mwk 0.00"
          : "Mwk ${(total1.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",

      style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.white),
    );
    }

    return Text("loading");
    },
    ) ,



    ],
    ),

      (total2==0)? GestureDetector(
        onTap: (){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BorrowScreen(

              )),
                  (route) => false);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white)),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              "Borrow Now",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ):
    Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.white)),
    child: Padding(
    padding: const EdgeInsets.all(13.0),
    child: Text(
    "Pay Now",
    style: TextStyle(color: Colors.white),
    ),
    ),
    )
    ],
    ),
    ),
    )
    ],
    ),
    ),
    ),


    Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20),
    child: Row(
    children: [
    Icon( Icons.person, size: 20, color: Color(0xFF757575).withOpacity(0.6)),
    16.width,
    Text("Information", style: primaryTextStyle()),
    ],
    ),
    ),
    Divider(),

    Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.only(left: 20),
    child: Row(
    children: [
    Icon( Icons.security, size: 20, color: Color(0xFF757575).withOpacity(0.6)),
    16.width,
    Text("Security", style: primaryTextStyle()),
    ],
    ),
    ),
    Divider(),

    Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20),
    child: Row(
    children: [
    Icon( Icons.message, size: 20, color:Color(0xFF757575).withOpacity(0.6)),
    16.width,
    Text("Contact us", style: primaryTextStyle()),
    ],
    ),
    ),
    Divider(),
    Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20),
    child: Row(
    children: [
    Icon(Icons.help, size: 20, color: Color(0xFF757575).withOpacity(0.6)),
    16.width,
    Text("Support", style: primaryTextStyle()),
    ],
    ),
    ),
    Divider(),
    GestureDetector(
    onTap: (){

    _logoutAlert(context);

    },
    child: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20),
    child: Row(
    children: [
    Icon(Icons.access_time, size: 20, color: Color(0xFF757575).withOpacity(0.6)),
    16.width,
    Text("Logout", style: primaryTextStyle()),
    ],
    ),
    ),
    ),


    ],
    ),
    );
    }
    );}})

    );
  }
}
