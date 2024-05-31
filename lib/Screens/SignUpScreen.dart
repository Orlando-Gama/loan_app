import 'package:flutter/material.dart';
import 'package:tadza_loan/Screens/LoadingScreen.dart';
import 'package:tadza_loan/Screens/LoginScreen.dart';
import 'package:tadza_loan/Screens/RegisterUserScreen.dart';
import 'package:tadza_loan/theme/custom_text_style.dart';
import 'package:tadza_loan/theme/theme_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  late bool passwordVisible;
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  bool isLoading = false;
  void validator(BuildContext context){
    if (emailController.text.isEmpty &&
        passwordController.text.isEmpty &&
        numberController.text.isEmpty
    ){

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your all fields",
              style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );
    }else if(emailController.text.isEmpty ){


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your Email",
              style: TextStyle(fontSize: 16)),
              backgroundColor: Colors.red,
              dismissDirection: DismissDirection.up,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 150,
                  left: 10,
                  right: 10))
      );

    }else if(passwordController.text.isEmpty ){


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(


            content: Text("Please enter your Password",
                style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),

          )
      );

    }else if(numberController.text.isEmpty ){


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(


            content: Text("Please enter your Fullname",
                style: TextStyle(fontSize: 16)),
            backgroundColor: Color(0xffa4c639),
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),

          )
      );

    }
    else{
      loading(context);
      setState(() {
        isLoading = true;
      });
      SignUp(context);
    }
  }

  void  SignUp(BuildContext context)async{
    setState(() {
      isLoading = true;
    });
    try {
      firebase_auth.UserCredential userCredential =
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print(userCredential.user!.email);
      setState(() {
        isLoading = false;
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RegisterUserScreen(

            email: emailController.text,
            password:passwordController.text,
            number : numberController.text,



          )),
              (route) => false);


    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {
        isLoading = false;
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen(

          )),
              (route) => false);
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

                              SizedBox(height: 80,),

                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Color(0XFF292929),
                                    fontSize: 30,
                                    fontFamily: 'Hamon',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 110,),



                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: SizedBox(
                                  width:   double.maxFinite,
                                  child: TextFormField(
                                    scrollPadding:
                                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    controller: emailController,

                                    autofocus: true,
                                    style:  CustomTextStyles.titleMediumInterGray700Medium,

                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText:  "Enter email",
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


                              /* SizedBox(height: 14 ),
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
                                      hintText:  "Enter Fullname",
                                      hintStyle:  CustomTextStyles.titleMediumInterGray700Medium,
                                      prefixIcon: Icon(
                                        Icons.person_outline_outlined,
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

                                  ),
                                ),
                              ),*/
                              SizedBox(height: 14 ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: SizedBox(
                                  width:   double.maxFinite,
                                  child: TextFormField(
                                    scrollPadding:
                                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    controller: numberController,

                                    autofocus: true,
                                    style:  CustomTextStyles.titleMediumInterGray700Medium,

                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText:  "Enter contact number",
                                      hintStyle:  CustomTextStyles.titleMediumInterGray700Medium,
                                      prefixIcon: Icon(
                                        Icons.phone_outlined,
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
                                padding: EdgeInsets.symmetric(horizontal: 20.0 ),
                                child: SizedBox(
                                  width:   double.maxFinite,
                                  child: TextFormField(
                                    scrollPadding:
                                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    controller: passwordController,

                                    autofocus: true,
                                    style:   CustomTextStyles.titleMediumInterGray700Medium,
                                    obscureText: passwordVisible,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText:  "Enter password",
                                      hintStyle:   CustomTextStyles.titleMediumInterGray700Medium,
                                      prefixIcon:  Icon(
                                        Icons.lock_outlined,
                                        size: 15,
                                        color: Colors.black,
                                      ),

                                      suffixIcon: IconButton(
                                        iconSize: 15,
                                        icon: Icon(
                                          passwordVisible
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            passwordVisible = !passwordVisible;
                                          });
                                        },
                                      ),
                                      suffixIconConstraints:  BoxConstraints(
                                        maxHeight: 56 ,
                                      ),
                                      isDense: true,
                                      contentPadding:
                                      EdgeInsets.only(
                                        left: 16,
                                        top: 16,
                                        bottom: 16,
                                      ),
                                      fillColor:  theme.colorScheme.primary,

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

                                  ),
                                ),
                              ),


                              SizedBox(height: 13 ),

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
                                      validator(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox.shrink(),
                                        Text(
                                          "Sign Up",
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
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()),
                                    );
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Already have an account? ",
                                          style: theme.textTheme.bodyLarge!.copyWith(
                                            color: Color(0XFF696969),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Login",
                                          style:theme.textTheme.titleMedium!.copyWith(
                                            color: Color(0XFF151515),
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
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
