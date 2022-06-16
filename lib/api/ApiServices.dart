
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kspg/common/Common.dart';
import 'package:kspg/pojo/HistoryModel.dart';
import 'package:kspg/pojo/IfscModel.dart';
import 'package:kspg/pojo/Otpmodel.dart';
import 'package:kspg/pojo/PinModel.dart';
import 'package:kspg/pojo/PointsModel.dart';
import 'package:kspg/pojo/ProfileModel.dart';
import 'package:kspg/pojo/RedemptionModel.dart';
import 'package:kspg/pojo/ScanModel.dart';
import 'package:kspg/pojo/SubmitproModel.dart';
import 'package:kspg/pojo/UploadModel.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiServices {
  
  // for new registration
  Future<RegisterResponse> newRegister(Map<String, dynamic> param) async {
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/Partners/create');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    return RegisterResponse(message: data["message"], status: data["status"]);
  }

  // for login api
  Future<LoginResponse> attemptLogin(Map<String, dynamic> param) async {
    var url = Uri.parse(Common.mainurl + 'api/Auth/login');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    var tagsJson = jsonDecode(response.body)['roles'];
    List<String>? tags = tagsJson != null ? List.from(tagsJson) : null;

    print(tags);

    return LoginResponse(
        message: data["message"],
        status: data["status"],
        token: data["token"],
        username: data["username"],
        id: data["id"],
        email: data["email"],
        phone: data["phone"],
        roles: tags);
  }

  // for OTP verification
  
  Future<Otpmodel> otpVerify(Map<String, dynamic> param,
      String token) async {
    print("sent token >>>> "+token);
   
    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/OtpVerify');
    var response =
        await http.post(url, headers: header, body: param);
   
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Otpmodel otpmodel = Otpmodel.fromJson(jsonDecode(response.body));
    print(otpmodel);

    return otpmodel;
  }
  
  // for send the code on registered email
  Future<sendCodeResponse> sendCode(String username) async {
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/commonData/resetPasswordCodeGenerate?username='+username);
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    
    return sendCodeResponse(
        message: data["message"],
        status: data["status"]);
  }

  // for verify OTP
  Future<sendCodeResponse> verifyOtp(Map<String, dynamic> param) async {
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/commonData/resetPasswordCodeVerify');
    var response = await http.put(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);

    return sendCodeResponse(
        message: data["message"],
        status: data["status"],
        token: data["token"]);
  }
  
// for reset password
  Future<sendCodeResponse> resetPassword(Map<String, dynamic> param,String token) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/commonData/resetPasswordPasswordSet');
    var response =
    await http.put(url, headers: header, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);

    return sendCodeResponse(
        message: data["message"],
        status: data["status"]);
  }


  Future<ScanModel> insertScan(Map<String, dynamic> param,
      String token) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/CouponOperations/scan');
    var response =
    await http.post(url, headers: header, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    ScanModel scanModel = ScanModel.fromJson(jsonDecode(response.body));
    print(scanModel);

    return scanModel;
  }

  Future<PointsModel> getAvailPoints(String token) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/CouponOperations/points');
    var response =
    await http.get(url, headers: header);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    PointsModel pointsModel = PointsModel.fromJson(jsonDecode(response.body));
    print(pointsModel);

    return pointsModel;
  }

  Future<redeemPointsResponse> redeemPoints(Map<String, dynamic> param,
      String token) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/CouponOperations/redeemption');
    var response =
    await http.put(url, headers: header, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);

    return redeemPointsResponse(
        message: data["message"],
        status: data["status"]);
  }
  
  

  Future<HistoryModel> getHistory(String page,String size,
      String token) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/CouponOperations/historyList?page='+page+"&size="+size);
    var response =
    await http.get(url, headers: header);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    
  
      
    HistoryModel historyModel = HistoryModel.fromJson(jsonDecode(response.body));
    print(historyModel);

    return historyModel;
  }

  
  
  Future<RedemptionModel> getRedeemHistory(String page,String size,
      String token,String searchTxt) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/CouponRedeemption/historyList?page='+page+"&size="+size+"&searchText="+searchTxt);
    var response =
    await http.get(url, headers: header);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');



    RedemptionModel redemptionModel = RedemptionModel.fromJson(jsonDecode(response.body));
    print(redemptionModel);

    return redemptionModel;
  }
  

  Future<ProfileModel> getProfile(String token) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/User/profile');
    var response =
    await http.get(url, headers: header);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');



    ProfileModel profileModel = ProfileModel.fromJson(jsonDecode(response.body));
    print(profileModel);

    return profileModel;
  }

  Future<PinModel> getZip(String token,String zip) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/CommonData/zipToAddress?zip='+zip);
    var response =
    await http.get(url, headers: header);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    PinModel pinModel = PinModel.fromJson(jsonDecode(response.body));
    print(pinModel);

    return pinModel;
  }


  Future<UploadModel> uploadPic(String token,File file,String type,String key) async {
    print("sent token >>>> "+token);
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var request = http.MultipartRequest("POST",Uri.parse(Common.mainurl + 'api/kspgAPI/CommonData/upload'));
    request.fields['upload_type'] = type;
    request.fields['unique_key'] = key;
    request.headers['X-API-KEY'] = token;
    
    var picture = http.MultipartFile('photo', stream, length,
        filename: 'kspg.png');
    request.files.add(picture);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    print('Response status: ${response.statusCode}');
    UploadModel uploadmodel = UploadModel.fromJson(jsonDecode(String.fromCharCodes(responseData)));
    print(uploadmodel);
    return uploadmodel;
  }

  Future<IfscModel> getIfscDetail(String token,String code) async {
    print("sent token >>>> "+token);

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/User/bankSearch?=MAHB0001011&BankIFSCCode='+code);
    var response =
    await http.get(url, headers: header);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    IfscModel ifscModel = IfscModel.fromJson(jsonDecode(response.body));
    print(ifscModel);

    return ifscModel;
  }

  Future<SubmitproModel> submitProfile(Map<String, dynamic> param,
      String token) async {
    print("sent token >>>> "+token);
    print("params are >>>> "+param.toString());

    var header = {
      'X-API-KEY': token
    };
    print("header is >>>> "+header.toString());
    var url = Uri.parse(Common.mainurl + 'api/kspgAPI/User/profile');
    var response =
    await http.put(url, headers: header, body: param);

  

    SubmitproModel submitproModel = SubmitproModel.fromJson(jsonDecode(response.body));
    print(submitproModel);
    return submitproModel;
    
  }


 

 
  
  
}





// these are the model classes

class RegisterResponse {
  final String? message;
  final bool? status;
  RegisterResponse({this.message, this.status});
}

class LoginResponse {
  final String? message;
  final bool? status;
  final String? token;
  final String? username;
  final String? id;
  final String? email;
  final String? phone;
  List<String>? roles = [];
  LoginResponse(
      {this.message,
      this.status,
      this.token,
      this.username,
      this.id,
      this.email,
      this.phone,
      this.roles});
}

class OtpResponse {
  final bool? status;
  final String? token;
  final String? first_name;
  final String? last_name;
  final String? type;
  final String? brand_id;

  OtpResponse(
      {this.status,
      this.token,
      this.first_name,
      this.last_name,
      this.type,
      this.brand_id});
}


class sendCodeResponse {
  final String? message;
  final bool? status;
  final String? token;

  sendCodeResponse(
      {
        this.message,
        this.status,
        this.token
     }
     );
}


class redeemPointsResponse {
  final String? message;
  final bool? status;

  redeemPointsResponse(
      {
        this.message,
        this.status,
      }
      );
}





