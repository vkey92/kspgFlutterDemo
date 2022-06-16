/// data : {"images":{"path":"kspg/1468/IMG_20220427_165516_14.jpg","url":"https://ascent-abcare.s3.amazonaws.com/kspg/1468/IMG_20220427_165516_14.jpg"},"upload_type":"Genaral","unique_key":"profile"}
/// status : true
/// message : "Images Upload Successfully."

class UploadModel {
  UploadModel({
      this.data, 
      this.status, 
      this.message,});

  UploadModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }
  Data? data;
  bool? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}

/// images : {"path":"kspg/1468/IMG_20220427_165516_14.jpg","url":"https://ascent-abcare.s3.amazonaws.com/kspg/1468/IMG_20220427_165516_14.jpg"}
/// upload_type : "Genaral"
/// unique_key : "profile"

class Data {
  Data({
      this.images, 
      this.uploadType, 
      this.uniqueKey,});

  Data.fromJson(dynamic json) {
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    uploadType = json['upload_type'];
    uniqueKey = json['unique_key'];
  }
  Images? images;
  String? uploadType;
  String? uniqueKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (images != null) {
      map['images'] = images?.toJson();
    }
    map['upload_type'] = uploadType;
    map['unique_key'] = uniqueKey;
    return map;
  }

}

/// path : "kspg/1468/IMG_20220427_165516_14.jpg"
/// url : "https://ascent-abcare.s3.amazonaws.com/kspg/1468/IMG_20220427_165516_14.jpg"

class Images {
  Images({
      this.path, 
      this.url,});

  Images.fromJson(dynamic json) {
    path = json['path'];
    url = json['url'];
  }
  String? path;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['url'] = url;
    return map;
  }

}