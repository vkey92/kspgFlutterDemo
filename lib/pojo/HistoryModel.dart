class HistoryModel {
  int? totalItems;
  int? currentPage;
  int? totalPage;
  List<CouponData>? couponData;

  HistoryModel(
      {this.totalItems, this.currentPage, this.totalPage, this.couponData});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    totalPage = json['TotalPage'];
    if (json['coupon_data'] != null) {
      couponData = <CouponData>[];
      json['coupon_data'].forEach((v) {
        couponData!.add(new CouponData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['currentPage'] = this.currentPage;
    data['TotalPage'] = this.totalPage;
    if (this.couponData != null) {
      data['coupon_data'] = this.couponData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponData {
  String? coupon;
  String? productName;
  String? serialNumber;
  String? scanDate;
  String? points;
  String? status;
  String? scannerEntityId;

  CouponData(
      {this.coupon,
        this.productName,
        this.serialNumber,
        this.scanDate,
        this.points,
        this.status,
        this.scannerEntityId});

  CouponData.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'];
    productName = json['ProductName'];
    serialNumber = json['serial_number'];
    scanDate = json['scan_date'];
    points = json['points'];
    status = json['status'];
    scannerEntityId = json['scanner_entity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon'] = this.coupon;
    data['ProductName'] = this.productName;
    data['serial_number'] = this.serialNumber;
    data['scan_date'] = this.scanDate;
    data['points'] = this.points;
    data['status'] = this.status;
    data['scanner_entity_id'] = this.scannerEntityId;
    return data;
  }
}