/// status : true
/// data : {"AvailablePoints":110,"TotalPoints":115}

class PointsModel {
  PointsModel({
      this.status, 
      this.data,});

  PointsModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// AvailablePoints : 110
/// TotalPoints : 115

class Data {
  Data({
      this.availablePoints, 
      this.totalPoints,});

  Data.fromJson(dynamic json) {
    availablePoints = json['AvailablePoints'];
    totalPoints = json['TotalPoints'];
  }
  int? availablePoints;
  int? totalPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AvailablePoints'] = availablePoints;
    map['TotalPoints'] = totalPoints;
    return map;
  }

}