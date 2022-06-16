import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:kspg/common/Common.dart';

import '../api/ApiServices.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  String dropdownValue = 'Please Select Org type';
  String partnerDropdownValue = '', partnerValue = '';
  List<String> channeList = [];
  bool viewVisible = false;
  TextEditingController distiCodeController = new TextEditingController();
  TextEditingController shopNameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();

  bool validate() {
    bool valid = true;
    if (partnerValue.isEmpty ||
        partnerValue == "Select Channel partner" ||
        partnerValue == "Select service partner") {
      Common.showToast("Please select your partner.","red");
      valid = false;
    } else if (distiCodeController.text.isEmpty && viewVisible) {
      Common.showToast("Please enter your Distributor code.","red");
      valid = false;
    } else if (shopNameController.text.isEmpty) {
      Common.showToast("Please enter your shopname.","red");
      valid = false;
    } else if (firstNameController.text.isEmpty) {
      Common.showToast("Please enter your firstname.","red");
      valid = false;
    } else if (lastNameController.text.isEmpty) {
      Common.showToast("Please enter your lastname.","red");
      valid = false;
    } else if (!Common.isValidEmail(emailController.text)) {
      Common.showToast("Please enter your valid email.","red");
      valid = false;
    } else if (mobileController.text.isEmpty ||
        mobileController.text.length < 10) {
      Common.showToast("Please enter your valid mobile number.","red");
      valid = false;
    } else if (passwordController.text.isEmpty ||
        passwordController.text.length < 3) {
      Common.showToast("Password length must be 3 or greater.","red");
      valid = false;
    } else if (passwordController.text != confirmPassController.text) {
      Common.showToast("Password does not match.","red");
      valid = false;
    }
    return valid;
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

  callRegisterApi() {
    Common.showLoaderDialog(context);
  
    final service = ApiServices();
    service.newRegister(
      {
        "partnerType": partnerValue,
        "ShopName": shopNameController.text,
        "FirstName": firstNameController.text,
        "LastName": lastNameController.text,
        "ContactNo": mobileController.text,
        "EmailID": emailController.text,
        "Password": passwordController.text,
        "ConformPassword": confirmPassController.text,
        "DistributorCode" : distiCodeController.text
      },
      
    ).then((value) {
      if (value.status == false) {
        print("response register >>>>>> " + value.message!);
        Common.showToast(value.message.toString(), "red");
      } else {
        Common.showToast(value.message.toString(), "green");
        print(value.message!);
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
              Container(
                child: DropdownButtonFormField(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  dropdownColor: Colors.grey,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Please Select Org type",
                  ),
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      print(dropdownValue);
                      if (dropdownValue == "Service Partner") {
                        partnerDropdownValue = 'Select Service Partner';
                        channeList = [
                          "Reborer",
                          "Grinder",
                          "Grinder Reborer",
                          "Mechanics"
                        ];
                      } else {
                        partnerDropdownValue = 'Select Channel Partner';
                        channeList = ["Distributors", "Retailer"];
                      }
                    });
                  },
                  items: <String>['Channel Partner', 'Service Partner']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: DropdownButtonFormField(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  dropdownColor: Colors.grey,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.handshake,
                      color: Colors.white,
                    ),
                    prefixIconColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: partnerDropdownValue,
                  ),
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      partnerValue = newValue!;
                      print(newValue);
                      if (partnerValue == "Distributors")
                        showWidget();
                      else
                        hideWidget();
                    });
                  },
                  items: channeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: viewVisible,
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: new TextField(
                      controller: distiCodeController,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide:
                              new BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        labelText: 'Distributor Code *',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      style: new TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: new TextField(
                    controller: shopNameController,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      labelText: 'Shop Name *',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    style: new TextStyle(color: Colors.white)),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: new TextField(
                    controller: firstNameController,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      labelText: 'First Name *',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    style: new TextStyle(color: Colors.white)),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: new TextField(
                    controller: lastNameController,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      labelText: 'Last Name *',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    style: new TextStyle(color: Colors.white)),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: new TextField(
                    controller: emailController,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                    style: new TextStyle(color: Colors.white)),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: new TextField(
                    controller: mobileController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      labelText: 'Mobile Number *',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    style: new TextStyle(color: Colors.white)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      labelText: 'Password *',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                    style: new TextStyle(color: Colors.white)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                    controller: confirmPassController,
                    obscureText: true,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      labelText: 'Confirm Password *',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                    style: new TextStyle(color: Colors.white)),
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
                    if (validate()) {
                      callRegisterApi();
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Already Registered ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            }),
                      // can add more TextSpans here...
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
