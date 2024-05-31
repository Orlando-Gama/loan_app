import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tadza_loan/RootApp.dart';
import 'package:tadza_loan/categoreis.dart';

class MoreDetailsScreen extends StatefulWidget {
  const MoreDetailsScreen({super.key, required this.id});
  final id;

  @override
  State<MoreDetailsScreen> createState() => _MoreDetailsScreenState();
}

class _MoreDetailsScreenState extends State<MoreDetailsScreen> {

  List imagelist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  icon: Icon(Icons.arrow_circle_left_outlined, color: Colors.grey)),
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
              child:  IconButton(

                  onPressed: (){},
                  icon: Icon(Icons.question_mark_outlined, color: Colors.grey)),
            )
            /*Image.asset(
                'images/menu.png',
                width: 16,
              )*/
          ],
        ),
      ),

        body: StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('transactions')
        .where('id',isEqualTo: widget.id )
        .snapshots(),
    builder: (context, snapshot) {
    if(snapshot.hasError){
    return Scaffold(
    body: Center(
    child: Text('Error: $snapshot.error'),
    ),
    );
    }
    if (!snapshot.hasData) {
    return Scaffold(
    body: Center(
    child: CircularProgressIndicator(),
    ),
    );
    }
    else {
    return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemBuilder: (context, index) {
    DocumentSnapshot doc = snapshot.data!.docs[index];


    imagelist = doc['image'];



    return SingleChildScrollView(
        child: Column(
        children: [

          Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                child: const Text(
                  "Transaction Details",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      "Amount",
                      style: const TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),

                    Text(
                      "Mwk ${(doc['amount'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                      style: const TextStyle(

                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      "Percentage",
                      style: const TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),

                    Text(
                      doc['percentages'].toString()+"%",
                      style: const TextStyle(

                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      "Service Fee",
                      style: const TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),

                    Text(
                      doc['fee'],
                      style: const TextStyle(

                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      "Period",
                      style: const TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),

                    Text(
                      doc['category'],
                      style: const TextStyle(

                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      "Status",
                      style: const TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),

                    Text(
                      doc['status'],
                      style: const TextStyle(

                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      "Total",
                      style: const TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),

                    Text(
                      "Mwk ${("${doc['total']}".toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}0",
                      style: const TextStyle(

                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:0, top: 8),
                child: Divider(
                  thickness: 0.8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                child: const Text(
                  "Collateral Images",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: [

                      for(var i = 0; i < imagelist.length; i++ )
                      GestureDetector(
                        onTap: () {
                          setState(() {

                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            width: 150,
                            height: 170,
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(
                                    width: 2,
                                    color:  Colors.transparent),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey.withOpacity(0.01),
                                    spreadRadius: 10,
                                    blurRadius: 3,
                                    // changes position of shadow
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right:0, top: 0, bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 150,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: grey.withOpacity(0.15)),
                                      child: Center(
                                        child: CircleAvatar(
                                          radius: 80,
                                          backgroundImage: CachedNetworkImageProvider(
                                            doc['image'][i],

                                          ),
                                        ),
                                      )),

                                ],
                              ),
                            ),
                          ),
                        ),
                      )

        ]
                    ),
              ),

            ],
          )


        ]
    )
        );});}}),

      bottomNavigationBar:Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.white,
          height: 60,
          child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 35,
                padding: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: const Text(
                    "",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 30,),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RootApp(



                      )));
                },
                child: Container(
                  height: 60,width: 200,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF000000),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child:Text(
                      "Done",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),


            ],
          )
      ),
    );
  }
}
