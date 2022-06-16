import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kspg/common/Common.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../api/ApiServices.dart';

class Manual extends StatefulWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  String apiToken = '';
  Color myColor = Color(0xff0063b4);
  TextEditingController couponController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForPref();
  }

  checkForPref() async {
    String token = await Common.getPreferences("token");
  
    setState(() {
      apiToken = token;
    });
  }
  
  callScanApi(String coupons) {
    Common.showLoaderDialog(context);
    final service = ApiServices();
    service.insertScan({
      "coupons": coupons,
    }, apiToken).then((value) {
      Navigator.pop(context);
      if (value.status == false)
        Common.showToast("Coupon is invalid", "red");
      else {
        var buffer = new StringBuffer();
        for (var i = 0; i < value.data!.length; i++) {
          print('coupon is = ' + value.data![i].coupon);
          String concat = value.data![i].coupon + " : " + value.data![i].status;
          buffer.write(concat + '\n');
        }
        Common.openAlertBox(context,'Coupons',buffer.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Manual"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              
              Container(
                child: Center(
                  child: Container(
                      width: 150,
                      height: 100,
                      /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('assets/images/kspglogo.png')),
                ),
              ),
              SizedBox(height: 5.0,),
              
              Padding(
                  padding: EdgeInsets.all(10.0),
              child : Text("You can submit multiple coupons by comma seprated ex : (abc,xyz,vgh) ",
                style: TextStyle(color: myColor, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              )
              ),
              
              SizedBox(height: 20.0,),

              Container(
                padding: EdgeInsets.all(10.0),
              child : TextFormField(
                controller: couponController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: const Color(0xff992f2f2f))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: const Color(0xff990063b4)),
                    ),
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
                
                
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
              ),

              
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                height: 45,
                width: 140,
                decoration: BoxDecoration(
                    color: const Color(0xff990063b4),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  style : ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xff990063b4)),
                    overlayColor: MaterialStateColor.resolveWith((states) => myColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white),
                             
                          )
                      )
                  ),
                  onPressed: () {
                   if(couponController.text.isEmpty)
                     Common.showToast("Please enter coupons for accumulate.", "red");
                   else
                     callScanApi(couponController.text);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              
              
              
              
            
              ],
          ),
        ),
       
    );
  }

  
}
