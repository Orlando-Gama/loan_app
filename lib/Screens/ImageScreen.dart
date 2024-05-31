import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tadza_loan/DBFILES.dart';
import 'package:tadza_loan/Models/TransactionModel.dart';
import 'package:tadza_loan/RootApp.dart';
import 'package:tadza_loan/Screens/GetImages.dart';
import 'package:tadza_loan/Screens/LoadingScreen.dart';
import 'package:tadza_loan/Screens/SuccessfulScreen.dart';
import 'package:tadza_loan/Screens/UnSuccessfulScreen.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key,

  required this.total,
  required this.type,
  required this.amount,
  required this.category,
  required this.fee,
  required this.percentage,
  required this.period,

  });

  final total;
  final type;
  final amount;
  final category;
  final fee;
  final percentage;
  final period;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final key = GlobalKey<FormState>();
  List<XFile>? imageFileList = [];
  List<File> images = [];

  DocumentReference ref = FirebaseFirestore.instance.collection("transactions").doc();

  void validate (){

    if(imageFileList!.length<2){

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select atleast 5 images"))
      );

    }else{
      publishProduct();
      // uploadImage();
    }

  }

  bool validateForm() {
    if (!key.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Fill all necessary fields.",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER,    // location
          timeInSecForIosWeb: 1               // duration
      );
      return false;
    }

    if (images!.length<1) {
      // You can add a message or handle the case where no images are selected
      print("No images selected");
      Fluttertoast.showToast(
          msg: "No images selected.",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER,    // location
          timeInSecForIosWeb: 1               // duration
      );
      return false;
    }

    return true; // Form validation passed
  }


  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  Future<void> publishProduct() async {

    try {
      final pid = generateRandomString(15);
      var dateformat = DateFormat("MMM d, yyyy");
      var timeformat = DateFormat("MMM d, yyyy");
      String date = dateformat.format(DateTime.now()).toString();
      String time = timeformat.format(DateTime.now()).toString();

      // Validate the form using a function and check if images are selected
      if (validateForm()) {
        // Show a loading indicator
        loading(context);

        // Create a new product
        final product prod = product();






        prod.category = widget.category.toString() ;
        prod.createdAt = date;
        prod.amount = widget.amount;
        prod.transid = ref.id;

        prod.percentages = widget.percentage ;
        prod.time = time;
        prod.type = widget.type.toString()  ;

        prod.total = widget.total.toInt();
        prod.uid = FirebaseAuth.instance.currentUser!.uid;

        prod.fee = widget.fee.toString() ;
        prod.period = widget.period.toString() ;

        prod.status = "Pending";
        prod.seen= "NO";
        prod.confirmed = "NO";
        prod.image = [];




        for (final image in images!) {
          final urlImage = await DBproduct().uploadImage(image, path: 'SUIMAGES', );
          if (urlImage != null) {
            prod.image!.add(urlImage);
          }
        }

        // Check if all images are successfully uploaded
        if (images!.length == prod.image!.length) {
          // Save the product
          final isSaved = await DBproduct().saveProduct(prod);
          if (isSaved) {
            // Close the loading indicator and navigate back
          Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => SuccessfulScreen(

                 id: ref.id,



               )));
           ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Succesfully Done ", style: TextStyle(fontSize: 16)),
                  backgroundColor: Colors.green,
                  dismissDirection: DismissDirection.up,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 150,
                      left: 10,
                      right: 10),)
            );


          }
        }
      } else {
        print('Form validation or image selection failed.');

      }
    } catch (error) {
      print('An error occurred: $error');
      // Navigator.of(context).pop(); // close loader
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UnSuccessfulScreen(



          )));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$error", style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
          key: key,
          child:
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 24 , vertical: 11 ),
            child: Center(
              child: Column(
                children: [

                  SizedBox(height: 38 ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          width: 317 ,
                          child:  Text(
                            "Choose collateral images",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.5)),
                          ),)),



                  SizedBox(height: 20,),

                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(crossAxisCount: 2, //
                            //scrollDirection: Axis.horizontal, //set this for horizontal scroll direction
                            shrinkWrap: true,
                            children:(images ?? []).asMap().entries.map((entry)
                            {

                              final index = entry.key;
                              final e = entry.value;
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: SizedBox(
                                    height: 161,
                                    width: 159,
                                    child:  Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(


                                              borderRadius: BorderRadius.all(Radius.circular(25)),
                                              image: DecorationImage(
                                                  image: FileImage(
                                                    File(e.path),
                                                  ),
                                                  fit: BoxFit.cover
                                              ),
                                            ),

                                          ),SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: Container(
                                                height: 40,
                                                width: 40,
                                                padding: EdgeInsets.all(9),
                                                decoration:BoxDecoration(
                                                  color: Colors.red[200],
                                                  borderRadius: BorderRadius.circular(15 ),
                                                ),
                                                  child: SvgPicture.asset(
                                                  "assets/images/close-ellipse-svgrepo-com.svg",

                                                  fit:   BoxFit.cover,
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.topRight,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  images?.removeAt(index);
                                                });
                                              },
                                            ),
                                          ),


                                        ]
                                    )
                                ),
                              );
                            }).toList()
                        ),
                      )
                  )
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.image_outlined,
          color: Colors.white,),
        backgroundColor: Color(0xFFFF3378) ,
        onPressed: ()async{
          // selectImages();

          final data = await showModalBottomSheet(
              context: context, builder: (ctx){

            return GetImage();
          });
          if(data != null)
            setState((){
              images.add(data);
            });
        },
      ),
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
                  publishProduct();
                  // validator();
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
