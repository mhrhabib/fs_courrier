import 'package:fs_currier/Screen/Parcel/location_selection_screen.dart';
import 'package:fs_currier/global/controllers/global_controller.dart';
import 'package:fs_currier/utils/storage.dart';
import '../../MapAddress/flutter_google_places_web.dart';
import '../../services/api_list.dart';
import '../Widgets/custom_dropdown.dart';
import '/Screen/Widgets/button_global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Controllers/parcel_controller.dart';
import '../../Models/parcel_crate_model.dart';
import '../../utils/size_config.dart';
import '../Widgets/constant.dart';
import '../Widgets/loader.dart';

class CreateParcel extends StatefulWidget {
  const CreateParcel({super.key});

  @override
  State<CreateParcel> createState() => _CreateParcelState();
}

class _CreateParcelState extends State<CreateParcel> {
  ParcelController parcelController = Get.put(ParcelController());
  final GlobalsController globalsController = Get.put(GlobalsController());
  final _formKey = GlobalKey<FormState>();

  String? packageType;

  List<String> deliveryType = [
    'Regular',
    'Sub City',
    'Outside City',
  ];
  String type = 'Regular';

  DropdownButton<String> selectType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in deliveryType) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: type,
      onChanged: (value) {
        setState(() {
          type = value!;
          Get.find<ParcelController>().deliveryTypID = type;
        });
      },
    );
  }

  List<String> shipmentType = [
    'Select Shipment Type',
    'Fs Spots Shipment',
    'Pickup From Fs Spots',
    'Fs Office/Home Shipment',
  ];
  String sType = 'Select Shipment Type';
  int getShipmentTypeIndex(String sType) {
    return shipmentType.indexOf(sType);
  }

  DropdownButton<String> selectShipmentType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in shipmentType) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: sType,
      onChanged: (value) {
        setState(() {
          sType = value!;
          int index = getShipmentTypeIndex(sType);
          Get.find<ParcelController>().shipmentType = index;
          print(index);
          print(Get.find<ParcelController>().shipmentType);
        });
      },
    );
  }

  List<Map<String, dynamic>> paymentType = [
    {
      'name': 'PAY AFTER DELIVERY',
      'value': 1,
    },
    {
      'name': 'PARTIAL PAY',
      'value': 2,
    },
    {
      'name': 'ONLINE PAY',
      'value': 3,
    }
  ];
  List<Map<String, dynamic>> paymentTypeUser = [
    {
      'name': 'PAY AFTER DELIVERY',
      'value': 1,
    },
    {
      'name': 'ONLINE PAY',
      'value': 3,
    }
  ];

  String? selectedPayment;
  String? selectedCategory;
  int? selectedWeight;

  @override
  void initState() {
    parcelController.crateParcel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);
    return Scaffold(
        backgroundColor: kMainColor,
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(
            'create_parcel'.tr,
            style: kTextStyle.copyWith(color: kBgColor),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
                Get.find<ParcelController>().clearAll();
              },
              icon: Icon(
                Icons.arrow_back,
                color: kBgColor,
              )),
          backgroundColor: kMainColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: kBgColor),
        ),
        body: GetBuilder<ParcelController>(
            init: ParcelController(),
            builder: (parcel) => Stack(children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: kGreyTextColor.withValues(alpha: 0.2)),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20.0),
                                    parcel.shopList.isEmpty
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 60.0,
                                            child: FormField(
                                              builder: (FormFieldState<dynamic> field) {
                                                return InputDecorator(
                                                    decoration: kInputDecoration.copyWith(
                                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                                      labelText: 'shop'.tr,
                                                      hintText: 'select_shop'.tr,
                                                      labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                      ),
                                                    ),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<Shops>(
                                                        value: parcel.shopIndex.toString() == 'null' ? null : parcel.shopList[parcel.shopIndex],
                                                        items: parcel.shopList.map((Shops value) {
                                                          return DropdownMenuItem<Shops>(
                                                            value: value,
                                                            child: Text(value.name.toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            parcel.shopIndex = parcel.shopList.indexOf(newValue!);
                                                            parcel.shopID = newValue.id.toString();
                                                            parcel.pickupAddress = newValue.address.toString();
                                                            parcel.pickupPhone = newValue.contactNo.toString();
                                                          });
                                                        },
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                                    const SizedBox(height: 20.0),
                                    AppTextField(
                                      onChanged: (value) {
                                        setState(() {
                                          parcel.pickupPhone = parcel.pickupPhoneController.text;
                                        });
                                      },
                                      controller: parcel.pickupPhoneController
                                        ..text = parcel.pickupPhone.toString()
                                        ..selection = TextSelection.collapsed(offset: parcel.pickupPhoneController.text.length),
                                      showCursor: true,
                                      validator: (value) {
                                        if (parcel.pickupPhoneController.text.isEmpty) {
                                          return "this_field_can_t_be_empty".tr;
                                        }
                                        return null;
                                      },
                                      cursorColor: kTitleColor,
                                      textFieldType: TextFieldType.PHONE,
                                      decoration: kInputDecoration.copyWith(
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                          borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                        ),
                                        labelText: 'pickup_phone'.tr,
                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                        hintText: '017XXXXXXXX',
                                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    AppTextField(
                                      onChanged: (value) {
                                        setState(() {
                                          parcel.pickupAddress = parcel.pickupAddressController.text;
                                        });
                                      },
                                      controller: parcel.pickupAddressController
                                        ..text = parcel.pickupAddress.toString()
                                        ..selection = TextSelection.collapsed(offset: parcel.pickupAddressController.text.length),
                                      showCursor: true,
                                      validator: (value) {
                                        if (parcel.pickupAddressController.text.isEmpty) {
                                          return "this_field_can_t_be_empty".tr;
                                        }
                                        return null;
                                      },
                                      cursorColor: kTitleColor,
                                      textFieldType: TextFieldType.NAME,
                                      decoration: kInputDecoration.copyWith(
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                          borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                        ),
                                        labelText: 'pickup_address'.tr,
                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                        hintText: 'enter_address'.tr,
                                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                      ),
                                    ),
                                    isFsUser ? SizedBox.shrink() : const SizedBox(height: 20.0),
                                    isFsUser
                                        ? SizedBox.shrink()
                                        : AppTextField(
                                            controller: parcel.cashCollectionController,
                                            validator: (value) {
                                              if (parcel.cashCollectionController.text.isEmpty) {
                                                return "this_field_can_t_be_empty".tr;
                                              }
                                              return null;
                                            },
                                            cursorColor: kTitleColor,
                                            textFieldType: TextFieldType.NAME,
                                            decoration: kInputDecoration.copyWith(
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                              ),
                                              labelText: 'cash_collection'.tr,
                                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                              hintText: 'enter_amount'.tr,
                                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                            ),
                                          ),
                                    isFsUser ? SizedBox.shrink() : const SizedBox(height: 20.0),
                                    isFsUser
                                        ? SizedBox.shrink()
                                        : AppTextField(
                                            controller: parcel.sellingPriceController,
                                            cursorColor: kTitleColor,
                                            textFieldType: TextFieldType.NAME,
                                            decoration: kInputDecoration.copyWith(
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                              ),
                                              labelText: 'selling_price'.tr,
                                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                              hintText: 'selling_price_of_parcel'.tr,
                                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                            ),
                                          ),
                                    // const SizedBox(height: 20.0),
                                    // AppTextField(
                                    //   controller: parcel.invoiceController,
                                    //   cursorColor: kTitleColor,
                                    //   isValidationRequired: false,
                                    //   textFieldType: TextFieldType.NAME,
                                    //   decoration: kInputDecoration.copyWith(
                                    //     enabledBorder: const OutlineInputBorder(
                                    //       borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                    //       borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                    //     ),
                                    //     labelText: '${'invoice'.tr}#',
                                    //     labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                    //     hintText: 'enter_invoice_number'.tr,
                                    //     hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                    //   ),
                                    // ),
                                    const SizedBox(height: 20.0),
                                    parcel.deliveryChargesList.isEmpty
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 60.0,
                                            child: FormField(
                                              builder: (FormFieldState<dynamic> field) {
                                                return InputDecorator(
                                                  decoration: kInputDecoration.copyWith(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    labelText: '${'category'.tr}*',
                                                    hintText: 'select_category'.tr,
                                                    labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<DeliveryCharges>(
                                                      value: parcel.deliveryChargesIndex.toString() == 'null' ? null : parcel.deliveryChargesList[parcel.deliveryChargesIndex],
                                                      items: parcel.deliveryChargesList.map((DeliveryCharges value) {
                                                        return DropdownMenuItem<DeliveryCharges>(
                                                          value: value,
                                                          child: value.id == 0
                                                              ? Text(value.category.toString())
                                                              : value.weight == '0'
                                                                  ? Text(value.category.toString())
                                                                  : Text('${value.category} (${value.weight.toString()})'),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          parcel.deliveryChargesIndex = parcel.deliveryChargesList.indexOf(newValue!);
                                                          parcel.deliveryChargesID = newValue.id.toString();
                                                          parcel.deliveryChargesValue = newValue;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    const SizedBox(height: 20.0),
                                    AppTextField(
                                      controller: parcel.customerController,
                                      validator: (value) {
                                        if (parcel.customerController.text.isEmpty) {
                                          return "this_field_can_t_be_empty".tr;
                                        }
                                        return null;
                                      },
                                      cursorColor: kTitleColor,
                                      textFieldType: TextFieldType.NAME,
                                      decoration: kInputDecoration.copyWith(
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                          borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                        ),
                                        labelText: '${'customer_name'.tr}*',
                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                        hintText: 'customer_name'.tr,
                                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    AppTextField(
                                      controller: parcel.customerPhoneController,
                                      validator: (value) {
                                        if (parcel.customerPhoneController.text.isEmpty) {
                                          return "this_field_can_t_be_empty".tr;
                                        }
                                        return null;
                                      },
                                      cursorColor: kTitleColor,
                                      textFieldType: TextFieldType.PHONE,
                                      decoration: kInputDecoration.copyWith(
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                          borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                        ),
                                        labelText: '${'customer_phone'.tr}*',
                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                        hintText: 'customer_phone'.tr,
                                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    AppTextField(
                                      controller: parcel.customereailController,
                                      validator: (value) {
                                        if (parcel.customereailController.text.isEmpty) {
                                          return "this_field_can_t_be_empty".tr;
                                        }
                                        return null;
                                      },
                                      cursorColor: kTitleColor,
                                      textFieldType: TextFieldType.EMAIL,
                                      decoration: kInputDecoration.copyWith(
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                          borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                        ),
                                        labelText: '${'Customer Email'.tr}*',
                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                        hintText: 'Customer Email'.tr,
                                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    CustomDropdown(
                                      value: sType,
                                      items: shipmentType,
                                      onChanged: (value) {
                                        setState(() {
                                          sType = value!;
                                          int index = getShipmentTypeIndex(sType);
                                          Get.find<ParcelController>().shipmentType = index;
                                          print(index);
                                          print(" shipment${Get.find<ParcelController>().shipmentType}");
                                        });
                                      },
                                      labelText: 'Shipment type',
                                    ),
                                    const SizedBox(height: 12.0),
                                    Column(
                                      children: [
                                        Get.find<ParcelController>().shipmentType == 0
                                            ? SizedBox.shrink()
                                            : Get.find<ParcelController>().shipmentType == 2
                                                ? SizedBox.shrink()
                                                : Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text('From:'),
                                                  ),
                                        Get.find<ParcelController>().shipmentType == 1
                                            ? FromLocationSearch(
                                                controller: globalsController,
                                                parcelController: parcel,
                                              )
                                            : SizedBox.shrink(),
                                        Get.find<ParcelController>().shipmentType == 3
                                            ? FromLocationSearch(
                                                controller: globalsController,
                                                parcelController: parcel,
                                              )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                    // DropdownWithSearch(
                                    //   value: senderZoneValue,
                                    //   items: parcel.senderZonesList.map((e) => e.name!).toList(),
                                    //   onChanged: (val) {
                                    //     setState(() {
                                    //       parcel.filterSenderSubZonesList.clear();
                                    //       senderSubZoneValue = null;

                                    //       // Update senderZoneValue
                                    //       senderZoneValue = val;
                                    //       var zone = parcel.senderZonesList.firstWhere((e) => e.name! == val);
                                    //       parcel.senderZoneId.value = zone.id!;
                                    //       parcel.filterSenderSubZonesList.addAll(parcel.senderSubZonesList.where((e) => e.zoneId == zone.id).toList());
                                    //     });
                                    //   },
                                    //   labelText: "Sender zone",
                                    //   hintText: "Sender zone",
                                    // ),
                                    const SizedBox(height: 10.0),
                                    Column(
                                      children: [
                                        Get.find<ParcelController>().shipmentType == 0
                                            ? SizedBox.shrink()
                                            : Get.find<ParcelController>().shipmentType == 3
                                                ? SizedBox.shrink()
                                                : Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text('To:'),
                                                  ),
                                        Get.find<ParcelController>().shipmentType == 1
                                            ? ToLocationSearch(
                                                controller: globalsController,
                                                parcelController: parcel,
                                              )
                                            : SizedBox.shrink(),
                                        Get.find<ParcelController>().shipmentType == 2
                                            ? ToLocationSearch(
                                                controller: globalsController,
                                                parcelController: parcel,
                                              )
                                            : SizedBox.shrink(),
                                      ],
                                    ),

                                    // DropdownWithSearch(
                                    //   value: senderSubZoneValue,
                                    //   items: parcel.filterSenderSubZonesList.map((e) => e.name!).toList(),
                                    //   onChanged: (val) {
                                    //     setState(() {
                                    //       var subzone = parcel.filterSenderSubZonesList.firstWhere((e) => e.name! == val);
                                    //       senderSubZoneValue = val;
                                    //       parcel.senderSubZoneId.value = subzone.id!;
                                    //     });
                                    //   },
                                    //   labelText: "Sender Sub zone",
                                    //   hintText: "Sender Sub zone",
                                    // ),
                                    // const SizedBox(height: 20.0),
                                    // DropdownWithSearch(
                                    //   value: customerZoneValue,
                                    //   items: parcel.customerZonesList.map((e) => e.name!).toList(),
                                    //   onChanged: (val) {
                                    //     setState(() {
                                    //       parcel.filterCustomerSubZonesList.clear();
                                    //       customerSubZoneValue = null;

                                    //       // Update senderZoneValue
                                    //       customerZoneValue = val;
                                    //       var zone = parcel.customerZonesList.firstWhere((e) => e.name! == val);
                                    //       parcel.customerZoneId.value = zone.id!;
                                    //       parcel.filterCustomerSubZonesList.addAll(parcel.customerSubZonesList.where((e) => e.zoneId == zone.id).toList());
                                    //     });
                                    //   },
                                    //   labelText: "Customer zone",
                                    //   hintText: "Customer zone",
                                    // ),
                                    // const SizedBox(height: 20.0),
                                    // DropdownWithSearch(
                                    //   value: customerSubZoneValue,
                                    //   items: parcel.filterCustomerSubZonesList.map((e) => e.name!).toList(),
                                    //   onChanged: (val) {
                                    //     setState(() {
                                    //       var subzone = parcel.filterCustomerSubZonesList.firstWhere((e) => e.name! == val);
                                    //       customerSubZoneValue = val;
                                    //       parcel.customerSubZoneId.value = subzone.id!;
                                    //     });
                                    //   },
                                    //   labelText: "Customer Sub zone",
                                    //   hintText: "Customer Sub zone",
                                    // ),
                                    const SizedBox(height: 20.0),
                                    Get.find<ParcelController>().shipmentType == 3
                                        ? AppTextField(
                                            controller: parcel.streetController,
                                            validator: (value) {
                                              if (parcel.streetController.text.isEmpty) {
                                                return "this_field_can_t_be_empty".tr;
                                              }
                                              return null;
                                            },
                                            cursorColor: kTitleColor,
                                            textFieldType: TextFieldType.EMAIL,
                                            decoration: kInputDecoration.copyWith(
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                              ),
                                              labelText: '${'Street'.tr}*',
                                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                              hintText: 'Street'.tr,
                                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Get.find<ParcelController>().shipmentType == 3 ? SizedBox(height: 16.0) : SizedBox.shrink(),
                                    Get.find<ParcelController>().shipmentType == 3
                                        ? AppTextField(
                                            controller: parcel.physicalAddressController,
                                            validator: (value) {
                                              if (parcel.physicalAddressController.text.isEmpty) {
                                                return "this_field_can_t_be_empty".tr;
                                              }
                                              return null;
                                            },
                                            cursorColor: kTitleColor,
                                            textFieldType: TextFieldType.EMAIL,
                                            decoration: kInputDecoration.copyWith(
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                                              ),
                                              labelText: '${'Physical address'.tr}*',
                                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                              hintText: 'Physical address'.tr,
                                              hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Get.find<ParcelController>().shipmentType == 3 ? SizedBox(height: 16.0) : SizedBox.shrink(),
                                    Get.find<ParcelController>().shipmentType == 3
                                        ? Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: FlutterGooglePlacesWeb(apiKey: APIList.mapGoogleApiKey!, required: true, controller: parcel.customerAddressController),
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    const SizedBox(height: 2.0),
                                    TextFormField(
                                      controller: parcel.noteController,
                                      cursorColor: kTitleColor,
                                      textAlign: TextAlign.start,
                                      decoration: kInputDecoration.copyWith(
                                        labelText: 'note'.tr,
                                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      'choose_which_needed_for_parcel'.tr,
                                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                                    ),
                                    SizedBox(height: 8),
                                    // Row(
                                    //   children: [
                                    //     Checkbox(
                                    //       activeColor: kMainColor,
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(2.0),
                                    //       ),
                                    //       value: parcel.isLiquidChecked,
                                    //       onChanged: (val) {
                                    //         setState(
                                    //           () {
                                    //             parcel.isLiquidChecked = val!;
                                    //           },
                                    //         );
                                    //       },
                                    //     ),
                                    //     Text(
                                    //       'liquid_fragile'.tr,
                                    //       style: kTextStyle.copyWith(color: kTitleColor),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Checkbox(
                                    //       activeColor: kMainColor,
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(2.0),
                                    //       ),
                                    //       value: parcel.isParcelBankCheck,
                                    //       onChanged: (val) {
                                    //         setState(
                                    //           () {
                                    //             parcel.isParcelBankCheck = val!;
                                    //           },
                                    //         );
                                    //       },
                                    //     ),
                                    //     Text(
                                    //       '${'is_it_parcel_bank'.tr}?',
                                    //       style: kTextStyle.copyWith(color: kTitleColor),
                                    //     ),
                                    //   ],
                                    // ),

                                    CustomDropdown(
                                      value: packageType,
                                      items: parcel.fragileLiquids.toJson().entries.map((e) => e.key).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          var fragile = parcel.fragileLiquids.toJson().entries.toList().firstWhere((e) => e.key == val);
                                          parcel.fragileLiquidAmount = fragile.value;
                                          print(parcel.fragileLiquidAmount);
                                        });
                                      },
                                      labelText: 'Package type',
                                      hintText: 'package',
                                    ),
                                    const SizedBox(height: 20.0),
                                    parcel.packagingList.isEmpty
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 60.0,
                                            child: FormField(
                                              builder: (FormFieldState<dynamic> field) {
                                                return InputDecorator(
                                                  decoration: kInputDecoration.copyWith(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    labelText: 'packaging'.tr,
                                                    hintText: 'select_packaging'.tr,
                                                    labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<Packagings>(
                                                      value: parcel.packagingIndex.toString() == 'null' ? null : parcel.packagingList[parcel.packagingIndex],
                                                      items: parcel.packagingList.map((Packagings value) {
                                                        return DropdownMenuItem<Packagings>(
                                                          value: value,
                                                          child: value.id == 0 ? Text(value.name.toString()) : Text('${value.name} (${value.price.toString()})'),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          parcel.packagingIndex = parcel.packagingList.indexOf(newValue!);
                                                          parcel.packagingID = newValue.id.toString();
                                                          parcel.packagingPrice = newValue.price.toString();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    const SizedBox(height: 20.0),
                                    parcel.shiftsList.isEmpty
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 60.0,
                                            child: FormField(
                                              builder: (FormFieldState<dynamic> field) {
                                                return InputDecorator(
                                                  decoration: kInputDecoration.copyWith(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    labelText: 'Shifts'.tr,
                                                    hintText: 'select_shifts'.tr,
                                                    labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<Shifts>(
                                                      value: parcel.shiftIndex.toString() == 'null' ? null : parcel.shiftsList[parcel.shiftIndex],
                                                      items: parcel.shiftsList.map((Shifts value) {
                                                        return DropdownMenuItem<Shifts>(
                                                          value: value,
                                                          child: value.id == 0 ? Text(value.name.toString()) : Text("${value.name} (${value.fromTime.toString()} to  ${value.toTime.toString()})"),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          parcel.shiftIndex = parcel.shiftsList.indexOf(newValue!);
                                                          parcel.shiftID = newValue.id.toString();
                                                          print(parcel.shiftID);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    SizedBox(height: 20.0),
                                    SizedBox(
                                      height: 60.0,
                                      child: FormField(
                                        builder: (FormFieldState<dynamic> field) {
                                          return InputDecorator(
                                            decoration: kInputDecoration.copyWith(
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              labelText: '${'delivery_type'.tr}*',
                                              hintText: 'delivery_type'.tr,
                                              labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: selectType(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    CustomDropdown(
                                      value: selectedPayment,
                                      items: isFsUser ? paymentTypeUser.map((e) => e['name']).toList() : paymentType.map((e) => e['name']).toList(),
                                      onChanged: (value) {
                                        var payment = isFsUser ? paymentTypeUser.firstWhere((e) => e['name'] == value) : paymentType.firstWhere((e) => e['name'] == value);
                                        parcel.paymentMethod.value = payment['value'];
                                        print(parcel.paymentMethod.value);
                                      },
                                      labelText: "Payment Method",
                                      hintText: 'payment method',
                                    ),
                                    const SizedBox(height: 20.0),
                                    const SizedBox(height: 20.0),
                                    ButtonGlobal(
                                        buttontext: 'submit'.tr,
                                        buttonDecoration: kButtonDecoration,
                                        onPressed: () {
                                          // print(FlutterGooglePlacesWeb.value['name']);
                                          // print(FlutterGooglePlacesWeb.value['lat']);
                                          // print(FlutterGooglePlacesWeb.value['long']);
                                          setState(() {
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            if (_formKey.currentState!.validate()) {
                                              if (parcel.deliveryTypID != '' && parcel.shipmentType != 0) {
                                                parcel.calculateTotal(context);
                                              } else if (parcel.deliveryTypID == '') {
                                                Get.rawSnackbar(message: "Please select category", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
                                              } else if (parcel.deliveryTypID == '') {
                                                Get.rawSnackbar(message: "Please select delivery type", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
                                              } else if (parcel.shipmentType == 0) {
                                                Get.rawSnackbar(message: "Please select shipment type", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
                                              } else if (parcel.paymentMethod.value == 0) {
                                                Get.rawSnackbar(message: "Please select payment type", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
                                              } else {
                                                Get.rawSnackbar(message: "Please check information", backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
                                              }
                                            }
                                          });
                                        })
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  parcel.loaderParcel
                      ? Positioned(
                          child: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, color: Colors.white60, child: const Center(child: LoaderCircle())),
                        )
                      : const SizedBox.shrink(),
                ])));
  }
}
