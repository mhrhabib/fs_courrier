import 'dart:convert';
import '../Models/dashboard_model.dart';
import '../Models/news_offers_model.dart';
import '../services/base_client.dart';
import '../services/api_list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class DashboardController extends GetxController {
  UserService userService = UserService();
  Server server = Server();

  String? userID;

  var dashboardLoader = false.obs;
  bool commonLoader = false;
  bool loader = false;
  var dashboardData = DataDashboard().obs;
  List<NewsOffers> offersList = <NewsOffers>[];

  @override
  void onInit() {
    getDashboard();
    getOfferList();
    super.onInit();
  }

  getDashboard() async {
    dashboardLoader.value = true;
    dio.Response response = await BaseClient.get(url: APIList.dashboard!);
    print(response.statusCode);
    if (response.statusCode == 200) {
      dashboardLoader.value = false;

      var dashboard = DashboardModel.fromJson(response.data);
      dashboardData.value = dashboard.data!;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
    } else {
      dashboardLoader.value = false;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
    }
  }

  getOfferList() {
    dashboardLoader.value = true;
    offersList = <NewsOffers>[];
    server.getRequest(endPoint: APIList.offerList).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var offers = NewsOffersModel.fromJson(jsonResponse);
        offersList = offers.data!.newsOffers!;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        dashboardLoader.value = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }
}
