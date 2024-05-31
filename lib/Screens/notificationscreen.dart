import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tadza_loan/Screens/MoreDetailsScreen.dart';

class notificationscreen extends StatefulWidget {
  const notificationscreen({super.key});

  @override
  State<notificationscreen> createState() => _notificationscreenState();
}

class _notificationscreenState extends State<notificationscreen> {
  Future <void> seen(id){
    return  FirebaseFirestore.instance.collection('transactions').doc(id).update({

      'seen': 'YES',

    }).then((value){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
      {
        return MoreDetailsScreen(
          id:id,

        );
      }));
    }
    )
        .catchError((error)=>
        print(
            '$error'
        ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: true,
        actions: [],
        title:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Notifications",
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

      body: ListView(
        children: [

          SizedBox(
            height: 30,
          ),

          StreamBuilder<QuerySnapshot>  (
              stream: FirebaseFirestore.instance
                  .collection('transactions')
                  .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where('status',isEqualTo: "Approved"  )
                  .where('seen',isEqualTo: "NO" )
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

                              seen(doc['id']);
                              /*Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
        {
          return morescreen(
            id:doc['TransID'],

          );
        }));*/
                            },
                            child: Container(

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(17, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                doc['createdAt'].toString(),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Congratulations',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Your loan of Mwk ${(doc['total'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00 at ${doc['percentages']}% interest has been accepted',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                      }
                  );}}),

          SizedBox(
            height: 20,
          ),


        ],
      ),



    );
  }
}
