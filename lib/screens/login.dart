import 'package:flutter/material.dart';
import 'package:kspg/screens/Forgot.dart';
import 'package:kspg/screens/Otpscreen.dart';
import 'package:kspg/screens/Register.dart';
import '../api/ApiServices.dart';
import '../common/Common.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  loginState createState() => loginState();
}

class loginState  extends State<Login> {
  TextEditingController userController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  bool validate() {
    bool valid = true;
    if (userController.text.isEmpty) {
      Common.showToast("Enter your username.","red");
      valid = false;
    } else if (passController.text.isEmpty) {
      Common.showToast("Enter your valid password.","red");
      valid = false;
    } 
    return valid;
  }

  callLoginApi() {
    Common.showLoaderDialog(context);

    final service = ApiServices();
    service.attemptLogin(
      {
        "username": userController.text,
        "password": passController.text,
        "device_id": "dummy123",
      
      },

    ).then((value) {
      Navigator.pop(context);
      if (value.status == false) {
        print("response login >>>>>> " + value.message!);
        Common.showToast(value.message.toString(), "red");
      } else {
        print( value.token.toString());
        print( value.email.toString());
        print( value.phone.toString());
        Common.token = value.token.toString();
        Common.SetPreferences("token", value.token.toString());
        Common.SetPreferences("login", "true");
        Common.SetPreferences("username", userController.text);
        Common.SetPreferences("userid", value.id.toString());
        Common.SetPreferences("email", value.email.toString());
        Common.SetPreferences("phone", value.phone.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Otpscreen()),
        );
      }
    


    });
  }
  
  @override
  Widget build(BuildContext context) {
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
              Container(
                child: new TextField(
                  controller: userController,
                  style : TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    labelText: 'Username',
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
                margin: const EdgeInsets.only(top: 30.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: passController,
                  style : TextStyle(
                    color: Colors.white,
                  ),
                  obscureText: true,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text("Register Organisation",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline)),
                    )),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Forgot()),
                        );
                      },
                          
                      child: Text("Forgot Password",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          )),
                    )),
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
                   if(validate())
                     callLoginApi();
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
