

class UserData {
  String first_name;
  String last_name;
  UserData(this.first_name, this.last_name);
  factory UserData.fromJson(dynamic json) {
    return UserData(json['first_name'] as String, json['last_name'] as String);
  }
  @override
  String toString() {
    return '{ ${this.first_name}, ${this.last_name} }';
  }
}

class MyBrand {
  String? type;
  String? brand_id;
  MyBrand(this.type, this.brand_id);
  factory MyBrand.fromJson(dynamic json) {
    return MyBrand(json['type'] as String, json['brand_id'] as String);
  }
  @override
  String toString() {
    return '{ ${this.type}, ${this.brand_id} }';
  }
}
class Otpmodel {
  bool? status;
  String? token;
  UserData? userData;
  MyBrand? myBrand;
  Otpmodel(this.status, this.token, this.userData,this.myBrand);
  factory Otpmodel.fromJson(dynamic json) {
    return Otpmodel(json['status'] as bool, json['token'] as String, UserData.fromJson(json['userdata']),
        MyBrand.fromJson(json['My_Brand']));
  }
  @override
  String toString() {
    return '{ ${this.status}, ${this.token}, ${this.userData},${this.myBrand} }';
  }
}
