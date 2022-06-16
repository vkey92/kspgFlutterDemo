/// status : true
/// register : {"UserCode":"REB000098","ShopName":"Mauli","FirstName":"Madhusudan","MiddleName":"","LastName":"Rathore","AddressLine1":"c6","AddressLine2":"Vijay vihar","Mobile":"7976268912","Mobile2":"","Email":"rathore.madhusudan@gmail.com","Zip":"302039","Area":"ambabari","selectedCity":"Jaipur","State":"Rajasthan","Country":"India","AadharCardNo":"777788887878","DrivingLicenseNo":"Dl1333","PANNo":"783637Ll","Gender":"Male","DateOfBirth":"1990-04-02","SizeOfWorkshop":"300+","ServicePerMonth":null,"ProfilePictureUrl":"https://ascent-abcare.s3.amazonaws.com/kspg/1348/madhusudan_image_63.jpg","WorkshopPhotoUrl":"","EnginesOverhauled":"5","YearOfExperience":8,"BankName":"HDFC Bank","BankDocImage":"https://ascent-abcare.s3.amazonaws.com/https://ascent-abcare.s3.amazonaws.com/kspg/1468/1637749457156_18.jpg","BankDocImageUrl":"https://ascent-abcare.s3.amazonaws.com/https://ascent-abcare.s3.amazonaws.com/kspg/1468/1637749457156_18.jpg","BankHolderName":"Madhusudan","BankAccountNumber":"0987654321","ConformBankAccountNumber":"0987654321","BankIFSCCode":"HDFC0000054","BankMICR":"302240002"}

class ProfileModel {
  ProfileModel({
      this.status, 
      this.register,});

  ProfileModel.fromJson(dynamic json) {
    status = json['status'];
    register = json['register'] != null ? Register.fromJson(json['register']) : null;
  }
  bool? status;
  Register? register;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (register != null) {
      map['register'] = register?.toJson();
    }
    return map;
  }

}

/// UserCode : "REB000098"
/// ShopName : "Mauli"
/// FirstName : "Madhusudan"
/// MiddleName : ""
/// LastName : "Rathore"
/// AddressLine1 : "c6"
/// AddressLine2 : "Vijay vihar"
/// Mobile : "7976268912"
/// Mobile2 : ""
/// Email : "rathore.madhusudan@gmail.com"
/// Zip : "302039"
/// Area : "ambabari"
/// selectedCity : "Jaipur"
/// State : "Rajasthan"
/// Country : "India"
/// AadharCardNo : "777788887878"
/// DrivingLicenseNo : "Dl1333"
/// PANNo : "783637Ll"
/// Gender : "Male"
/// DateOfBirth : "1990-04-02"
/// SizeOfWorkshop : "300+"
/// ServicePerMonth : null
/// ProfilePictureUrl : "https://ascent-abcare.s3.amazonaws.com/kspg/1348/madhusudan_image_63.jpg"
/// WorkshopPhotoUrl : ""
/// EnginesOverhauled : "5"
/// YearOfExperience : 8
/// BankName : "HDFC Bank"
/// BankDocImage : "https://ascent-abcare.s3.amazonaws.com/https://ascent-abcare.s3.amazonaws.com/kspg/1468/1637749457156_18.jpg"
/// BankDocImageUrl : "https://ascent-abcare.s3.amazonaws.com/https://ascent-abcare.s3.amazonaws.com/kspg/1468/1637749457156_18.jpg"
/// BankHolderName : "Madhusudan"
/// BankAccountNumber : "0987654321"
/// ConformBankAccountNumber : "0987654321"
/// BankIFSCCode : "HDFC0000054"
/// BankMICR : "302240002"

class Register {
  Register({
      this.userCode, 
      this.shopName, 
      this.firstName, 
      this.middleName, 
      this.lastName, 
      this.addressLine1, 
      this.addressLine2, 
      this.mobile, 
      this.mobile2, 
      this.email, 
      this.zip, 
      this.area, 
      this.selectedCity, 
      this.state, 
      this.country, 
      this.aadharCardNo, 
      this.drivingLicenseNo, 
      this.pANNo, 
      this.gender, 
      this.dateOfBirth, 
      this.sizeOfWorkshop, 
      this.servicePerMonth, 
      this.profilePictureUrl, 
      this.workshopPhotoUrl, 
      this.enginesOverhauled, 
      this.yearOfExperience, 
      this.bankName, 
      this.bankDocImage, 
      this.bankDocImageUrl, 
      this.bankHolderName, 
      this.bankAccountNumber, 
      this.conformBankAccountNumber, 
      this.bankIFSCCode, 
      this.bankMICR,
      this.Items,
      this.ProfilePicturePath,
      this.WorkShopPhotoPath,
    this.SalesTurnoverPerYear
  });

  Register.fromJson(dynamic json) {
    userCode = json['UserCode'];
    shopName = json['ShopName'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    mobile = json['Mobile'];
    mobile2 = json['Mobile2'];
    email = json['Email'];
    zip = json['Zip'];
    area = json['Area'];
    selectedCity = json['selectedCity'];
    state = json['State'];
    country = json['Country'];
    Items = json['Items'];
    ProfilePicturePath = json['ProfilePicturePath'];
    WorkShopPhotoPath = json['WorkShopPhotoPath'];
    SalesTurnoverPerYear = json['SalesTurnoverPerYear'];
    aadharCardNo = json['AadharCardNo'];
    drivingLicenseNo = json['DrivingLicenseNo'];
    pANNo = json['PANNo'];
    gender = json['Gender'];
    dateOfBirth = json['DateOfBirth'];
    sizeOfWorkshop = json['SizeOfWorkshop'];
    servicePerMonth = json['ServicePerMonth'];
    profilePictureUrl = json['ProfilePictureUrl'];
    workshopPhotoUrl = json['WorkshopPhotoUrl'];
    enginesOverhauled = json['EnginesOverhauled'];
    yearOfExperience = json['YearOfExperience'];
    bankName = json['BankName'];
    bankDocImage = json['BankDocImage'];
    bankDocImageUrl = json['BankDocImageUrl'];
    bankHolderName = json['BankHolderName'];
    bankAccountNumber = json['BankAccountNumber'];
    conformBankAccountNumber = json['ConformBankAccountNumber'];
    bankIFSCCode = json['BankIFSCCode'];
    bankMICR = json['BankMICR'];
  }
  String? userCode;
  String? shopName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? addressLine1;
  String? addressLine2;
  String? mobile;
  String? mobile2;
  String? email;
  String? zip;
  String? Items;
  String? ProfilePicturePath;
  String? WorkShopPhotoPath;
  String? SalesTurnoverPerYear;
  String? area;
  String? selectedCity;
  String? state;
  String? country;
  String? aadharCardNo;
  String? drivingLicenseNo;
  String? pANNo;
  String? gender;
  String? dateOfBirth;
  String? sizeOfWorkshop;
  dynamic servicePerMonth;
  String? profilePictureUrl;
  String? workshopPhotoUrl;
  String? enginesOverhauled;
  int? yearOfExperience;
  String? bankName;
  String? bankDocImage;
  String? bankDocImageUrl;
  String? bankHolderName;
  String? bankAccountNumber;
  String? conformBankAccountNumber;
  String? bankIFSCCode;
  String? bankMICR;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserCode'] = userCode;
    map['ShopName'] = shopName;
    map['FirstName'] = firstName;
    map['MiddleName'] = middleName;
    map['LastName'] = lastName;
    map['AddressLine1'] = addressLine1;
    map['AddressLine2'] = addressLine2;
    map['Mobile'] = mobile;
    map['Mobile2'] = mobile2;
    map['Email'] = email;
    map['Zip'] = zip;
    map['Area'] = area;
    map['selectedCity'] = selectedCity;
    map['State'] = state;
    map['Country'] = country;
    map['AadharCardNo'] = aadharCardNo;
    map['DrivingLicenseNo'] = drivingLicenseNo;
    map['PANNo'] = pANNo;
    map['Gender'] = gender;
    map['DateOfBirth'] = dateOfBirth;
    map['SizeOfWorkshop'] = sizeOfWorkshop;
    map['ServicePerMonth'] = servicePerMonth;
    map['ProfilePictureUrl'] = profilePictureUrl;
    map['WorkshopPhotoUrl'] = workshopPhotoUrl;
    map['EnginesOverhauled'] = enginesOverhauled;
    map['YearOfExperience'] = yearOfExperience;
    map['BankName'] = bankName;
    map['BankDocImage'] = bankDocImage;
    map['BankDocImageUrl'] = bankDocImageUrl;
    map['BankHolderName'] = bankHolderName;
    map['BankAccountNumber'] = bankAccountNumber;
    map['ConformBankAccountNumber'] = conformBankAccountNumber;
    map['BankIFSCCode'] = bankIFSCCode;
    map['BankMICR'] = bankMICR;
    return map;
  }

}