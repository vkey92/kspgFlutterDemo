/// data : [{"coupon":"4907990203229","status":"Invalid Coupon"}]
/// status : true

class ScanModel {
  ScanModel({
       this.data, 
       this.status,});

  ScanModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Data>? data;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }

}

/// coupon : "4907990203229"
/// status : "Invalid Coupon"

class Data {
  Data({
      required this.coupon, 
      required this.status,});

  Data.fromJson(dynamic json) {
    coupon = json['coupon'];
    status = json['status'];
  }
  String coupon = "";
  String status = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coupon'] = coupon;
    map['status'] = status;
    return map;
  }

}