import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/hubs_model.dart';
import '../Models/profile_model.dart';
import '../Models/settings_model.dart';
import '../Screen/Authentication/sign_in.dart';
import '../services/api_list.dart';
import '/services/server.dart';
import '/services/user-service.dart';

class GlobalController extends GetxController {
  Server server = Server();

  UserService userService = UserService();

  String? bearerToken, siteName, siteEmail, currencyName;

  bool isFsUser = false;
  String? userId;
  String? userImage;
  String? userName;
  String? userEmail;

  String? get currency => currencyName;
  List<Hubs> hubList = <Hubs>[];
  List<DropdownMenuItem<Hubs>> dropDownItems = [];

  initController() async {
    final validUser = await userService.loginCheck();
    isFsUser = validUser;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    if (isFsUser) {
      final token = await userService.getToken();
      final myId = await userService.getUserId();
      bearerToken = token;
      userId = myId;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
      Server.initClass(token: bearerToken);
      getUserProfile();
    }
  }

  @override
  void onInit() {
    initController();
    siteSettings();
    getHub();
    super.onInit();
  }

  getHub() {
    server.getRequestNotToken(endPoint: APIList.hub).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var hubData = HubsModel.fromJson(jsonResponse);
        hubList = <Hubs>[];
        dropDownItems = [];
        hubList.addAll(hubData.data!.hubs!);
        hubList.forEach((element) {
          var item = DropdownMenuItem(
            value: element,
            child: Text(element.name.toString()),
          );
          dropDownItems.add(item);
        });
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  siteSettings() async {
    try {
      server.getRequestSettings(APIList.generalSettings).then((response) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          var settingData = SettingsModel.fromJson(jsonResponse);
          currencyName = settingData.data!.currency;
          siteName = settingData.data!.name;
          siteEmail = settingData.data!.email;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
        } else {
          return Container(child: Center(child: CircularProgressIndicator()));
        }
      });
    } catch (e) {}
  }

  var profileLoader = false.obs;
  getUserProfile() {
    profileLoader.value = true;
    server.getRequest(endPoint: APIList.profile).then((response) {
      try {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          var profileData = ProfileModel.fromJson(jsonResponse);
          userName = profileData.data!.user!.name;
          userEmail = profileData.data!.user!.email;
          userImage = profileData.data!.user!.image;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
        }
      } catch (e) {
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } finally {
        profileLoader.value = false;
      }
    });
  }

  userLogout({BuildContext? context}) async {
    getValue();
    await userService.removeSharedPreferenceData();
    await updateFcmUnSubscribe();
    isFsUser = false;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Get.off(() => const SignIn());
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('token');

    return stringValue;
  }

  updateFcmUnSubscribe() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var deviceToken = storage.getString('deviceToken');
    Map body = {
      "device_token": deviceToken,
      "topic": null,
    };
    String jsonBody = json.encode(body);
    server.postRequest(endPoint: APIList.fcmUnSubscribe, body: jsonBody).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('responseBody===========>');
        print(jsonResponse);
      }
    });
  }
}
