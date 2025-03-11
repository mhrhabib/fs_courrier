class ParcelCrateModel {
  bool? success;
  String? message;
  Data? data;

  ParcelCrateModel({this.success, this.message, this.data});

  ParcelCrateModel.fromJson(Map<String, dynamic> json) {
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
  Merchant? merchant;
  List<Shops>? shops;
  List<DeliveryCategories>? deliveryCategories;
  List<DeliveryCharges>? deliveryCharges;
  List<CodCharges>? codCharges;
  List<Packagings>? packagings;
  List<Shifts>? shifts;
  FragileLiquids? fragileLiquids;
  List<DeliveryTypes>? deliveryTypes;

  Data({this.merchant, this.shops, this.deliveryCategories, this.deliveryCharges, this.codCharges, this.packagings, this.shifts, this.fragileLiquids, this.deliveryTypes});

  Data.fromJson(Map<String, dynamic> json) {
    merchant = json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(Shops.fromJson(v));
      });
    }
    if (json['deliveryCategories'] != null) {
      deliveryCategories = <DeliveryCategories>[];
      json['deliveryCategories'].forEach((v) {
        deliveryCategories!.add(DeliveryCategories.fromJson(v));
      });
    }
    if (json['deliveryCharges'] != null) {
      deliveryCharges = <DeliveryCharges>[];
      json['deliveryCharges'].forEach((v) {
        deliveryCharges!.add(DeliveryCharges.fromJson(v));
      });
    }
    if (json['codCharges'] != null) {
      codCharges = <CodCharges>[];
      json['codCharges'].forEach((v) {
        codCharges!.add(CodCharges.fromJson(v));
      });
    }
    if (json['packagings'] != null) {
      packagings = <Packagings>[];
      json['packagings'].forEach((v) {
        packagings!.add(Packagings.fromJson(v));
      });
    }
    if (json['shifts'] != null) {
      shifts = <Shifts>[];
      json['shifts'].forEach((v) {
        shifts!.add(Shifts.fromJson(v));
      });
    }
    fragileLiquids = json['fragileLiquids'] != null ? FragileLiquids.fromJson(json['fragileLiquids']) : null;
    if (json['deliveryTypes'] != null) {
      deliveryTypes = <DeliveryTypes>[];
      json['deliveryTypes'].forEach((v) {
        deliveryTypes!.add(DeliveryTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
    }
    if (shops != null) {
      data['shops'] = shops!.map((v) => v.toJson()).toList();
    }
    if (deliveryCategories != null) {
      data['deliveryCategories'] = deliveryCategories!.map((v) => v.toJson()).toList();
    }
    if (deliveryCharges != null) {
      data['deliveryCharges'] = deliveryCharges!.map((v) => v.toJson()).toList();
    }
    if (codCharges != null) {
      data['codCharges'] = codCharges!.map((v) => v.toJson()).toList();
    }
    if (packagings != null) {
      data['packagings'] = packagings!.map((v) => v.toJson()).toList();
    }
    if (shifts != null) {
      data['shifts'] = shifts!.map((v) => v.toJson()).toList();
    }
    if (fragileLiquids != null) {
      data['fragileLiquids'] = fragileLiquids!.toJson();
    }
    if (deliveryTypes != null) {
      data['deliveryTypes'] = deliveryTypes!.map((v) => v.toJson()).toList();
    }
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
  CodCharge? codCharges;
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
    codCharges = json['cod_charges'] != null ? CodCharge.fromJson(json['cod_charges']) : null;
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

class CodCharge {
  String? insideCity;
  String? subCity;
  String? outsideCity;

  CodCharge({this.insideCity, this.subCity, this.outsideCity});

  CodCharge.fromJson(Map<String, dynamic> json) {
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

class Shops {
  int? id;
  int? merchantId;
  String? name;
  String? contactNo;
  String? address;
  dynamic merchantLat;
  dynamic merchantLong;
  int? status;
  int? defaultShop;
  String? createdAt;
  String? updatedAt;

  Shops({this.id, this.merchantId, this.name, this.contactNo, this.address, this.merchantLat, this.merchantLong, this.status, this.defaultShop, this.createdAt, this.updatedAt});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    name = json['name'];
    contactNo = json['contact_no'];
    address = json['address'];
    merchantLat = json['merchant_lat'];
    merchantLong = json['merchant_long'];
    status = json['status'];
    defaultShop = json['default_shop'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_id'] = merchantId;
    data['name'] = name;
    data['contact_no'] = contactNo;
    data['address'] = address;
    data['merchant_lat'] = merchantLat;
    data['merchant_long'] = merchantLong;
    data['status'] = status;
    data['default_shop'] = defaultShop;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class DeliveryCategories {
  int? id;
  String? title;
  int? status;
  int? position;
  String? createdAt;
  String? updatedAt;

  DeliveryCategories({this.id, this.title, this.status, this.position, this.createdAt, this.updatedAt});

  DeliveryCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class DeliveryCharges {
  int? id;
  String? merchantId;
  String? categoryId;
  String? deliveryChargeId;
  dynamic category;
  String? weight;
  String? sameDay;
  String? nextDay;
  String? subCity;
  String? outsideCity;
  String? status;
  String? statusName;

  DeliveryCharges({this.id, this.merchantId, this.categoryId, this.deliveryChargeId, this.category, this.weight, this.sameDay, this.nextDay, this.subCity, this.outsideCity, this.status, this.statusName});

  DeliveryCharges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    categoryId = json['category_id'];
    deliveryChargeId = json['delivery_charge_id'];
    category = json['category'];
    weight = json['weight'];
    sameDay = json['same_day'];
    nextDay = json['next_day'];
    subCity = json['sub_city'];
    outsideCity = json['outside_city'];
    status = json['status'];
    statusName = json['statusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_id'] = merchantId;
    data['category_id'] = categoryId;
    data['delivery_charge_id'] = deliveryChargeId;
    data['category'] = category;
    data['weight'] = weight;
    data['same_day'] = sameDay;
    data['next_day'] = nextDay;
    data['sub_city'] = subCity;
    data['outside_city'] = outsideCity;
    data['status'] = status;
    data['statusName'] = statusName;
    return data;
  }
}

class CodCharges {
  String? name;
  String? charge;

  CodCharges({this.name, this.charge});

  CodCharges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    charge = json['charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['charge'] = charge;
    return data;
  }
}

class Packagings {
  int? id;
  String? name;
  String? price;
  int? status;
  String? position;
  dynamic photo;
  String? createdAt;
  String? updatedAt;

  Packagings({this.id, this.name, this.price, this.status, this.position, this.photo, this.createdAt, this.updatedAt});

  Packagings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    position = json['position'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['status'] = status;
    data['position'] = position;
    data['photo'] = photo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Shifts {
  int? id;
  String? name;
  String? fromTime;
  String? toTime;
  String? clientFrom;
  String? description;
  String? createdAt;
  String? updatedAt;

  Shifts({this.id, this.name, this.fromTime, this.toTime, this.clientFrom, this.description, this.createdAt, this.updatedAt});

  Shifts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    clientFrom = json['client_from'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['from_time'] = fromTime;
    data['to_time'] = toTime;
    data['client_from'] = clientFrom;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class FragileLiquids {
  int? small;
  int? medium;
  int? large;
  int? extraLarge;
  int? parcelBank;
  int? liquidFragile;

  FragileLiquids({this.small, this.medium, this.large, this.extraLarge, this.parcelBank, this.liquidFragile});

  FragileLiquids.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
    extraLarge = json['extra_large'];
    parcelBank = json['parcel_bank'];
    liquidFragile = json['liquid_fragile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['small'] = small;
    data['medium'] = medium;
    data['large'] = large;
    data['extra_large'] = extraLarge;
    data['parcel_bank'] = parcelBank;
    data['liquid_fragile'] = liquidFragile;
    return data;
  }
}

class DeliveryTypes {
  int? id;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  DeliveryTypes({this.id, this.key, this.value, this.createdAt, this.updatedAt});

  DeliveryTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
