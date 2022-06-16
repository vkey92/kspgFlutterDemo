import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kspg/common/Common.dart';

import '../api/ApiServices.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> with SingleTickerProviderStateMixin{
  String? gender;
  var apiToken = "" ,servicePerMonthValue = "",workShopValue = "",
      experienceValue = "",userType = "",salesHintValue = "",bankName = "",bankAdd = "",bankCode = "",
    branchName = "",branchCode = "",state = "",district = "",city = "",micr = "",ifscCode = "";
  Color myColor = Color(0xff0063b4);
  int id = 3;
  File? imageFile,kycImageFile,workshopImageFile,commonFile;
  String date = "",uniqueKey = "";
  DateTime currentDate = DateTime.now();
  bool checkedValue = false , viewVisible = false,checkforIfsc = false;
  TextEditingController userController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController add1Controller = TextEditingController();
  TextEditingController add2Controller = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController alternateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController uploadController = TextEditingController();
  TextEditingController workshopController = TextEditingController();
  TextEditingController salesController = TextEditingController();
  TextEditingController acnameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController accController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController bankpicController = TextEditingController();
  late TabController _tabController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    checkForPref();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  checkForPref() async {
    String token = await Common.getPreferences("token");
    String type = await Common.getPreferences("brandtype");
    setState(() {
      apiToken = token;
      userType = type;
      userController.text = Common.userid;
      firstNameController.text = Common.firstname;
      middleNameController.text = Common.middlename;
      lastNameController.text = Common.lastname;
      add1Controller.text = Common.address1;
      add2Controller.text = Common.adress2;
      pinController.text = Common.zip;
      countryController.text = Common.county;
      stateController.text = Common.state;
      cityController.text = Common.city;
      areaController.text = Common.area;
      servicePerMonthValue = Common.servicepermonth;
      if (Common.servicepermonth == "100")
        servicePerMonthValue = "Upto < 100";
      else if (Common.servicepermonth == "101-300")
        servicePerMonthValue = "100-300";
      else if (Common.servicepermonth == "301-500")
        servicePerMonthValue = "300-500";
      else
        servicePerMonthValue = "500";

      if (Common.expyear == "1")
       experienceValue = "1 Year";
      else if (Common.expyear == "2")
        experienceValue = "2 Year";
      else if (Common.expyear == "3")
        experienceValue = "3 Year";
      else if (Common.expyear == "4")
        experienceValue = "4 Year";
      else if (Common.expyear == "5")
        experienceValue = "5 Year";
      else if (Common.expyear == "6")
        experienceValue = "6 Year";
      else if (Common.expyear == "7")
        experienceValue = "7 Year";
      else if (Common.expyear == "8")
        experienceValue = "8 Year";
      else if (Common.expyear == "9")
        experienceValue = "9 Year";
      else if (Common.expyear == "10")
        experienceValue = "10 Year";

      if (Common.workshopsize == "100")
      workShopValue = "Upto 100 Sqft";
      else if (Common.workshopsize == "100-200")
        workShopValue = "100-200 Sqft";
      else if (Common.workshopsize == "200-300")
        workShopValue = "200-300 Sqft";
      else
        workShopValue = "More than 300 Sqft";
     
      aadharController.text = Common.adharcardno;
      licenseController.text = Common.drivingno;
      panController.text = Common.panno;
      
      if (userType == "Retailer" || userType == "Distributors")
         salesHintValue = "Sales Turnover Per Year";
      else
      salesHintValue = "Number of Engines Overhauled per month";
      
      salesController.text = Common.salesturnover;
      String gender = Common.gender;
      if (gender == "male")
        id = 1;
      else
      id = 2;
      contactController.text = Common.mobilenumber;
      alternateController.text = Common.mobilenumber1;
      emailController.text = Common.emailid;
      dobController.text = Common.dob;
      workshopController.text = Common.workshopicture;
      print("servicePerMonth = $servicePerMonthValue");


      acnameController.text = Common.banHoldeName;
      accController.text = Common.acNo;
      confirmController.text = Common.acNo;
      bankpicController.text = Common.acPictureUrl;
      if (!Common.ifscCode.isEmpty) {
        ifscController.text = Common.ifscCode;
       getIfscDetail();
      }
      
    });
  
  }
  
  getIfscDetail(){
    if (!ifscController.text.trim().isEmpty) {
      checkforIfsc = false;
      callIfscApi(ifscController.text);

    } else
      Common.showToast("Please enter your IFSC code.", "red");
  }
  

  Future<void> _showChoiceDialog(BuildContext context,String check) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      pickImage(ImageSource.gallery,check);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      pickImage(ImageSource.camera,check);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  pickImage(ImageSource imageType,String check) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      Navigator.pop(context);
      setState(() {
        if(check == "profile") {
          imageFile = tempImage;
          commonFile = tempImage;
          uniqueKey = "profile";
        }else if(check == "upload") {
          kycImageFile = tempImage;
          commonFile = tempImage;
          uniqueKey = "workshop";
          uploadController.text = photo.path;
        }else if(check == "workshop"){
          workshopImageFile = tempImage;
          commonFile = tempImage;
          uniqueKey = "workshop";
          workshopController.text = photo.path;
        }else{
          commonFile = tempImage;
          uniqueKey = "bank";
          bankpicController.text = photo.path;
        }
        uploadPhoto(imageFile!, "Genaral", uniqueKey);
        
      });

    
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now().add(Duration(days: 0)));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
        dobController.text = formattedDate;
      });

   
  }


  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }
  
  

  callZipApi(String zip) {
    Common.showLoaderDialog(context);
    final service = ApiServices();
    service.getZip(apiToken,zip).then((value) {
      Navigator.pop(context);
       setState(() {
         countryController.text = value.country;
         stateController.text = value.state;
         cityController.text = value.city;
        });

    });

  }

 
  callSubmitApi() {
    Common.showLoaderDialog(context);
    final service = ApiServices();
    Map<String, dynamic> map1;
    var turnOverKey = "",arrayKey = "",name = "", code = "";
    if (userType == "Retailer" || userType == "Distributors")
       turnOverKey = 'SalesTurnoverPerYear';
    else
       turnOverKey = 'EnginesOverhauled';

    if (!Common.retailorcode.isEmpty) {
      arrayKey = 'retailer';
      name = Common.retailorcode;
      code = Common.retailorname;
    }if (!Common.dealercode.isEmpty) {
      arrayKey = 'dealer';
      name = Common.dealercode;
      code = Common.dealername;
    }
    map1 = {"UserCode" :  Common.userid,
      "ShopName" : Common.shopName,
      "FirstName" : Common.firstname,
      "MiddleName" : Common.middlename,
      "LastName" :  Common.lastname,
      "AddressLine1" : Common.address1,
      "AddressLine2": Common.adress2,
      "Mobile": Common.mobilenumber,
      "Mobile2": Common.mobilenumber1,
      "Email": Common.emailid,
      "Items": Common.items,
      "selectedCity": Common.city,
      "Country": Common.county,
      "State": Common.state,
      "AadharCardNo": Common.adharcardno,
      "DrivingLicenseNo": Common.drivingno,
      "PANNo": Common.panno,
      "Gender": Common.gender,
      "DateOfBirth": Common.dob,
      "SizeOfWorkshop": Common.workshopsize,
      "BajajServicePerMonth": Common.servicepermonth,
      "YearOfExperience": Common.expyear,
      "ProfilePicture": Common.profilepicture,
      "WorkshopPhoto": Common.workshopicture,
      "Area": Common.area,
      "Zip": Common.zip,
      "BankName": Common.bankname,
      "BankDocImage": Common.acPicture,
      "BankHolderName": Common.banHoldeName,
      "BankAccountNumber": Common.acNo,
      "ConformBankAccountNumber": Common.acNo,
      "BankIFSCCode": Common.ifscCode,
      "BankMICR": Common.bankMicr,
      turnOverKey : Common.salesturnover,
      if (!arrayKey.isEmpty) arrayKey : [{"code": code, "name": name}]
    };
   
     
    service.submitProfile(map1,apiToken).then((value) {
      Navigator.pop(context);
      if(value.status == true){
        Common.openAlertBox(context,'Succeed',value.message ?? "");
        _tabController.animateTo((_tabController.index -3));
      }

    });

  }

  callIfscApi(String code) {
    Common.showLoaderDialog(context);
    final service = ApiServices();
    service.getIfscDetail(apiToken,code).then((value) {
      Navigator.pop(context);
     if(value.status == true){
       checkforIfsc = true;
       var bankValue = value.bank?.bank;
       var bankMicrValue = value.bank?.micr.toString();
       Common.bankname = bankValue ?? "";
       Common.bankMicr = bankMicrValue ?? "";
       bankName = bankValue!;
       bankAdd = value.bank?.address ?? "";
       branchName = value.bank?.branch ?? "";
       branchCode = value.bank?.bankcode ?? "";
       state = value.bank?.state ?? "";
       district = value.bank?.district ?? "";
       city = value.bank?.city ?? "";
       micr = value.bank?.micr ?? "";
       ifscCode = value.bank?.ifsc ?? "";
       showWidget();
     }else{
       Common.showToast("Bank not found.", "red");
       hideWidget();
     }

    });

  }

  uploadPhoto(File path,String type,String key) {
    Common.showLoaderDialog(context);
    final service = ApiServices();
    service.uploadPic(apiToken,path,type,key).then((value) {
      Navigator.pop(context);
      if(value.status == true){
        Common.showToast(value.message.toString(), "green");
        var profilePic = value.data?.images?.path.toString();
        var profilePicUrl = value.data?.images?.url.toString();
        if(key == 'profile') {
          Common.profilepicture = profilePic!;
          Common.profilepictureurl = profilePicUrl!;
        }else if(key == 'workshop'){
          Common.workshopicture = profilePic!;
          Common.workshopictureurl = profilePicUrl!;
        }else{
          Common.acPicture = profilePic!;
          Common.acPictureUrl = profilePicUrl!;
        }
      }else
        Common.showToast(value.message.toString(), "red");
    });

  }

   bool validate() {
     bool valid = true;

    if (Common.firstname.isEmpty) {
      Common.showToast("Enter your Firstname.", "red");
      valid = false;
    } else if (Common.lastname.isEmpty) {
      Common.showToast("Enter your Lastname.", "red");
      valid = false;
    }else if (Common.address1.isEmpty) {
      Common.showToast("Enter your address1.", "red");
      valid = false;
    }else if (Common.zip.isEmpty || Common.zip.length < 6) {
      Common.showToast("Enter your valid pincode.", "red");
      valid = false;
    }else if (Common.area.isEmpty) {
      Common.showToast("Enter your area.", "red");
      valid = false;
    } 

    return valid;
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                tabs: [
                  Tab(
                    icon: Icon(Icons.person),
                    text: "My Profile",
                  ),
                  Tab(
                    icon: Icon(Icons.document_scanner),
                    text: "KYC",
                  ),
                  Tab(
                    icon: Icon(Icons.comment_bank),
                    text: "Bank Detail",
                  ),
                  Tab(
                    icon: Icon(Icons.policy),
                    text: "Terms & Condition",
                  ),
                ],
              ),
              title: Text('Profile'),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                // profile tab body
                Container(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                           print("click on photo");
                          _showChoiceDialog(context,'profile');
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          child: Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: myColor, width: 1),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: imageFile != null
                                          ? Image.file(imageFile!,
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.cover)
                                          : Image.network(
                                              Common.profilepictureurl,
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.cover,
                                            ),
                                      
                                    )),
                               /* Positioned(
                                  bottom: 0,
                                  right: 5,
                                  child: IconButton(
                                    onPressed: () {
                                   
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Color(0xff0063b4),
                                      size: 30,
                                    ),
                                  ),
                                )*/
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: userController,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'User Id *',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: firstNameController,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'First Name',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: middleNameController,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Middle Name',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: lastNameController,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Last Name',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: add1Controller,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Address Line 1',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.location_history,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: add2Controller,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Address Line 2',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.location_history,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: pinController,
                            onChanged: (text) {
                              var searchtxt = text.trim();
                              print('pin is: $text');
                              if (searchtxt.length == 6)
                                callZipApi(searchtxt);


                            },
                              style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Pin Code',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.pin,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: countryController,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Country',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.flag,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: stateController,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'State',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.real_estate_agent,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: cityController,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'City',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.location_city,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: areaController,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Area',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.area_chart,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        height: 45,
                        width: 250,
                        decoration: BoxDecoration(
                            color: const Color(0xff990063b4),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0xff990063b4)),
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => myColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.white),
                              ))),
                          onPressed: () {
                            Common.userid = userController.text.trim();
                            Common.firstname = firstNameController.text.trim();
                            Common.middlename = middleNameController.text.trim();
                            Common.lastname = lastNameController.text.trim();
                            Common.address1 = add1Controller.text.trim();
                            Common.adress2 = add2Controller.text.trim();
                            Common.zip = pinController.text.trim();
                            Common.county = countryController.text.trim();
                            Common.state = stateController.text.trim();
                            Common.city = cityController.text.trim();
                            Common.area = areaController.text.trim();
                            if (validate()) {
                              _tabController.animateTo((_tabController.index + 1) % 2);
                            }
                            
                              //DefaultTabController.of(context)?.animateTo(2);
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                )),

                // Kyc tab body
                Container(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [

                      InkWell(
                      onTap: () {
                    print("click on photo");
                    _showChoiceDialog(context,'upload');
                    },
                     child : Container(
                          height: 60.0,
                          child: TextField(
                            controller: uploadController,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.black,
                              
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Upload Photo',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          ))
                      ),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: aadharController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Aadhar Card No',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: licenseController,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Driving License No',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: panController,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'PAN No',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Gender : ',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Radio(
                              value: 1,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  gender = 'male';
                                  id = 1;
                                });
                              },
                            ),
                            Text(
                              'Male',
                              style:
                                  new TextStyle(fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Radio(
                              value: 2,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  gender = 'female';
                                  id = 2;
                                });
                              },
                            ),
                            Text(
                              'Female',
                              style:
                                  new TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: contactController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Contact Number',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: alternateController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Alternate Number',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                      
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: emailController,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Email Id',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      
                      SizedBox(
                        height: 15,
                      ),
                  InkWell(
                    onTap: () {
                      print("click on dob");
                      _selectDate(context);
                    },
                      child : Container(
                          height: 50.0,
                          child: TextField(
                            controller: dobController,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'DOB',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.date_range,
                                color: Colors.grey,
                              ),
                            ),
                          ))
                  ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: double.infinity,
                          child: Text("Size of Workshop *",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ))),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 55,
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          dropdownColor: Colors.grey,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.work_sharp,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1, color: myColor),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: workShopValue,
                          
                          ),
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                        
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          items: <String>[
                            'Upto 100 Sqft',
                            '100-200 Sqft',
                            '200-300 Sqft',
                            'More than 300 Sqft'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: double.infinity,
                          child: Text("Service Per Month",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ))),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 55,
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          dropdownColor: Colors.grey,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.home_repair_service,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1, color: myColor),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: servicePerMonthValue,
                          ),
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          items: <String>[
                            'Upto < 100',
                            '100-300',
                            '300-500',
                            '500'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: double.infinity,
                          child: Text("Year of Experience",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ))),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 55,
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          dropdownColor: Colors.grey,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.expand,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1, color: myColor),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: experienceValue,
                          ),
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          items: <String>[
                            '1 Year',
                            '2 Year',
                            '3 Year',
                            '4 Year',
                            '5 Year',
                            '6 Year',
                            '7 Year',
                            '8 Year',
                            '9 Year',
                            '10 Year'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      
                      SizedBox(
                        height: 15,
                      ),
                  InkWell(
                    onTap: () {
                      print("click on photo");
                      _showChoiceDialog(context,'workshop');
                    },
                      child : Container(
                          height: 60.0,
                          child: TextField(
                            controller: workshopController,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: 'Workshop Photo',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.photo,
                                color: Colors.grey,
                              ),
                            ),
                          ))
                  ),
                      
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 50.0,
                          child: TextField(
                            controller: salesController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(width: 1, color: myColor),
                              ),
                              labelText: salesHintValue,
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.point_of_sale_sharp,
                                color: Colors.grey,
                              ),
                            ),
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        height: 45,
                        width: 250,
                        decoration: BoxDecoration(
                            color: const Color(0xff990063b4),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0xff990063b4)),
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => myColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.white),
                              ))),
                          onPressed: () {
                            Common.adharcardno = aadharController.text.trim();
                            Common.drivingno = licenseController.text.trim();
                            Common.panno = panController.text.trim();
                            if (id == 1)
                              Common.gender = "Male";
                            else
                              Common.gender = "Female";

                            Common.mobilenumber = contactController.text.trim();
                            Common.mobilenumber1 = alternateController.text.trim();
                            Common.emailid = emailController.text.trim();
                            Common.dob = dobController.text.trim();
                            Common.salesturnover = salesController.text.trim();
                            Common.workshopsize = workShopValue;
                            Common.expyear = experienceValue;
                            Common.servicepermonth = servicePerMonthValue;
                            if (!Common.mobilenumber.isEmpty && Common.mobilenumber.length == 10)
                              _tabController.animateTo((_tabController.index + 1));
                            else
                              Common.showToast("Please enter your mobile number.", "red");
                            },
                          
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
               
               // Bank Detail tab body
                Container(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          
                          Container(
                                  height: 50.0,
                                  child: TextField(
                                    controller: acnameController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: new InputDecoration(
                                      border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                        borderSide:
                                        BorderSide(width: 1, color: myColor),
                                      ),
                                      labelText: 'Account Holder Name *',
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                          ),
                          
                          SizedBox(
                            height: 15,
                          ),
                          
                          Row(
                              children : [
                                Expanded(
                                  flex : 3,
                                child : Container(
                                    height: 50.0,
                                    child: TextField(
                                      controller: ifscController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          borderSide:
                                          BorderSide(width: 1, color: myColor),
                                        ),
                                        labelText: 'IFSC Code *',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.code,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ))
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex : 1,
                                    child :  Container(
                                      height: 50,
                                    
                                      decoration: BoxDecoration(
                                          color: const Color(0xff990063b4),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateColor.resolveWith(
                                                    (states) => Color(0xff990063b4)),
                                            overlayColor: MaterialStateColor.resolveWith(
                                                    (states) => myColor),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  side: BorderSide(color: Colors.white),
                                                ))),
                                        onPressed: getIfscDetail,
                                        child: Text(
                                          'Search',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                )
                             ] 
                          ),

                          SizedBox(
                            height: 15,
                          ),

                      Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: viewVisible,
                         child :  Container(
                              width: double.infinity,
                           child : Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children : [
                               Text("Bank Search Details",
                           style : TextStyle(fontWeight: FontWeight.bold)
                                   
                          ),
                               SizedBox(height: 10),
                               Text("Name : "+bankName),
                               SizedBox(height: 5),
                               Text("Address : "+bankAdd),
                               SizedBox(height: 5),
                               Text("Branch Code : "+branchCode),
                               SizedBox(height: 5),
                               Text("Branch : "+branchName),
                               SizedBox(height: 5),
                               Text("State : "+state),
                               SizedBox(height: 5),
                               Text("District : "+district),
                               SizedBox(height: 5),
                               Text("City : "+city),
                               SizedBox(height: 5),
                               Text("MICR : "+micr),
                               SizedBox(height: 5),
                               Text("IFSC : "+ifscCode),
                             ]
                           )
                          )
                      ),
                          
                         
                          SizedBox(
                            height: 15,
                          ),
                          
                          Container(
                              height: 50.0,
                              child: TextField(
                                controller: accController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                    BorderSide(width: 1, color: myColor),
                                  ),
                                  labelText: 'Account Number *',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.account_balance,
                                    color: Colors.grey,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                         
                          Container(
                              height: 50.0,
                              child: TextField(
                                controller: confirmController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                    BorderSide(width: 1, color: myColor),
                                  ),
                                  labelText: 'Confirm Account Number',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.account_balance,
                                    color: Colors.grey,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                      InkWell(
                        onTap: () {
                          print("click on photo");
                          _showChoiceDialog(context,'bank');
                        },
                          child : Container(
                              height: 60.0,
                              child: TextField(
                                controller: bankpicController,
                               enabled: false,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                    BorderSide(width: 1, color: myColor),
                                  ),
                                  labelText: 'Bank Details Upload *',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.comment_bank,
                                    color: Colors.grey,
                                  ),
                                ),
                              ))
                      ),
                         
                          SizedBox(
                            height: 20,
                          ),
                         
                          Container(
                            margin: const EdgeInsets.only(top: 30.0),
                            height: 45,
                            width: 250,
                            decoration: BoxDecoration(
                                color: const Color(0xff990063b4),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith(
                                          (states) => Color(0xff990063b4)),
                                  overlayColor: MaterialStateColor.resolveWith(
                                          (states) => myColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        side: BorderSide(color: Colors.white),
                                      ))),
                              onPressed: () {
                                Common.banHoldeName = acnameController.text.trim();
                                Common.ifscCode = ifscController.text.trim();
                                Common.acNo = accController.text.trim();
                                Common.acPictureUrl = bankpicController.text.trim();

                                if (Common.banHoldeName.isEmpty)
                                  Common.showToast("Please enter your Account Holdername.", "red");
                                else if (Common.ifscCode.isEmpty)
                                  Common.showToast("Please enter your IFSC code.", "red");
                                else if (Common.acNo.isEmpty)
                                  Common.showToast("Please enter your Account Number.", "red");
                                else if (Common.acNo != confirmController.text.trim())
                                 Common.showToast("Account number does not match.", "red");
                                else if (Common.acPictureUrl.isEmpty)
                                  Common.showToast("Please upload your Band Detail Photo.", "red");
                                else {
                                  if (checkforIfsc)
                                    _tabController.animateTo((_tabController.index + 1));
                                  else
                                    Common.showToast("Bank not found with entered IFSC.", "red");
                                }
                                
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                
                // temrs and condition tab body
               Container(
                   margin: const EdgeInsets.only(top: 20.0),
                 child : Column(
                   children : [
                     
                     CheckboxListTile(
                       title: Text("Terms & Conditions"),
                       value: checkedValue,
                       onChanged: (newValue) {
                         setState(() {
                           checkedValue = newValue!;
                         });
                       },
                       controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                     ),
                     Container(
                       margin: const EdgeInsets.only(top: 30.0),
                       height: 45,
                       width: 250,
                       decoration: BoxDecoration(
                           color: const Color(0xff990063b4),
                           borderRadius: BorderRadius.circular(20)),
                       child: TextButton(
                         style: ButtonStyle(
                             backgroundColor: MaterialStateColor.resolveWith(
                                     (states) => Color(0xff990063b4)),
                             overlayColor: MaterialStateColor.resolveWith(
                                     (states) => myColor),
                             shape: MaterialStateProperty.all<
                                 RoundedRectangleBorder>(
                                 RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20.0),
                                   side: BorderSide(color: Colors.white),
                                 ))),
                         onPressed: () {
                           if (checkedValue) {
                             callSubmitApi();
                           } else
                             Common.showToast("Please accept terms & conditions.", "red");
                            
                         },
                         child: Text(
                           'Submit',
                           style: TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.bold),
                         ),
                       ),
                     )
                   ]
                 )
               
               ), //Row
               
              ],
            ),
          ),
        ));
  }
  
}
