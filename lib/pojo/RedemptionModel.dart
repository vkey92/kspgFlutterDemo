/// totalItems : 1
/// currentPage : 0
/// TotalPage : 1
/// redeemption_data : [{"PartnerType":"Reborer","UserCode":"REB000098","OnRequestTotalPoints":"115","TransactionId":"TRAN000001","RedeempRequestPoints":"5","status":"RequestOpen","requestOn":"2022-01-15 12:26:06","actionOn":null}]

class RedemptionModel {
  RedemptionModel({
      this.totalItems, 
      this.currentPage, 
      this.totalPage, 
      this.redeemptionData,});

  RedemptionModel.fromJson(dynamic json) {
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    totalPage = json['TotalPage'];
    if (json['redeemption_data'] != null) {
      redeemptionData = [];
      json['redeemption_data'].forEach((v) {
        redeemptionData?.add(RedeemptionData.fromJson(v));
      });
    }
  }
  int? totalItems;
  int? currentPage;
  int? totalPage;
  List<RedeemptionData>? redeemptionData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalItems'] = totalItems;
    map['currentPage'] = currentPage;
    map['TotalPage'] = totalPage;
    if (redeemptionData != null) {
      map['redeemption_data'] = redeemptionData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// PartnerType : "Reborer"
/// UserCode : "REB000098"
/// OnRequestTotalPoints : "115"
/// TransactionId : "TRAN000001"
/// RedeempRequestPoints : "5"
/// status : "RequestOpen"
/// requestOn : "2022-01-15 12:26:06"
/// actionOn : null

class RedeemptionData {
  RedeemptionData({
      this.partnerType, 
      this.userCode, 
      this.onRequestTotalPoints, 
      this.transactionId, 
      this.redeempRequestPoints, 
      this.status, 
      this.requestOn, 
      this.actionOn,});

  RedeemptionData.fromJson(dynamic json) {
    partnerType = json['PartnerType'];
    userCode = json['UserCode'];
    onRequestTotalPoints = json['OnRequestTotalPoints'];
    transactionId = json['TransactionId'];
    redeempRequestPoints = json['RedeempRequestPoints'];
    status = json['status'];
    requestOn = json['requestOn'];
    actionOn = json['actionOn'];
  }
  String? partnerType;
  String? userCode;
  String? onRequestTotalPoints;
  String? transactionId;
  String? redeempRequestPoints;
  String? status;
  String? requestOn;
  dynamic actionOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PartnerType'] = partnerType;
    map['UserCode'] = userCode;
    map['OnRequestTotalPoints'] = onRequestTotalPoints;
    map['TransactionId'] = transactionId;
    map['RedeempRequestPoints'] = redeempRequestPoints;
    map['status'] = status;
    map['requestOn'] = requestOn;
    map['actionOn'] = actionOn;
    return map;
  }

}