import 'dart:convert';
import '/Models/parcel_status_model.dart';
import '../services/api_list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class ParcelAllStatusController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  bool loader = true;
  List<ParcelStatusModel> parcelAllStatus = <ParcelStatusModel>[];

  @override
  void onInit() {
    getAllPercelStatus();
    super.onInit();
  }

  getAllPercelStatus() {
    server.getRequest(endPoint: APIList.parcelAllStatus).then((response) {
      if (response != null && response.statusCode == 200) {
        loader = false;
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        for (int i = 0; i < jsonResponse.length; i++) {
          parcelAllStatus.add(ParcelStatusModel.fromJson(jsonResponse[i]));
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
}
