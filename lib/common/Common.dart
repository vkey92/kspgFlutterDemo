import 'package:ars_progress_dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common {
  static String mainurl = "http://v1qa-api.aftersell.care/";
  static String adharcardno = "",panno = "",drivingno = "",gender = "",mobilenumber = "",mobilenumber1 = "",emailid = "",dob = "",userid = "",firstname = "",middlename = "",shopName = "",
      lastname = "",address1 = "",adress2 = "",county = "",state = "",city = "",zip = "",area = "",workshopsize = "",servicepermonth = "",expyear = "",items = "",retailorcode = "",retailorname = "",
      dealercode = "",dealername = "",profilepicture = "",workshopicture = "",profilepictureurl = "",workshopictureurl = "",salesturnover = "",
      bankname = "",ifscCode = "",acNo = "",acPicture = "",acPictureUrl = "",banHoldeName = "",bankMicr = "" ,token = "";

  static late Color colorCode;
  static late AlertDialog alert;
  late SharedPreferences sharedPrefs;
  static late ArsProgressDialog customProgressDialog;
  static bool isValidEmail(String em) {
    bool emailValid =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(em);
    print(emailValid);
    return emailValid;
  }

  static void showToast(String body, String colorValue) {
    if (colorValue == 'red')
      colorCode = Colors.red;
    else if (colorValue == 'green') colorCode = Colors.green;

    Fluttertoast.showToast(
        msg: body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: colorCode,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showLoaderDialog(BuildContext context) {
    customProgressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));

    customProgressDialog.show(); // show dialog
   
    
  }

  static void hideLoaderDialog(BuildContext context) {
    customProgressDialog.dismiss();
  }

  static SetPreferences(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
   
  }

  static getPreferences(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    final String value = myPrefs.getString(key) ?? "";
    return value;
  }

   static Handlenull(String value) {
    String check = "";
    if (value != "null")
      check = value;
    return check;
  }

 static  openAlertBox(BuildContext context,String title,String couponValue) {
   Color myColor = Color(0xff0063b4);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: myColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Text(
                      couponValue,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: myColor),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          color: myColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if(title == 'Succeed'){
                              
                            }
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
  
  
  
}
