import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kspg/common/Common.dart';
import 'package:kspg/pojo/HistoryModel.dart';

import '../api/ApiServices.dart';
import '../pojo/HistoryModel.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryScreen> {
  String apiToken = '';
  Color myColor = Color(0xff0063b4);
  late List<CouponData>? historyList;
  var listLength = 0;
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
      callHistoryApi("0", "20");
    });
  }
  
  callHistoryApi(String page,String size) {
    Common.showLoaderDialog(context);
    final service = ApiServices();
    service.getHistory(page,size,apiToken).then((value) {
      Navigator.pop(context);
      if (value.couponData!.length > 0) {
        setState(() {
          historyList = value.couponData!;
          listLength = historyList?.length ?? 0;
        });
      }
     
    });
    
  }
  
  List<Widget> _buildCells(int count) {
    print("count is = $count");
    print("check is = $count");
    return List.generate(
      count, (index) =>
        Column(
          children: [
          
            if (index == 0) ...[
              returnContainer(-1,"S.No.",80.0)
              ]
            else if (index == 1) ...[
              returnContainer(-1,"Coupen Code",120.0)
            ]
            else if (index == 2) ...[
              returnContainer(-1,"Serial Number",120.0)
            ]
            else if (index == 3) ...[
              returnContainer(-1,"Product Name",120.0)
            ]
            else if (index == 4) ...[
              returnContainer(-1,"Points",110.0)
            ]
            else if (index == 5) ...[
              returnContainer(-1,"Status",110.0)
            ]
            else  ...[
              returnContainer(-1,"Scan Date",110.0)
            ]
  
           
          ],
        ),
       
    );
  }

 
  // return container
 Container returnContainer(int srvalue,String headerValue,double widthValue){
  if(srvalue != -1)
    headerValue = '$srvalue';
  return Container(
     alignment: Alignment.center,
     width: widthValue,
     height: 50.0,
     color: Colors.white,
     margin: EdgeInsets.all(0.5),
     child: Text(headerValue),
   );
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
        title: Text("History"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                    Container(
                      color: Colors.black26,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildCells(7),
                      ),
                    ),
                    Container(
                      color: Colors.black26,
                      child : Column(
                      children: [
                      for(var i = 0; i < listLength; i++) ...[
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                            
                              returnContainer(i+1,"",80.0),
                              returnContainer(-1,historyList![i].coupon.toString(),120.0),
                              returnContainer(-1,historyList![i].serialNumber.toString(),120.0),
                              returnContainer(-1,historyList![i].productName.toString(),120.0),
                              returnContainer(-1,historyList![i].points.toString(),110.0),
                              returnContainer(-1,historyList![i].status.toString(),110.0),
                              returnContainer(-1,historyList![i].scanDate.toString(),110.0)
                       
                            ],
                          ),
                        ]
                      ),
                    ]
                      ]
                      )
                    )
                  ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  

  
}




