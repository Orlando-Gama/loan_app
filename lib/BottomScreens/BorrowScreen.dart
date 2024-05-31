import 'package:flutter/material.dart';
import 'package:tadza_loan/RootApp.dart';
import 'package:tadza_loan/Screens/ImageScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tadza_loan/theme/custom_text_style.dart';
import 'package:tadza_loan/theme/theme_helper.dart';

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({super.key});

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  int activeDay         = 3;
  int activeCategory    = 0;
  String selectedChoice = "";

  double one   = 25;
  double two   = 35;
  double four  = 45;
  double eight = 60;


  double _totalTip    = 0;
  double _totalAmount = 0;

  void initState() {
    super.initState();
  }

  void _updateAmounts() {
    setState(() {
      _totalTip = _billAmount * one / 100;
      _totalAmount = _billAmount + _totalTip + 1000;
    });
  }


  @override
  void dispose() {
    super.dispose();
  }
  String selectedChoice1 = "";
  int _billAmount = 0;
  TextEditingController _budgetName =
  TextEditingController(text: "Grocery Budget");
  TextEditingController _budgetPrice = TextEditingController(text: "\$1500.00");
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>RootApp(

                          )),
                              (route) => false);
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

        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Text(
                  "Choose transaction category",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.5)),
                ),
              ),
              /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children:[ GestureDetector(
                        onTap: () {
                          setState(() {
                            activeCategory = 0;
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
                                    color: activeCategory == 0
                                        ? primary
                                        : Colors.transparent),
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
                                          color: grey.withOpacity(0.15)),
                                      child: Center(
                                        child: Image.asset(
                                          "",
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.contain,
                                        ),
                                      )),
                                  Text(
                                   "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )])),*/
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: <Widget>[
                        Container(




                          child: ChoiceChip(
                            label: Text("Borrow Money", style: TextStyle(
                              color: (selectedChoice == "Borrow Money") ?  Colors.white70 : Colors.black,
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),),
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            iconTheme: IconThemeData(
                                color: Colors.white
                            ),
                            backgroundColor: Color(0xffededed),
                            selectedColor: Color(0xFFFF3378),
                            selected: selectedChoice == "Borrow Money",
                            onSelected: (selected) {
                              setState(() {
                                selectedChoice = "Borrow Money";
                              });
                            },
                          ),
                        ) ,

                        Container(

                          child: ChoiceChip(
                            label: Text("Request Money", style: TextStyle(
                              color: (selectedChoice == "Request Money") ?   Colors.white70 : Colors.black,
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),),
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: Color(0xffededed),
                            iconTheme: IconThemeData(
                              color: Colors.white
                            ),
                            selectedColor: Color(0xFFFF3378),
                            selected: selectedChoice == "Request Money",
                            onSelected: (selected) {
                              setState(() {
                                selectedChoice = "Request Money";
                              });
                            },
                          ),
                        ) ,
                      ],
                    )),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 0),
                child: Text(
                  "Enter required amount",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.5)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width:   double.maxFinite,
                  child: TextFormField(
                    initialValue: _billAmount.toString(),
                    keyboardType:  TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (val) {
                      _billAmount = int.tryParse(val) ?? 0;
                      _updateAmounts();
                    },
                    scrollPadding:
                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    //controller: emailController,

                    autofocus: true,
                    style:  CustomTextStyles.titleMediumInterGray700Medium,

                    textInputAction: TextInputAction.done,
                   // keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText:  "Amount",
                      hintStyle:  CustomTextStyles.titleMediumInterGray700Medium,

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
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 0),
                child: Text(
                  "Choose loan category",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.5)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: <Widget>[
                        Container(




                          child: ChoiceChip(
                            label: Text("1 Week", style: TextStyle(
                              color: (selectedChoice1 == "1 Week") ?  Colors.white70 : Colors.black,
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),),
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: Color(0xffededed),
                            iconTheme: IconThemeData(
                                color: Colors.white
                            ),
                            selectedColor: Color(0xFFFF3378),
                            selected: selectedChoice1 == "1 Week",
                            onSelected: (selected) {
                              setState(() {
                                selectedChoice1 = "1 Week";
                              });
                            },
                          ),
                        ) ,

                        Container(

                          child: ChoiceChip(
                            label: Text("2 Weeks", style: TextStyle(
                              color: (selectedChoice1 == "2 Weeks") ?   Colors.white70 : Colors.black,
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),),
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: Color(0xffededed),
                            iconTheme: IconThemeData(
                                color: Colors.white
                            ),
                            selectedColor: Color(0xFFFF3378),
                            selected: selectedChoice1 == "2 Weeks",
                            onSelected: (selected) {
                              setState(() {
                                selectedChoice1 = "2 Weeks";
                              });
                            },
                          ),
                        ) ,

                        Container(




                          child: ChoiceChip(
                            label: Text("1 Month", style: TextStyle(
                              color: (selectedChoice1 == "1 Month") ?  Colors.white70 : Colors.black,
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),),
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: Color(0xffededed),
                            iconTheme: IconThemeData(
                                color: Colors.white
                            ),
                            selectedColor: Color(0xFFFF3378),
                            selected: selectedChoice1 == "1 Month",
                            onSelected: (selected) {
                              setState(() {
                                selectedChoice1 = "1 Month";
                              });
                            },
                          ),
                        ) ,

                        Container(

                          child: ChoiceChip(
                            label: Text("2 Months", style: TextStyle(
                              color: (selectedChoice1 == "2 Months") ?   Colors.white70 : Colors.black,
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),),
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: Color(0xffededed),
                            iconTheme: IconThemeData(
                              color: Colors.white
                          ),
                            selectedColor: Color(0xFFFF3378),
                            selected: selectedChoice1 == "2 Months",
                            onSelected: (selected) {
                              setState(() {
                                selectedChoice1 = "2 Months";
                              });
                            },
                          ),
                        ) ,
                      ],
                    )),
              ),
              SizedBox(height: 10,),

            /*  (selectedChoice == "Request Money") ?   Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 0),
                    child: Text(
                      "Enter required percentage",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width:   double.maxFinite,
                      child: TextFormField(
                        scrollPadding:
                        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        //controller: emailController,

                        autofocus: true,
                        style:  CustomTextStyles.titleMediumInterGray700Medium,

                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText:  "Percentage",
                          hintStyle:  CustomTextStyles.titleMediumInterGray700Medium,

                          isDense: true,
                          contentPadding:
                          EdgeInsets.only(
                            left: 16,
                            top: 16,
                            bottom: 16,
                          ),
                          *//* fillColor:  theme.colorScheme.primary,
                  filled: filled,*//*
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
                        *//*validator: validator,*//*
                      ),
                    ),
                  ),
                ],
              ):SizedBox(),*/


              Divider(),
              SizedBox(height: 10,),


                  (selectedChoice1 == "1 Week") ?
                  Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          "Mwk ${(_billAmount.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
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
                          one.toString(),
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
                          "Mwk 1,000.00",
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
                          "1 Week",
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
                            "Mwk ${("${_billAmount + _billAmount * one / 100 + 1000}".toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}0",
                             style: const TextStyle(

                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(

                      width: context.width() * 0.5,
                      child: AppButton(
                          text: "Add Images",
                          color:Color(0xFF000000),
                          textColor: Colors.white,
                          shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          width: context.width(),
                          onTap: () {
                            double total =  _billAmount + _billAmount * one / 100 + 1000;

                            ImageScreen(
                                total: total,
                                type: selectedChoice,
                                amount: _billAmount,
                                category: selectedChoice1,
                                fee: "1,000.00",
                                percentage: one,
                                period: "1 Week"
                            ).launch(context);



                            // processPayment();
                            //validator();
                            // BottomNavigationBarCustom().launch(context);
                          }),
                    ),
                  ),
                ],
              )
                  : (selectedChoice1 == "2 Weeks") ?
                  Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              "Mwk ${(_billAmount.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
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
                              "35%",
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
                              "Mwk 1,000.00",
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
                              "2 Weeks",
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
                              "Mwk ${("${_billAmount + _billAmount * two / 100 + 1000}".toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}0",

                              style: const TextStyle(

                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(

                          width: context.width() * 0.5,
                          child: AppButton(
                              text: "Add Images",
                              color:Color(0xFF000000),
                              textColor: Colors.white,
                              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              width: context.width(),
                              onTap: () {
                                double total =  _billAmount + _billAmount * two / 100 + 1000;

                                ImageScreen(
                                    total: total,
                                    type: selectedChoice,
                                    amount: _billAmount,
                                    category: selectedChoice1,
                                    fee: "1,000.00",
                                    percentage: two,
                                    period: "2 Weeks"
                                ).launch(context);
                                // processPayment();
                                //validator();
                                // BottomNavigationBarCustom().launch(context);
                              }),
                        ),
                      ),
                    ],
                  )
                      : (selectedChoice1 == "1 Month") ?
                  Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              "Mwk ${(_billAmount.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
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
                              "45%",
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
                              "Mwk 1,000.00",
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
                              "1 Month",
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
                              "Mwk ${("${_billAmount + _billAmount * four / 100 + 1000}".toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}0",
                              style: const TextStyle(

                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(

                          width: context.width() * 0.5,
                          child: AppButton(
                              text: "Add Images",
                              color:Color(0xFF000000),
                              textColor: Colors.white,
                              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              width: context.width(),
                              onTap: () {

                                double total =  _billAmount + _billAmount * four / 100 + 1000;

                                ImageScreen(
                                    total: total,
                                    type: selectedChoice,
                                    amount: _billAmount,
                                    category: selectedChoice1,
                                    fee: "1,000.00",
                                    percentage: four,
                                    period: "1 month"
                                ).launch(context);
                                // processPayment();
                                //validator();
                                // BottomNavigationBarCustom().launch(context);
                              }),
                        ),
                      ),
                    ],
                  )
                      : (selectedChoice1 == "2 Months") ?
                  Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              "Mwk ${(_billAmount.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
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
                              "60%",
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
                              "Mwk 1,000.00",
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
                              "2  Months",
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
                              "Mwk ${("${_billAmount + _billAmount * eight / 100 + 1000}".toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}0",
                              style: const TextStyle(

                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(

                          width: context.width() * 0.5,
                          child: AppButton(
                              text: "Add Images",
                              color:Color(0xFF000000),
                              textColor: Colors.white,
                              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              width: context.width(),
                              onTap: () {


                                double total =  _billAmount + _billAmount * eight / 100 + 1000;

                                ImageScreen(

                                 total: total,
                                 type: selectedChoice,
                                  amount: _billAmount,
                                  category: selectedChoice1,
                                  fee: "1,000.00",
                                  percentage: eight,
                                 period: "2 months"


                                ).launch(context);
                                // processPayment();
                                //validator();
                                // BottomNavigationBarCustom().launch(context);
                              }),
                        ),
                      ),
                    ],
                  ) :
                  Container(),




            ],
          ),
        )

    );
  }
}
