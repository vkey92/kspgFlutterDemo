/// bank : {"ADDRESS":"O 10 ASHOSK MARG C SCHEME JAIPUR","BANK":"HDFC Bank","BANKCODE":"HDFC","BRANCH":"ASHOK MARG C SCHEME","CITY":"JAIPUR","DISTRICT":"JAIPUR","IFSC":"HDFC0000054","MICR":"302240002","STATE":"RAJASTHAN"}
/// status : true

class IfscModel {
  IfscModel({
      this.bank, 
      this.status,});

  IfscModel.fromJson(dynamic json) {
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    status = json['status'];
  }
  Bank? bank;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bank != null) {
      map['bank'] = bank?.toJson();
    }
    map['status'] = status;
    return map;
  }

}

/// ADDRESS : "O 10 ASHOSK MARG C SCHEME JAIPUR"
/// BANK : "HDFC Bank"
/// BANKCODE : "HDFC"
/// BRANCH : "ASHOK MARG C SCHEME"
/// CITY : "JAIPUR"
/// DISTRICT : "JAIPUR"
/// IFSC : "HDFC0000054"
/// MICR : "302240002"
/// STATE : "RAJASTHAN"

class Bank {
  Bank({
      this.address, 
      this.bank, 
      this.bankcode, 
      this.branch, 
      this.city, 
      this.district, 
      this.ifsc, 
      this.micr, 
      this.state,});

  Bank.fromJson(dynamic json) {
    address = json['ADDRESS'];
    bank = json['BANK'];
    bankcode = json['BANKCODE'];
    branch = json['BRANCH'];
    city = json['CITY'];
    district = json['DISTRICT'];
    ifsc = json['IFSC'];
    micr = json['MICR'];
    state = json['STATE'];
  }
  String? address;
  String? bank;
  String? bankcode;
  String? branch;
  String? city;
  String? district;
  String? ifsc;
  String? micr;
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ADDRESS'] = address;
    map['BANK'] = bank;
    map['BANKCODE'] = bankcode;
    map['BRANCH'] = branch;
    map['CITY'] = city;
    map['DISTRICT'] = district;
    map['IFSC'] = ifsc;
    map['MICR'] = micr;
    map['STATE'] = state;
    return map;
  }

}