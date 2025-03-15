import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fs_currier/global/payment/payment_screen.dart';
import '../Models/parcel_crate_model.dart';
import '../Models/parcel_logs_model.dart';
import '../Models/parcels_model.dart';
import '../Models/shop_model.dart';
import '../Screen/Widgets/button_global.dart';
import '../Screen/Widgets/constant.dart';
import '../services/api_list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class ParcelController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  bool loader = true;
  bool loaderParcel = false;
  bool loaderLogs = true;
  List<Parcels> parcelList = <Parcels>[];
  List<Shops> shopList = <Shops>[];
  List<Shifts> shiftsList = <Shifts>[];
  List<Packagings> packagingList = <Packagings>[];
  List<DeliveryCharges> deliveryChargesList = <DeliveryCharges>[];
  List<DropdownMenuItem<ShopsData>> dropDownItems = [];
  FragileLiquids fragileLiquids = FragileLiquids();
  // Selected IDs
  var selectedCountryId = 0.obs;
  var selectedCountyId = 0.obs;
  var selectedZoneId = 0.obs;
  var selectedSubZoneId = 0.obs;
  var selectedFSSpotId = 0.obs;

  var toSelectedCountryId = 0.obs;
  var toSelectedCountyId = 0.obs;
  var toSelectedZoneId = 0.obs;
  var toSelectedSubZoneId = 0.obs;
  var toSelectedFSSpotId = 0.obs;

  late int fragileLiquidAmount = 0;
  late int shopIndex = 0;
  late int packagingIndex = 0;
  late int shiftIndex = 0;
  late int deliveryChargesIndex = 0;
  Merchant merchantData = Merchant();
  DeliveryCharges deliveryChargesValue = DeliveryCharges();
  String pickupPhone = '';
  String pickupAddress = '';
  String shopID = '';
  String packagingID = '';
  String shiftID = '';
  String packagingPrice = '0';
  String deliveryChargesID = '';
  String deliveryTypID = 'Regular';
  int shipmentType = 0;
  String deliveryChargesPrice = '0';
  bool isLiquidChecked = false;
  bool isParcelBankCheck = false;
  double vatTax = 0;
  double vatAmount = 0;
  double merchantCodCharges = 0;
  double totalCashCollection = 0;
  double deliveryChargeAmount = 0;
  double codChargeAmount = 0;
  double packagingAmount = 0;
  double totalDeliveryChargeAmount = 0;
  double currentPayable = 0;
  double netPayable = 0;
  double fragileLiquidAmounts = 0;

  TextEditingController pickupPhoneController = TextEditingController();
  TextEditingController pickupAddressController = TextEditingController();
  TextEditingController cashCollectionController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customereailController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController subZoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController physicalAddressController = TextEditingController();

  List<ParcelEvents> parcelLogsList = <ParcelEvents>[];
  late Parcel parcel;

  @override
  void onInit() {
    getParcel();
    super.onInit();
  }

  getParcelList() async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    getParcel();
  }

  getParcel() {
    server.getRequest(endPoint: APIList.parcelList).then((response) {
      print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        var parcelData = ParcelsModel.fromJson(jsonResponse);
        parcelList = <Parcels>[];
        parcelList.addAll(parcelData.data!.parcels!);
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  getParcelLogs(id) {
    loaderLogs = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    parcelLogsList = <ParcelEvents>[];
    server.getRequest(endPoint: APIList.parcelLogs! + id.toString()).then((response) {
      if (response != null && response.statusCode == 200) {
        loaderLogs = false;
        final jsonResponse = json.decode(response.body);
        var parcelData = ParcelLogsModel.fromJson(jsonResponse);
        parcelLogsList = <ParcelEvents>[];
        parcelLogsList.addAll(parcelData.data!.parcelEvents!);
        parcel = parcelData.data!.parcel!;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loaderLogs = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  crateParcel() {
    server.getRequest(endPoint: APIList.parcelCreate).then((response) {
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        var data = ParcelCrateModel.fromJson(jsonResponse);

        merchantData = data.data!.merchant!;
        vatTax = double.parse(merchantData.vat.toString());
        shopList = <Shops>[];
        shopList.addAll(data.data!.shops!);
        shiftsList.clear();
        shiftsList.addAll(data.data!.shifts!);

        packagingList = <Packagings>[];
        packagingList.add(Packagings(
          id: 0,
          name: 'select_packaging'.tr,
          price: '0',
        ));
        fragileLiquids = data.data!.fragileLiquids!;
        packagingList.addAll(data.data!.packagings!);
        deliveryChargesList = <DeliveryCharges>[];
        deliveryChargesList.add(DeliveryCharges(
          id: 0,
          category: 'select_category'.tr,
          weight: '0',
        ));
        deliveryChargesList.addAll(data.data!.deliveryCharges!);
        if (shopList.isNotEmpty) {
          pickupPhone = shopList[shopIndex].contactNo.toString();
          pickupAddress = shopList[shopIndex].address.toString();
          shopID = shopList[shopIndex].id.toString();
        }
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  var senderZoneId = 0.obs;
  var senderSubZoneId = 0.obs;
  var customerZoneId = 0.obs;
  var customerSubZoneId = 0.obs;
  var paymentMethod = 1.obs;

  parcelPost(BuildContext context) {
    loaderParcel = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map chargeDetails = {
      'vatTex': merchantData.vat,
      'VatAmount': vatAmount.toStringAsFixed(2),
      'deliveryChargeAmount': deliveryChargeAmount.toStringAsFixed(2),
      'codChargeAmount': codChargeAmount.toStringAsFixed(2),
      'totalDeliveryChargeAmount': totalDeliveryChargeAmount.toStringAsFixed(2),
      'currentPayable': currentPayable.toStringAsFixed(2),
      'packagingAmount': packagingAmount.toStringAsFixed(2),
      'liquidFragileAmount': fragileLiquidAmounts.toStringAsFixed(2),
    };

    Map body = {
      'chargeDetails': jsonEncode(chargeDetails),
      'shop_id': shopID,
      'weight': deliveryChargesValue.weight == '0' ? '' : deliveryChargesValue.weight,
      'pickup_phone': pickupPhoneController.text.toString(),
      'pickup_address': pickupAddressController.text.toString(),
      'invoice_no': invoiceController.text.toString(),
      'cash_collection': cashCollectionController.text.toString(),
      'selling_price': sellingPriceController.text.toString(),
      'category_id': deliveryChargesValue.categoryId.toString(),
      'delivery_type_id': deliveryTypID == 'Regular'
          ? 1
          : deliveryTypID == 'Sub City'
              ? 3
              : deliveryTypID == 'Outside City'
                  ? 4
                  : '',
      'customer_name': customerController.text.toString(),
      'customer_email': customereailController.text.toString(),
      'customer_address': customerAddressController.text.toString(),
      'customer_phone': customerPhoneController.text.toString(),
      'note': noteController.text.toString(),
      // 'parcel_bank': isParcelBankCheck ? 'on' : '',
      'shipment_type': shipmentType,
      'packaging_id': packagingID == '0' ? '' : packagingID,
      'shift_id': shiftID == '0' ? '' : shiftID,
      'fragileLiquid': isLiquidChecked ? 'on' : '',
      'street': streetController.text.trim(),
      // 'sender_zone_id': senderZoneId.value,
      // 'sender_sub_zone_id': senderSubZoneId.value,
      // 'customer_zone_id': customerZoneId.value,
      // 'customer_sub_zone_id': customerSubZoneId.value,
      'physical_address': physicalAddressController.text.trim(),
      'pay_status': paymentMethod.value,
    };

    String jsonBody = json.encode(body);
    print(">>>>>>> $jsonBody");
    server.postRequestWithToken(endPoint: APIList.parcelStore, body: jsonBody).then((response) {
      print("under ${response}");
      print("under ${response.statusCode}");
      print("under${response.body}");
      if (response != null && response.statusCode == 200) {
        print("under yes${response}");
        print("under yes${response.statusCode}");
        print("under yes${response.body}");
        final jsonResponse = json.decode(response.body);
        clearAll();
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        if (paymentMethod.value == 1) {
          getParcelList();
          Get.back();
        }
        if (paymentMethod.value == 2 || paymentMethod.value == 3) {
          Get.off(
            () => PaymentScreen(
              paymentID: jsonResponse['data']['payment_id'],
              amount: jsonResponse['data']['amount'],
            ),
          );
        }

        Get.rawSnackbar(message: "${jsonResponse['message']}", backgroundColor: Colors.green, snackPosition: SnackPosition.TOP);
      } else if (response != null && response.statusCode == 422) {
        print("under notb ${response}");
        print("under notb ${response.statusCode}");
        print("under notb ${response.body}");
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loaderParcel = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }

  clearAll() {
    fragileLiquidAmount = 0;
    fragileLiquidAmounts = 0;
    shopIndex = 0;
    packagingIndex = 0;
    deliveryChargesIndex = 0;
    deliveryChargesValue = DeliveryCharges();
    pickupPhone = '';
    pickupAddress = '';
    shopID = '';
    packagingID = '';
    packagingPrice = '0';
    deliveryChargesID = '';
    deliveryTypID = 'Regular';
    deliveryChargesPrice = '0';
    isLiquidChecked = false;
    isParcelBankCheck = false;
    pickupPhoneController.text = '';
    pickupAddressController.text = '';
    cashCollectionController.text = '';
    sellingPriceController.text = '';
    invoiceController.text = '';
    customerController.text = '';
    customerPhoneController.text = '';
    customerAddressController.text = '';
    noteController.text = '';
    vatTax = 0;
    vatAmount = 0;
    merchantCodCharges = 0;
    totalCashCollection = 0;
    deliveryChargeAmount = 0;
    codChargeAmount = 0;
    packagingAmount = 0;
    totalDeliveryChargeAmount = 0;
    currentPayable = 0;
    netPayable = 0;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  void calculateTotal(context) {
    totalDeliveryChargeAmount = 0;
    totalCashCollection = 0;
    codChargeAmount = 0;
    totalDeliveryChargeAmount = 0;
    vatAmount = 0;
    netPayable = 0;
    currentPayable = 0;
    merchantCodCharges = 0;
    packagingAmount = 0;
    fragileLiquidAmounts = 0;

    double deliveryChargeAmount = 0;
    double merchantCodCharge = 0;

    if (deliveryTypID == 'Regular') {
      deliveryChargeAmount = double.parse(deliveryChargesValue.sameDay.toString());
      merchantCodCharge = double.parse(merchantData.codCharges!.insideCity.toString());
    } else if (deliveryTypID == 'Next Day') {
      deliveryChargeAmount = double.parse(deliveryChargesValue.nextDay.toString());
      merchantCodCharge = double.parse(merchantData.codCharges!.insideCity.toString());
    } else if (deliveryTypID == 'Sub City') {
      deliveryChargeAmount = double.parse(deliveryChargesValue.subCity.toString());
      merchantCodCharge = double.parse(merchantData.codCharges!.subCity.toString());
    } else if (deliveryTypID == 'Outside City') {
      deliveryChargeAmount = double.parse(deliveryChargesValue.outsideCity.toString());
      merchantCodCharge = double.parse(merchantData.codCharges!.outsideCity.toString());
    } else {
      deliveryChargeAmount = 0;
      merchantCodCharge = 0;
    }
    packagingAmount = double.parse(packagingPrice.toString());
    totalCashCollection = double.parse(cashCollectionController.text.toString());
    codChargeAmount = percentage(totalCashCollection, merchantCodCharge);
    // if (isLiquidChecked) {
    totalDeliveryChargeAmount = (deliveryChargeAmount + codChargeAmount + fragileLiquidAmount + packagingAmount);
    fragileLiquidAmounts = double.parse(fragileLiquidAmount.toString());
    // } else {
    //   totalDeliveryChargeAmount = (deliveryChargeAmount + codChargeAmount + packagingAmount);
    //   fragileLiquidAmounts = 0;
    // }

    vatAmount = percentage(totalDeliveryChargeAmount, vatTax);
    netPayable = (totalDeliveryChargeAmount + vatAmount);
    currentPayable = (totalCashCollection - (totalDeliveryChargeAmount + vatAmount));
    merchantCodCharges = merchantCodCharge;
    print('packagingAmount==> ' + '${packagingAmount}');
    print('deliveryChargeAmount==> ' + '${deliveryChargeAmount}');
    print('totalDeliveryChargeAmount==> ' + '${totalDeliveryChargeAmount}');
    print('totalCashCollection==> ' + '${totalCashCollection}');
    print('vatAmount==> ' + '${vatAmount}');
    print('codChargeAmount==> ' + '${codChargeAmount}');
    print('netPayable==> ' + '${netPayable}');
    print('currentPayable==> ' + '${currentPayable}');

    showPopUp(context, totalCashCollection, deliveryChargeAmount, codChargeAmount, fragileLiquidAmounts, packagingAmount, totalDeliveryChargeAmount, vatAmount, netPayable, currentPayable);
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  percentage(totalAmount, percentageAmount) {
    return totalAmount * (percentageAmount / 100);
  }

  void showPopUp(context, totalCashCollectionParcel, deliveryChargeAmountParcel, codChargeAmountParcel, fragileLiquidAmountsParcel, packagingAmountParcel, totalDeliveryChargeAmountParcel, vatAmountParcel, netPayableParcel, currentPayableParcel) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'charge_details'.tr,
                    style: kTextStyle.copyWith(color: kSecondaryColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: Text(
                      'title'.tr,
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    trailing: Text(
                      'amount_tk'.tr,
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'cash_collection'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${totalCashCollectionParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'delivery_charges'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${deliveryChargeAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'cod_charge'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${codChargeAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'liquid_fragile_charge'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${fragileLiquidAmountsParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'p_charge'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${packagingAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'total_charge'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${totalDeliveryChargeAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'vat'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${vatAmountParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'net_payable'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${netPayableParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'current_payable'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${currentPayableParcel.toStringAsFixed(2)}',
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  ButtonGlobal(
                      buttontext: 'confirm'.tr,
                      buttonDecoration: kButtonDecoration,
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        await parcelPost(context);
                        Get.back();
                        // Get.off(ParcelPage());
                      })
                ],
              )),
            ),
          );
        });
  }
}
