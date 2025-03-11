class InvoiceDetailsModel {
  int? id;
  String? invoiceId;
  String? status;
  double? totalDeliverdAmount;
  String? deliveryCharge;
  double? amount;
  String? codAmount;
  String? totalReturnFee;
  String? payableAmount;
  String? invoiceDate;
  String? merchantName;
  String? merchantPhone;
  String? merchantAddress;
  int? totalParcels;
  Parcels? parcels;

  InvoiceDetailsModel(
      {this.id,
      this.invoiceId,
      this.status,
      this.totalDeliverdAmount,
      this.deliveryCharge,
      this.amount,
      this.codAmount,
      this.totalReturnFee,
      this.payableAmount,
      this.invoiceDate,
      this.merchantName,
      this.merchantPhone,
      this.merchantAddress,
      this.totalParcels,
      this.parcels});

  InvoiceDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    status = json['status'];
    totalDeliverdAmount = json['total_deliverd_amount'] != null ? json['total_deliverd_amount'] * 1.0 : 0;
    deliveryCharge = json['delivery_charge'].toString();
    codAmount = json['cod_amount'];
    amount = json['amount'] != null ? json['amount'] * 1.0 : 0;
    totalReturnFee = json['total_return_fee'].toString();
    payableAmount = json['payable_amount'].toString();
    invoiceDate = json['invoice_date'];
    merchantName = json['merchant_name'];
    merchantPhone = json['merchant_phone'];
    merchantAddress = json['merchant_address'];
    totalParcels = json['total_parcels'];
    parcels = json['parcels'] != null ? Parcels.fromJson(json['parcels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['invoice_id'] = invoiceId;
    data['status'] = status;
    data['total_deliverd_amount'] = totalDeliverdAmount;
    data['delivery_charge'] = deliveryCharge;
    data['amount'] = amount;
    data['cod_amount'] = codAmount;
    data['total_return_fee'] = totalReturnFee;
    data['payable_amount'] = payableAmount;
    data['invoice_date'] = invoiceDate;
    data['merchant_name'] = merchantName;
    data['merchant_phone'] = merchantPhone;
    data['merchant_address'] = merchantAddress;
    data['total_parcels'] = totalParcels;
    if (parcels != null) {
      data['parcels'] = parcels!.toJson();
    }
    return data;
  }
}

class Parcels {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Parcels({this.currentPage, this.data, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.links, this.nextPageUrl, this.path, this.perPage, this.prevPageUrl, this.to, this.total});

  Parcels.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  String? customerName;
  String? customerPhone;
  String? invoiceNo;
  String? trackingId;
  String? status;
  String? cashCollection;
  String? deliveryCharge;
  String? codAmount;
  String? totalDeliveryAmount;
  String? currentPayable;

  Data({this.id, this.customerName, this.customerPhone, this.invoiceNo, this.trackingId, this.status, this.cashCollection, this.deliveryCharge, this.codAmount, this.totalDeliveryAmount, this.currentPayable});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    invoiceNo = json['invoice_no'];
    trackingId = json['tracking_id'];
    status = json['status'].toString();
    cashCollection = json['cash_collection'];
    deliveryCharge = json['delivery_charge'];
    codAmount = json['cod_amount'];
    totalDeliveryAmount = json['total_delivery_amount'];
    currentPayable = json['current_payable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_name'] = customerName;
    data['customer_phone'] = customerPhone;
    data['invoice_no'] = invoiceNo;
    data['tracking_id'] = trackingId;
    data['status'] = status;
    data['cash_collection'] = cashCollection;
    data['delivery_charge'] = deliveryCharge;
    data['cod_amount'] = codAmount;
    data['total_delivery_amount'] = totalDeliveryAmount;
    data['current_payable'] = currentPayable;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
