import 'package:flutter/material.dart';
import 'package:kspg/screens/Dashboard.dart';
import 'package:kspg/screens/History.dart';
import 'package:kspg/screens/Manual.dart';
import 'package:kspg/screens/Otpscreen.dart';
import 'package:kspg/screens/Profile.dart';
import 'package:kspg/screens/RedemptionHistory.dart';
import 'package:kspg/screens/login.dart';
import 'package:kspg/screens/splash.dart';
import 'package:kspg/screens/Register.dart';
import 'package:kspg/screens/Forgot.dart';



void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "KSPG",
        home: Scaffold(body: Splash()));
  }
}
