// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import '/Controllers/global-controller.dart';
import '/Screen/Authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Controllers/auth-controller.dart';
import '../../utils/image.dart';
import '../../utils/size_config.dart';
import '../Widgets/button_global.dart';
import '../Widgets/constant.dart';
import 'package:get/get.dart';

import '../Widgets/loader.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = true;
  final _formKey = GlobalKey<FormState>();
  int? hub;
  AuthController authController = AuthController();
  GlobalController globalController = Get.put(GlobalController());

  final userTypeList = ['Vendor', 'Customer'];
  String? selectUserType;
  int? userType;

  @override
  Widget build(BuildContext context) {
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (auth) => Stack(children: [
                Center(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          width: 100,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.appLogo),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'registration_form'.tr,
                        style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'please_enter_your_user_information'.tr,
                        style: kTextStyle.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20),
                                  AppTextField(
                                    showCursor: true,
                                    controller: auth.businessNameController,
                                    validator: (value) {
                                      if (auth.businessNameController.text.isEmpty) {
                                        return "this_field_can_t_be_empty".tr;
                                      }
                                      return null;
                                    },
                                    cursorColor: kTitleColor,
                                    textFieldType: TextFieldType.NAME,
                                    decoration: kInputDecoration.copyWith(
                                      labelText: 'business_name'.tr,
                                      labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                      hintText: 'x courier',
                                      hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  AppTextField(
                                    showCursor: true,
                                    controller: auth.firstNameController,
                                    validator: (value) {
                                      if (auth.firstNameController.text.isEmpty) {
                                        return "this_field_can_t_be_empty".tr;
                                      }
                                      return null;
                                    },
                                    cursorColor: kTitleColor,
                                    textFieldType: TextFieldType.NAME,
                                    decoration: kInputDecoration.copyWith(
                                      labelText: 'first_name'.tr,
                                      labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                      hintText: 'first name',
                                      hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  AppTextField(
                                    showCursor: true,
                                    controller: auth.lastNameController,
                                    validator: (value) {
                                      if (auth.lastNameController.text.isEmpty) {
                                        return "this_field_can_t_be_empty".tr;
                                      }
                                      return null;
                                    },
                                    cursorColor: kTitleColor,
                                    textFieldType: TextFieldType.NAME,
                                    decoration: kInputDecoration.copyWith(
                                      labelText: 'last_name'.tr,
                                      labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                      hintText: 'courier'.tr,
                                      hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  DropDownWidget(
                                      itemList: userTypeList.map((element) => element).toList(),
                                      selectedValue: selectUserType,
                                      initialValue: 'User Type',
                                      onChanged: (val) {
                                        setState(() {
                                          selectUserType = val;
                                          if (selectUserType == "Vendor") {
                                            userType = 1;
                                          } else {
                                            userType = 0;
                                          }
                                        });
                                      }),
                                  const SizedBox(height: 20),

                                  TextFormField(
                                    cursorColor: kTitleColor,
                                    controller: auth.addressController,
                                    validator: (value) {
                                      if (auth.addressController.text.isEmpty) {
                                        return "this_field_can_t_be_empty".tr;
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.start,
                                    decoration: kInputDecoration.copyWith(
                                      labelText: 'address'.tr,
                                      labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // globalController.hubList.isNotEmpty ?
                                  // SizedBox(
                                  //   height: 60.0,
                                  //   child: FormField(
                                  //     builder: (FormFieldState<dynamic> field) {
                                  //       return InputDecorator(
                                  //         decoration: kInputDecoration.copyWith(
                                  //           floatingLabelBehavior: FloatingLabelBehavior.always,
                                  //           labelText: 'hub'.tr,
                                  //           hintText: 'select_hub'.tr,
                                  //           labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                  //           border: OutlineInputBorder(
                                  //             borderRadius: BorderRadius.circular(5.0),
                                  //           ),
                                  //         ),
                                  //         child: DropdownButtonHideUnderline(
                                  //           child:  DropdownButton<Hubs>(
                                  //           items: globalController.dropDownItems,
                                  //             value: globalController.hubList[globalController.hubList.indexWhere((i) => i.id == hub)],
                                  //           onChanged: (value) {
                                  //             setState(() {
                                  //               hub = value!.id!;
                                  //             });
                                  //           },
                                  //         )
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ): SizedBox(height: 0,),

                                  DropDownWidget(
                                      itemList: globalController.hubList.map((element) => element.name!).toList(),
                                      selectedValue: '',
                                      initialValue: 'HUB',
                                      onChanged: (val) {
                                        var hubs = globalController.hubList.firstWhere((element) => element.name == val);
                                        setState(() {
                                          hub = hubs.id!;
                                        });
                                      }),

                                  const SizedBox(height: 20),
                                  AppTextField(
                                    showCursor: true,
                                    cursorColor: kTitleColor,
                                    controller: auth.phoneController,
                                    validator: (value) {
                                      if (auth.phoneController.text.isEmpty) {
                                        return "this_field_can_t_be_empty".tr;
                                      }
                                      return null;
                                    },
                                    textFieldType: TextFieldType.PHONE,
                                    decoration: kInputDecoration.copyWith(
                                      labelText: 'mobile'.tr,
                                      labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                      hintText: '017XXXXXXXX',
                                      hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  AppTextField(
                                    showCursor: true,
                                    cursorColor: kTitleColor,
                                    controller: auth.emailController,
                                    validator: (value) {
                                      if (auth.emailController.text.isEmpty) {
                                        return "this_field_can_t_be_empty".tr;
                                      }
                                      return null;
                                    },
                                    textFieldType: TextFieldType.OTHER,
                                    decoration: kInputDecoration.copyWith(
                                      labelText: 'email'.tr,
                                      labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                      hintText: 'fs@gmail.com',
                                      hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  AppTextField(
                                    showCursor: true,
                                    cursorColor: kTitleColor,
                                    controller: auth.passwordController,
                                    validator: (value) {
                                      if (auth.passwordController.text.isEmpty) {
                                        return "this_field_can_t_be_empty".tr;
                                      }
                                      return null;
                                    },
                                    textFieldType: TextFieldType.PASSWORD,
                                    decoration: kInputDecoration.copyWith(
                                      labelText: 'password'.tr,
                                      labelStyle: kTextStyle.copyWith(color: kTitleColor),
                                      hintText: '********',
                                      hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        activeColor: kMainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2.0),
                                        ),
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(
                                            () {
                                              isChecked = val!;
                                            },
                                          );
                                        },
                                      ),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(text: 'i_agree_to'.tr, style: kTextStyle.copyWith(color: kTitleColor), children: [
                                            TextSpan(
                                              text: 'e_courier'.tr,
                                              style: kTextStyle.copyWith(color: kGreyTextColor),
                                            ),
                                            TextSpan(
                                              text: 'privacy_Policy_&_terms'.tr,
                                              style: kTextStyle.copyWith(color: kTitleColor),
                                            )
                                          ]),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),

                                  SizedBox(
                                      height: 70,
                                      child: ButtonGlobal(
                                          buttontext: 'register_my_account'.tr,
                                          buttonDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: kMainColor),
                                          onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                              if (userType == null) {
                                                toast('please select user type ex:vedor/customer');
                                                return;
                                              }
                                              if (hub == null) {
                                                toast('please select user type ex:vedor/customer');
                                                return;
                                              }
                                              await auth.signupOnTap(hub, userType);
                                            }
                                          })),
                                  Flexible(
                                      child: RichText(
                                    text: TextSpan(
                                      text: 'already_member'.tr,
                                      style: kTextStyle.copyWith(color: kGreyTextColor),
                                      children: [
                                        TextSpan(
                                          text: 'login_here'.tr,
                                          style: kTextStyle.copyWith(color: kMainColor),
                                        ),
                                      ],
                                    ),
                                  ).onTap(
                                    () => const SignIn().launch(context),
                                  )),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                )),
                auth.loader
                    ? Positioned(
                        child: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, color: Colors.white60, child: const Center(child: LoaderCircle())),
                      )
                    : const SizedBox.shrink(),
              ])),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  DropDownWidget({
    super.key,
    required this.itemList,
    required this.selectedValue,
    required this.initialValue,
    required this.onChanged,
  });

  final List<String> itemList;
  void Function(String?)? onChanged;
  String? selectedValue;
  final String? initialValue;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black26),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: Colors.white,
        // Add more decoration..
      ),
      hint: Text(
        widget.initialValue!,
        style: const TextStyle(fontSize: 14),
      ),
      items: widget.itemList
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select value.';
        }
        return null;
      },
      onChanged: widget.onChanged,
      onSaved: (value) {
        widget.selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 28,
            )),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
