class FSSpotModel {
  bool? success;
  String? message;
  List<Data>? data;

  FSSpotModel({this.success, this.message, this.data});

  FSSpotModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? ownerStoreOperatorName;
  String? descriptionOfShop;
  String? idNumber;
  String? kraPin;
  String? certificateOfGoodConduct;
  String? businessPermit;
  String? paymentPerPackage;
  String? phone;
  String? email;
  String? address;
  String? hubLat;
  String? hubLong;
  String? currentBalance;
  int? parcelStorageCapacity;
  dynamic fsStorageSpace;
  String? physicalAddress;
  String? fullAddress;
  String? location;
  int? countryId;
  int? stateId;
  int? zoneId;
  int? subZoneId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
