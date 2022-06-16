import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kspg/common/Common.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:kspg/screens/History.dart';
import 'package:kspg/screens/Manual.dart';
import 'package:kspg/screens/Profile.dart';
import 'package:kspg/screens/RedemptionHistory.dart';

import '../api/ApiServices.dart';
import 'login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForPref();
  }

  String _scanBarcode = "",
      apiToken = "",
      totalPoint = "",
      availPoint = "",
      usertype = "";
  Color myColor = Color(0xff0063b4);
  bool viewVisible = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController redeemController = TextEditingController();

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      if (!_scanBarcode.isEmpty && _scanBarcode != '-1')
        callScanApi(_scanBarcode);
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

        Common.openAlertBox(context, 'Coupons',buffer.toString());
      }
    });
  }

  callAvailPointsApi() {
    Common.showLoaderDialog(context);
    final service = ApiServices();
    service.getAvailPoints(apiToken).then((value) {
      if (value.status == true) {
        setState(() {
          totalPoint = 'Total Points : ' + value.data!.totalPoints.toString();
          availPoint =
              'Available Points : ' + value.data!.availablePoints.toString();
          // Common.showToast("total points get successfully", "green");
        });
      }
      callProfileApi();
    });
  }

  callRedeemPointApi(String redeemPoints) {
    Common.showLoaderDialog(context);
    final service = ApiServices();
    service
        .redeemPoints({"RedeemPoints": redeemPoints}, apiToken).then((value) {
      Navigator.pop(context);
      if (value.status == true) {
        hideWidget();
        Common.showToast(value.message.toString(), "green");
        callAvailPointsApi();
      } else
        Common.showToast(value.message.toString(), "red");
    });
  }

  callProfileApi() {
    final service = ApiServices();
    service.getProfile(apiToken).then((value) {
      Navigator.pop(context);
      if (value.status == true) {
        Common.userid = Common.Handlenull(value.register?.userCode ?? "");
        Common.shopName = Common.Handlenull(value.register?.shopName ?? "");
        Common.firstname = Common.Handlenull(value.register?.firstName ?? "");
        Common.middlename = Common.Handlenull(value.register?.middleName ?? "");
        Common.lastname = Common.Handlenull(value.register?.lastName ?? "");
        Common.address1 = Common.Handlenull(value.register?.addressLine1 ?? "");
        Common.adress2 = Common.Handlenull(value.register?.addressLine2 ?? "");
        Common.county = Common.Handlenull(value.register?.country ?? "");
        Common.state = Common.Handlenull(value.register?.state ?? "");
        Common.city = Common.Handlenull(value.register?.selectedCity ?? "");

        Common.adharcardno =
            Common.Handlenull(value.register?.aadharCardNo ?? "");
        Common.drivingno =
            Common.Handlenull(value.register?.drivingLicenseNo ?? "");
        Common.panno = Common.Handlenull(value.register?.pANNo ?? "");
        Common.gender = Common.Handlenull(value.register?.gender ?? "");
        Common.mobilenumber = Common.Handlenull(value.register?.mobile ?? "");
        Common.mobilenumber1 = Common.Handlenull(value.register?.mobile2 ?? "");
        Common.emailid = Common.Handlenull(value.register?.email ?? "");
        Common.dob = Common.Handlenull(value.register?.dateOfBirth ?? "");
        Common.zip = Common.Handlenull(value.register?.zip ?? "");
        Common.area = Common.Handlenull(value.register?.area ?? "");
        Common.items = Common.Handlenull(value.register?.userCode ?? "");
        Common.workshopsize =
            Common.Handlenull(value.register?.sizeOfWorkshop ?? "");
        Common.expyear = Common.Handlenull(
            value.register?.yearOfExperience.toString() ?? "");
        Common.servicepermonth =
            Common.Handlenull(value.register?.servicePerMonth.toString() ?? "");
        Common.profilepictureurl =
            Common.Handlenull(value.register?.profilePictureUrl ?? "");
        Common.workshopictureurl =
            Common.Handlenull(value.register?.workshopPhotoUrl ?? "");
        Common.profilepicture =
            Common.Handlenull(value.register?.ProfilePicturePath ?? "");
        Common.workshopicture =
            Common.Handlenull(value.register?.WorkShopPhotoPath ?? "");

        Common.bankname = Common.Handlenull(value.register?.bankName ?? "");
        Common.acPicture =
            Common.Handlenull(value.register?.bankDocImage ?? "");
        Common.acPictureUrl =
            Common.Handlenull(value.register?.bankDocImage ?? "");
        Common.banHoldeName =
            Common.Handlenull(value.register?.bankHolderName ?? "");
        Common.acNo =
            Common.Handlenull(value.register?.bankAccountNumber ?? "");
        Common.ifscCode = Common.Handlenull(value.register?.bankIFSCCode ?? "");

        if (usertype == "Retailer" || usertype == "Distributors")
          Common.salesturnover =
              Common.Handlenull(value.register?.SalesTurnoverPerYear ?? "");
        else
          Common.salesturnover =
              Common.Handlenull(value.register?.enginesOverhauled ?? "");
      }
    });
  }

  checkForPref() async {
    String token = await Common.getPreferences("token");
    String type = await Common.getPreferences("brandtype");
    setState(() {
      apiToken = token;
      usertype = type;
      callAvailPointsApi();
    });
  }

  void showWidget() {
    setState(() {
      viewVisible = true;
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      });
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  LogoutDailog() {
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
                        "Logout",
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
                      "Are you sure you want to logout?",
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
                            Common.SetPreferences("login", "false");
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => Login(),
                              ),
                                  (route) => false,//if you want to disable back feature set to false
                            );

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
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Dashboard")),
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                  child: Text(availPoint,
                      style: TextStyle(
                          color: myColor, fontWeight: FontWeight.bold))),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                height: 25,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              scanBarcodeNormal();
                            }, // Handle your onTap
                            child: Container(
                                height: 185,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            height: 100,
                                            width: 100,
                                            padding: EdgeInsets.all(10.0),
                                            child: Image.asset(
                                                "assets/images/barcode.png",
                                                fit: BoxFit.cover,
                                                color: Color(0xff990063b4))),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text("Scan",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff990063b4),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ]),
                                )))),
                    SizedBox(width: 10.0),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Container(
                              height: 185,
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 100,
                                          width: 100,
                                          padding: EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            "assets/images/manual.png",
                                            fit: BoxFit.cover,
                                            color: Color(0xff990063b4),
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5.0),
                                        child: Text("Manual",
                                            style: TextStyle(
                                                color:
                                                    const Color(0xff990063b4),
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ]),
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Manual()),
                            );
                          },
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              showWidget();
                            },
                            child: Container(
                                height: 185,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            height: 100,
                                            width: 100,
                                            padding: EdgeInsets.all(10.0),
                                            child: Image.asset(
                                                "assets/images/redeem.png",
                                                fit: BoxFit.cover,
                                                color: Color(0xff990063b4))),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text("Redeem",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff990063b4),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ]),
                                )))),
                    SizedBox(width: 10.0),
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: 185,
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        height: 100,
                                        width: 100,
                                        padding: EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/images/totalpoints.png",
                                          fit: BoxFit.cover,
                                          color: Color(0xff990063b4),
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5.0),
                                      child: Text(totalPoint,
                                          style: TextStyle(
                                              color: const Color(0xff990063b4),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ]),
                            ))),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryScreen()),
                              );
                            },
                            child: Container(
                                height: 185,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            height: 100,
                                            width: 100,
                                            padding: EdgeInsets.all(10.0),
                                            child: Image.asset(
                                                "assets/images/scanhistory.png",
                                                fit: BoxFit.cover,
                                                color: Color(0xff990063b4))),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text("Accumulation History",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff990063b4),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ]),
                                )))),
                    SizedBox(width: 10.0),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RedemptionHistory()),
                              );
                            },
                            child: Container(
                                height: 185,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            height: 100,
                                            width: 100,
                                            padding: EdgeInsets.all(10.0),
                                            child: Image.asset(
                                              "assets/images/redeemhistory.png",
                                              fit: BoxFit.cover,
                                              color: Color(0xff990063b4),
                                            )),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text("Redemption History",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff990063b4),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ]),
                                )))),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: viewVisible,
                  child: Container(
                      child: Column(children: <Widget>[
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                      height: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: redeemController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide:
                              new BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: myColor),
                        ),
                        labelText: 'Redeem points',
                        labelStyle: TextStyle(
                          color: myColor,
                        ),
                        prefixIcon: const Icon(
                          Icons.card_giftcard,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(top: 30.0),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color(0xff990063b4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Color(0xff990063b4)),
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => myColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(color: Colors.white),
                                      ))),
                                  onPressed: () {
                                    if (redeemController.text.isEmpty)
                                      Common.showToast(
                                          "Please enter redeem points", "red");
                                    else
                                      callRedeemPointApi(redeemController.text);
                                  },
                                  child: Text(
                                    'Request',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          SizedBox(width: 30.0),
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(top: 30.0),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color(0xff990063b4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Color(0xffC68F34)),
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Color(0xfffec077)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(color: Colors.white),
                                      ))),
                                  onPressed: () {
                                    hideWidget();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ])))
            ],
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: Drawer(
              child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff993582F4), Color(0xff990063b4)],
            )),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            Container(
                                height: 70,
                                width: 70,
                                child: CircleAvatar(
                                  radius: 16.0,
                                  child: ClipRRect(
                                    child: Image.asset(
                                        'assets/images/profile.png'),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                )),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20.0, top: 10.0),
                                child: Text('Vikram Singh',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 20.0, top: 5.0),
                                child: Text('vikram.singh@gladminds.co',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ))),
                          ],
                        ))
                    )
                ),
                Divider(
                  color: Colors.white,
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Column(children: <Widget>[
                  ListTile(
                    title:
                        Text('History', style: TextStyle(color: Colors.white)),
                    leading: Image.asset(
                      'assets/images/history.png',
                      color: Colors.white,
                    ),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen()),
                      );
                     
                    },
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/logout.png',
                        color: Colors.white),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      LogoutDailog();
                    },
                  ),
                ]))
              ],
            ),
          )),
        ));
  }
}
