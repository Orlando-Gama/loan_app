import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tadza_loan/BottomNav.dart';
import 'package:tadza_loan/RootApp.dart';
import 'package:tadza_loan/Screens/LoadingScreen.dart';
//import 'package:tadza_loan/BottomNav.dart';
import 'package:tadza_loan/theme/custom_text_style.dart';
import 'package:tadza_loan/theme/theme_helper.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key, required this.email, required this.number, required this.password});


  final password;
  final email;
  final number;

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  void _dialog(){
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: Text("Please choose an option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    _fromCamera();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera,

                        ),
                      ),
                      Text("Camera")
                    ],
                  ),
                ),

                InkWell(
                  onTap: (){
                    _fromGallery();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,

                        ),
                      ),
                      Text("Gallery")
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _fromCamera() async{
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _fromGallery() async{
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(String filePath) async{
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath, maxHeight: 1080, maxWidth: 1080,
    );

    if(croppedImage != null){
      setState(() {
        imageFile = File(croppedImage.path);
        //  _updateUseImage();
      });
    }
  }
  File? imageFile;

  void validator (){
    if (
    fullnameController.text.isEmpty &&
        imageFile == null){

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("All fields are required...",
              style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );
    }

    else if(fullnameController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your address",
              style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );
    }

    else if(imageFile == null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select your profile image",
              style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );
    }
    else{


      loading(context);



      setState(() {
        isLoading = true;
      });
      //  addAddress();
      UploadImage();
    }
  }

  void UploadImage(){

    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference = FirebaseStorage.instance.ref().child("profiles").child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(imageFile!);
    uploadTask.then((TaskSnapshot taskSnapshot){
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        setState(() {
          isLoading = true;
        });

        UploadDetails(imageUrl);

      });
    }).catchError((onError){

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(onError.toString(),
              style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)

      );

      setState(() {
        isLoading = false;
      });
    });


  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  String generateRandomNumber(int len) {
    var r = Random();
    const _chars = '1928374655647382910';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
  void UploadDetails(image)async{
    String addressId = generateRandomString(15);
    String cardnumber = generateRandomNumber(16);

    var dateformat = DateFormat("MMM d, yyyy");
    var timeformat = DateFormat("MMM d, yyyy");
    String date = dateformat.format(DateTime.now()).toString();
    String date2 = dateformat.format(DateTime.now().add(Duration(days: 90))).toString();


    String time = timeformat.format(DateTime.now()).toString();
    await FirebaseFirestore.instance.collection('sellers').doc(FirebaseAuth.instance.currentUser?.uid).set({
      'name': fullnameController.text,

      "email":widget.email,
      'number': widget.number,
      'profilePic': image,
      'address': addressController.text,
      'time': time,
      'cardnumber': cardnumber,
      'password': widget.password,
      'carddate': date,
      "uid": FirebaseAuth.instance.currentUser?.uid,

      "date":  date,
    }).whenComplete(()  {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User details added successfully",
              style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.green,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
      {
        return RootApp(

        );
      }));
      setState(() {
        isLoading = false;
      });
    }).catchError((error){
      setState((){
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString(),
              style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
            ),
            child: SizedBox(

                child: Form(
                    key: _formKey,
                    child: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: 100,),

                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Add user details",
                                  style: TextStyle(
                                    color: Color(0XFF292929),
                                    fontSize: 30,
                                    fontFamily: 'Hamon',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30,),

                              Center(
                                child:
                                Stack(
                                    children:[
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: imageFile == null
                                            ? AssetImage("assets/images/user-profile-icon-free-vector.jpg")
                                            : Image.file(imageFile!).image,

                                      ),
                                      Positioned(
                                          right: -10,
                                          bottom: -15,
                                          child: Container(
                                            decoration: const BoxDecoration(shape: BoxShape.circle),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                size: 26,
                                                color: Color(0xff000000),
                                              ),
                                              onPressed: () {
                                                _dialog();
                                              },
                                            ),
                                          ))
                                    ]
                                ),
                              ),

                              SizedBox(height: 30,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: SizedBox(
                                  width:   double.maxFinite,
                                  child: TextFormField(
                                    scrollPadding:
                                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    controller: fullnameController,

                                    autofocus: true,
                                    style:  CustomTextStyles.titleMediumInterGray700Medium,

                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText:  "Enter fullname",
                                      hintStyle:  CustomTextStyles.titleMediumInterGray700Medium,
                                      prefixIcon: Icon(
                                        Icons.mail_outlined,
                                        size: 15,
                                        color: Colors.black,
                                      ),

                                      isDense: true,
                                      contentPadding:
                                      EdgeInsets.only(
                                        left: 16,
                                        top: 16,
                                        bottom: 16,
                                      ),
                                      /* fillColor:  theme.colorScheme.primary,
              filled: filled,*/
                                      border:
                                      OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: appTheme.blueGray100,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder:
                                      OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: appTheme.blueGray100,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: appTheme.blueGray100,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    /*validator: validator,*/
                                  ),
                                ),
                              ),


                              SizedBox(height: 14 ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: SizedBox(
                                  width:   double.maxFinite,
                                  child: TextFormField(
                                    scrollPadding:
                                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    controller: addressController,


                                    autofocus: true,
                                    style:  CustomTextStyles.titleMediumInterGray700Medium,

                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText:  "Enter address",
                                      hintStyle:  CustomTextStyles.titleMediumInterGray700Medium,
                                      prefixIcon: Icon(
                                        Icons.mail_outlined,
                                        size: 15,
                                        color: Colors.black,
                                      ),

                                      isDense: true,
                                      contentPadding:
                                      EdgeInsets.only(
                                        left: 16,
                                        top: 16,
                                        bottom: 16,
                                      ),
                                      /* fillColor:  theme.colorScheme.primary,
              filled: filled,*/
                                      border:
                                      OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: appTheme.blueGray100,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder:
                                      OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: appTheme.blueGray100,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: appTheme.blueGray100,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    /*validator: validator,*/
                                  ),
                                ),
                              ),


                              SizedBox(height: 14 ),



                              Align(
                                alignment:   Alignment.center,
                                child: Container(
                                  height:  56,
                                  width:  double.maxFinite,
                                  margin: EdgeInsets.symmetric(horizontal: 20.0 ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.onError,
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      elevation: MaterialStateProperty.all<double>(0),
                                    ),
                                    onPressed: () {
                                      validator();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox.shrink(),
                                        Text(
                                          "Register User",
                                          style: TextStyle(
                                            color: Color(0XFFFFFFFF),
                                            fontSize: 18 ,
                                            fontFamily: 'Hamon',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 25 ),

                              SizedBox(height: 11 ),

                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  width: 500,
                                  child: Divider(),
                                ),
                              ),






                            ]

                        )
                    )
                )
            )
        )


    );
  }
}
