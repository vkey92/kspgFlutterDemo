import 'package:flutter/material.dart';
import 'package:kspg/common/Common.dart';

import '../api/ApiServices.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<Forgot> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  String? _otp, apiToken = "";
  bool viewVisible = false,viewUpper = true,viewPass = false;
  
  void showWidget(String checkForVisible) {
    setState(() {
      if(checkForVisible == "otp")
      viewVisible = true;
      else if(checkForVisible == "sendcode")
        viewUpper = true;
      else
        viewPass = true;
          
    });
  }

  void hideWidget(String checkForVisible) {
    setState(() {
      if(checkForVisible == "otp")
      viewVisible = false;
      else if(checkForVisible == "sendcode")
        viewUpper = false;
      else 
        viewPass = false;
    });
  }

  callSendCodeApi() {
    Common.showLoaderDialog(context);

    final service = ApiServices();
    service.sendCode(userNameController.text).then((value) {
      if (value.status == false) {
        print("response sendcode >>>>>> " + value.message!);
        Common.showToast(value.message.toString(), "red");
      } else {
        showWidget("otp");
        hideWidget("sendcode");
      }

      Navigator.pop(context);
    });
  }

  callVerifyCodeApi() {
    Common.showLoaderDialog(context);

    final service = ApiServices();
    service.verifyOtp({
      "username" : userNameController.text,
      "code" : _otp
    }).then((value) {
      if (value.status == false) {
        print("response verfy >>>>>> " + value.message!);
        Common.showToast(value.message.toString(), "red");
      } else {
        apiToken = value.token.toString();
        Common.SetPreferences("token", value.token.toString());
        showWidget("pass");
        hideWidget("sendcode");
      }

      Navigator.pop(context);
    });
  }

  callResetPassApi() {
    Common.showLoaderDialog(context);

    final service = ApiServices();
    service.resetPassword({
      "password" : passController.text
    },apiToken!).then((value) {
      if (value.status == false) {
        print("response reset >>>>>> " + value.message!);
        Common.showToast(value.message.toString(), "red");
      } else {
        Common.showToast(value.message.toString(), "green");
        Navigator.pop(context);
      }

      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mainback.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('assets/images/kspglogo.png')),
                ),
              ),
              Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewUpper,
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: new TextField(
                        controller: userNameController,
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          labelText: 'Username *',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
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
                          if (userNameController.text.isEmpty)
                            Common.showToast(
                                "Please enter your registered username", "red");
                          else
                            callSendCodeApi();
                        },
                        child: Text(
                          'SEND CODE',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ])),
              
              Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewVisible,
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtpInput(_fieldOne, true),
                          OtpInput(_fieldTwo, false),
                          OtpInput(_fieldThree, false),
                          OtpInput(_fieldFour, false),
                          OtpInput(_fieldFive, false),
                          OtpInput(_fieldSix, false)
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
                          if (_otp!.isEmpty)
                            Common.showToast("Enter sent OTP", "red");
                          else
                            callVerifyCodeApi();
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
                    Text(
                      'Did not receive a verification code?',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     TextButton(
                      onPressed: () {
                       callSendCodeApi();
                      },

                      child: Text("Resend Code",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                    
                   
                  ])),

              Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewPass,
                  child: Column(children: <Widget>[
                    
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: new TextField(
                        controller: passController,
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.white),
                          ),
                          labelText: 'Password *',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: new TextField(
                        controller: confirmPassController,
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.white),
                          ),
                          labelText: 'Confirm Password *',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
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
                          if (passController.text.isEmpty)
                            Common.showToast("Enter your password", "red");
                          else if (confirmPassController.text.isEmpty)
                            Common.showToast("Re-enter your password", "red");
                          else if (passController.text != confirmPassController.text)
                            Common.showToast("Password does not match.", "red");
                          else
                            callResetPassApi();
                          
                           
                        },
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ])),
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
        style: TextStyle(color: Colors.white),
        //autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: Colors.white),
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
