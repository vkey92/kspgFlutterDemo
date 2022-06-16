import 'package:flutter/material.dart';
import 'package:kspg/screens/Dashboard.dart';
import 'dart:async';

import 'package:kspg/screens/login.dart';

import '../common/Common.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>{
  @override
  void initState() {
    super.initState();
    checkForPref();
  }

  checkForPref() async {
    String checkLogin = await Common.getPreferences("login");
    if(checkLogin == "true"){
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Dashboard())));
    }else{
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Login())));
    }
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
        child: Center(
          child: Image.asset("assets/images/kspglogo.png",color: Colors.white,),
        ) 
      ),
    );
  }
  
}