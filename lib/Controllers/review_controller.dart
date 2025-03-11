import 'dart:convert';
import 'package:get/get.dart';
import '../services/api_list.dart';
import '../services/server.dart';
import 'parcel_controller.dart';

class ReviewController extends GetxController {
  Server server = Server();

  giveReview({int? parcel_id, int? star}) async {
    var data = {
      'parcel_id': parcel_id,
      'star': star,
    };
    var jsonData = jsonEncode(data);
    var response = await server.postRequestWithToken(endPoint: APIList.review, body: jsonData);
    if (response.statusCode == 200) {
      print("success${response.body}");
      print("success${response.statusCode}");
      await Get.find<ParcelController>().getParcel();
      Get.rawSnackbar(message: "Success");
    } else {
      print('Failed');
    }
  }
}
