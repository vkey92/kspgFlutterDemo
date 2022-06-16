import 'package:flutter/material.dart';
import 'package:kspg/screens/Dashboard.dart';

import '../api/ApiServices.dart';
import '../common/Common.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otpscreen> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  String? _otp;
  String phoneValue  = "", apiToken = "";

  callOtpVerify() {
    Common.showLoaderDialog(context);
    print("token >>> "+apiToken);
    print("otp >>> "+_otp!);
    final service = ApiServices();
    service.otpVerify(
      {
        "otp_token": _otp,
        "device_id": "dummy123"
      },
        apiToken
        
    ).then((value) {
      Navigator.pop(context);
      if (value.status == false) 
        Common.showToast("OTP did not match", "red");
       else {
         print('firstname = '+value.userData!.first_name);
         print('lastname = '+value.userData!.last_name);
         print('token = '+value.token.toString());
         Common.SetPreferences("token", value.token.toString());
         Common.SetPreferences("brandtype", value.myBrand?.type ?? "");
         Common.SetPreferences("brandid",value.myBrand?.brand_id ?? "");
         Common.SetPreferences("login", "true");
         
        Common.showToast("OTP match successfully", "green");
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(builder: (context) => Dashboard()),
               (Route<dynamic> route) => false,
         );

        
      }



    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForPref();
  }
  
  checkForPref() async {
    
    String phone = await Common.getPreferences("phone");
    String token = await Common.getPreferences("token");
    
    setState(() {
      phoneValue = phone;
      apiToken = token; 
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(phoneValue);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mainback.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 80.0),
                  height: 70.0,
                  child: new Row(
                    children: <Widget>[
                      VerticalDivider(
                        thickness: 5,
                        color: Colors.white,
                      ),
                      Column(children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text('Verifying          ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0))),
                        Container(
                            margin: const EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Text('Mobile Number',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0)))
                      ])
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                    "Enter 4 digit code sent to your mobile +91 "+phoneValue,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal)
                    
                ),
              ),
              
              Card(
                margin: EdgeInsets.only(top: 40.0,left: 20,right: 20),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child:  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OtpInput(_fieldOne, true),
                            OtpInput(_fieldTwo, false),
                            OtpInput(_fieldThree, false),
                            OtpInput(_fieldFour, false),

                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 40.0),
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: const Color(0xff990063b4),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            _otp = _fieldOne.text +
                                _fieldTwo.text +
                                _fieldThree.text +
                                _fieldFour.text;
                            if(_otp!.isEmpty)
                              Common.showToast("Enter sent OTP", "red");
                            else
                              callOtpVerify();
                          },
                          child: Text(
                            'VERIFY',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Text('Did not receive a verification code?',
                        style: TextStyle(
                            color: Colors.grey),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Text('Resend Code',
                        style: TextStyle(
                            color: const Color(0xff990063b4),fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                    ]
                ),
               
               
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 45,
      child: TextField(
        style: TextStyle(color: const Color(0xff990063b4)),
        //autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: const Color(0xff990063b4))
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: const Color(0xff990063b4)),
            ),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
