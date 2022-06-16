import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kspg/common/Common.dart';
import 'package:kspg/pojo/HistoryModel.dart';
import 'package:kspg/pojo/RedemptionModel.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../api/ApiServices.dart';
import '../pojo/HistoryModel.dart';

class RedemptionHistory extends StatefulWidget {
  const RedemptionHistory({Key? key}) : super(key: key);

  @override
  _RedeemHistoryPageState createState() => _RedeemHistoryPageState();
}

class _RedeemHistoryPageState extends State<RedemptionHistory> {
  String apiToken = '', actionON = '',searchtxt = '';
  var startpage = 0;
  Color myColor = Color(0xff0063b4);
  List<RedeemptionData>? historyList;
  var checkForSearch = false,isLoading = false;
  
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForPref();
  }

  checkForPref() async {
    String token = await Common.getPreferences("token");

    apiToken = token;
    callHistoryApi("$startpage", "20", searchtxt);
  }

  callHistoryApi(String page, String size, String searchTxt) {
    if(!checkForSearch)
    Common.showLoaderDialog(context);
    final service = ApiServices();
    service.getRedeemHistory(page, size, apiToken, searchTxt).then((value) {
      if(!checkForSearch)
      Navigator.pop(context);
      if (value.totalItems! > 0)
        if(searchtxt.isEmpty)
          checkForSearch = false;
        setState(() {
          historyList = value.redeemptionData!;
          var totalItem = value.totalItems;
          var listLength = historyList?.length ?? 0;
          if (listLength < totalItem!)
            isLoading = true;
          else
            isLoading = false;
        });
    });
  }

   _gotoback() {
     if (checkForSearch) {
       checkForSearch = false;
       startpage = 0;
       searchtxt = "";
       searchController.text = "";
       callHistoryApi("$startpage","20",searchtxt);
     } else {
       Navigator.of(context).pop();
     }
    return false;
  }

 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        onWillPop: () {
          if (checkForSearch) {
            checkForSearch = false;
            startpage = 0;
            searchtxt = "";
            searchController.text = "";
            callHistoryApi("$startpage","20",searchtxt);
          } else {
            Navigator.of(context).pop();
          }
          return Future.value(false);
        },
      child : Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: _gotoback
         
          ),
          title: Text("Redemption History"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  height: 50.0,
                  child: TextField(
                    controller: searchController,
                    onChanged: (text) {
                      searchtxt = text.trim();
                      print('First text field: $text');
                      checkForSearch = true;
                        setState(() {
                          historyList?.clear();
                        });
                        startpage = 0;
                        callHistoryApi("$startpage", "20", searchtxt);
                      
                    
                    },
                    
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: myColor),
                      ),
                    ),
                  )),
              Container(
                child: getList(),
              )
            ],
          ),
        ))
    );
  }

  Widget getList() {
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: () {
          if (isLoading) {
            startpage += 1;
            callHistoryApi("$startpage", "20", searchtxt);
            isLoading = false;
            Common.showToast("this is end of page", "green");
          }
        
        },
        child: ListView.builder(
          itemCount: historyList?.length ?? 0,
          itemBuilder: (context, position) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Transaction Id : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                historyList![position].transactionId.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Redeem Points : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                historyList![position]
                                    .redeempRequestPoints
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Status : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                historyList![position].status.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Request : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                historyList![position].requestOn.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Action : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              if (historyList![position].actionOn.toString() ==
                                  "null") ...[
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )
                              ] else ...[
                                Text(
                                  historyList![position].actionOn.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )
                              ]
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      )),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
