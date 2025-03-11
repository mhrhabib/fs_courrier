class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  User? user;
  String? userType;

  Data({this.token, this.user, this.userType});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['user_type'] = userType;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? userType;
  String? hubId;
  Hub? hub;
  Merchant? merchant;
  int? merchantTotalParcel;
  String? merchantTotalCashAmount;
  String? merchantCurrentPayable;
  dynamic joiningDate;
  String? address;
  String? salary;
  String? status;
  String? verificationStatus;
  String? statusName;
  String? image;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.userType,
      this.hubId,
      this.hub,
      this.merchant,
      this.merchantTotalParcel,
      this.merchantTotalCashAmount,
      this.merchantCurrentPayable,
      this.joiningDate,
      this.address,
      this.salary,
      this.status,
      this.verificationStatus,
      this.statusName,
      this.image,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['user_type'];
    hubId = json['hub_id'];
    hub = json['hub'] != null ? Hub.fromJson(json['hub']) : null;
    merchant = json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;
    merchantTotalParcel = json['merchant_total_parcel'];
    merchantTotalCashAmount = json['merchant_total_cash_amount'];
    merchantCurrentPayable = json['merchant_current_payable'];
    joiningDate = json['joining_date'];
    address = json['address'];
    salary = json['salary'];
    status = json['status'];
    verificationStatus = json['verification_status'];
    statusName = json['statusName'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['user_type'] = userType;
    data['hub_id'] = hubId;
    if (hub != null) {
      data['hub'] = hub!.toJson();
    }
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
    }
    data['merchant_total_parcel'] = merchantTotalParcel;
    data['merchant_total_cash_amount'] = merchantTotalCashAmount;
    data['merchant_current_payable'] = merchantCurrentPayable;
    data['joining_date'] = joiningDate;
    data['address'] = address;
    data['salary'] = salary;
    data['status'] = status;
    data['verification_status'] = verificationStatus;
    data['statusName'] = statusName;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Hub {
  int? id;
  String? name;
  dynamic ownerStoreOperatorName;
  dynamic descriptionOfShop;
  dynamic idNumber;
  dynamic kraPin;
  dynamic certificateOfGoodConduct;
  dynamic businessPermit;
  dynamic paymentPerPackage;
  String? phone;
  dynamic email;
  String? address;
  dynamic hubLat;
  dynamic hubLong;
  String? currentBalance;
  dynamic parcelStorageCapacity;
  dynamic fsStorageSpace;
  dynamic physicalAddress;
  dynamic fullAddress;
  dynamic location;
  dynamic countryId;
  dynamic stateId;
  dynamic zoneId;
  dynamic subZoneId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Hub(
      {this.id,
      this.name,
      this.ownerStoreOperatorName,
      this.descriptionOfShop,
      this.idNumber,
      this.kraPin,
      this.certificateOfGoodConduct,
      this.businessPermit,
      this.paymentPerPackage,
      this.phone,
      this.email,
      this.address,
      this.hubLat,
      this.hubLong,
      this.currentBalance,
      this.parcelStorageCapacity,
      this.fsStorageSpace,
      this.physicalAddress,
      this.fullAddress,
      this.location,
      this.countryId,
      this.stateId,
      this.zoneId,
      this.subZoneId,
      this.status,
      this.createdAt,
      this.updatedAt});

  Hub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ownerStoreOperatorName = json['owner_store_operator_name'];
    descriptionOfShop = json['description_of_shop'];
    idNumber = json['id_number'];
    kraPin = json['kra_pin'];
    certificateOfGoodConduct = json['certificate_of_good_conduct'];
    businessPermit = json['business_permit'];
    paymentPerPackage = json['payment_per_package'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    hubLat = json['hub_lat'];
    hubLong = json['hub_long'];
    currentBalance = json['current_balance'];
    parcelStorageCapacity = json['parcel_storage_capacity'];
    fsStorageSpace = json['fs_storage_space'];
    physicalAddress = json['physical_address'];
    fullAddress = json['full_address'];
    location = json['location'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    zoneId = json['zone_id'];
    subZoneId = json['sub_zone_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['owner_store_operator_name'] = ownerStoreOperatorName;
    data['description_of_shop'] = descriptionOfShop;
    data['id_number'] = idNumber;
    data['kra_pin'] = kraPin;
    data['certificate_of_good_conduct'] = certificateOfGoodConduct;
    data['business_permit'] = businessPermit;
    data['payment_per_package'] = paymentPerPackage;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['hub_lat'] = hubLat;
    data['hub_long'] = hubLong;
    data['current_balance'] = currentBalance;
    data['parcel_storage_capacity'] = parcelStorageCapacity;
    data['fs_storage_space'] = fsStorageSpace;
    data['physical_address'] = physicalAddress;
    data['full_address'] = fullAddress;
    data['location'] = location;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['zone_id'] = zoneId;
    data['sub_zone_id'] = subZoneId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Merchant {
  int? id;
  int? userId;
  String? merchantType;
  String? businessName;
  String? merchantUniqueId;
  String? currentBalance;
  String? openingBalance;
  String? walletBalance;
  String? vat;
  CodCharges? codCharges;
  int? nidId;
  int? tradeLicense;
  String? paymentPeriod;
  int? status;
  String? address;
  int? walletUseActivation;
  String? returnCharges;
  dynamic referenceName;
  dynamic referencePhone;
  dynamic webhookCallbackUrl;
  dynamic webhookSecret;
  String? createdAt;
  String? updatedAt;

  Merchant(
      {this.id,
      this.userId,
      this.merchantType,
      this.businessName,
      this.merchantUniqueId,
      this.currentBalance,
      this.openingBalance,
      this.walletBalance,
      this.vat,
      this.codCharges,
      this.nidId,
      this.tradeLicense,
      this.paymentPeriod,
      this.status,
      this.address,
      this.walletUseActivation,
      this.returnCharges,
      this.referenceName,
      this.referencePhone,
      this.webhookCallbackUrl,
      this.webhookSecret,
      this.createdAt,
      this.updatedAt});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    merchantType = json['merchant_type'];
    businessName = json['business_name'];
    merchantUniqueId = json['merchant_unique_id'];
    currentBalance = json['current_balance'];
    openingBalance = json['opening_balance'];
    walletBalance = json['wallet_balance'];
    vat = json['vat'];
    codCharges = json['cod_charges'] != null ? CodCharges.fromJson(json['cod_charges']) : null;
    nidId = json['nid_id'];
    tradeLicense = json['trade_license'];
    paymentPeriod = json['payment_period'];
    status = json['status'];
    address = json['address'];
    walletUseActivation = json['wallet_use_activation'];
    returnCharges = json['return_charges'];
    referenceName = json['reference_name'];
    referencePhone = json['reference_phone'];
    webhookCallbackUrl = json['webhook_callback_url'];
    webhookSecret = json['webhook_secret'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['merchant_type'] = merchantType;
    data['business_name'] = businessName;
    data['merchant_unique_id'] = merchantUniqueId;
    data['current_balance'] = currentBalance;
    data['opening_balance'] = openingBalance;
    data['wallet_balance'] = walletBalance;
    data['vat'] = vat;
    if (codCharges != null) {
      data['cod_charges'] = codCharges!.toJson();
    }
    data['nid_id'] = nidId;
    data['trade_license'] = tradeLicense;
    data['payment_period'] = paymentPeriod;
    data['status'] = status;
    data['address'] = address;
    data['wallet_use_activation'] = walletUseActivation;
    data['return_charges'] = returnCharges;
    data['reference_name'] = referenceName;
    data['reference_phone'] = referencePhone;
    data['webhook_callback_url'] = webhookCallbackUrl;
    data['webhook_secret'] = webhookSecret;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CodCharges {
  String? insideCity;
  String? subCity;
  String? outsideCity;

  CodCharges({this.insideCity, this.subCity, this.outsideCity});

  CodCharges.fromJson(Map<String, dynamic> json) {
    insideCity = json['inside_city'];
    subCity = json['sub_city'];
    outsideCity = json['outside_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inside_city'] = insideCity;
    data['sub_city'] = subCity;
    data['outside_city'] = outsideCity;
    return data;
  }
}
