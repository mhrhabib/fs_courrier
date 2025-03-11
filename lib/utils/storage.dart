import 'package:get_storage/get_storage.dart';

final storage = GetStorage();

bool isFsUser = true;

class LocalSettings {
  Future initialize() async {
    if (await storage.read('userType') == 'customer') {
      isFsUser = true;
    } else {
      print("else >>>>>>>>>>>>>>>>>>>>>>>>>");
      isFsUser = false;
    }
  }
}
