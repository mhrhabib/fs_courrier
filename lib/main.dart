import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fs_currier/utils/storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Controllers/global-controller.dart';
import 'Locale/language.dart';
import 'Screen/SplashScreen/splash_screen.dart';
import 'Screen/Widgets/constant.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  final box = GetStorage();
  WidgetsFlutterBinding.ensureInitialized();
  // const firebaseOptions = FirebaseOptions(
  //   appId: '1:151878495365:android:2510842ed9330bba260dec',
  //   apiKey: 'AIzaSyDCthiio0WgX1F2CiVlw1Z-kWOKYYi6vQI',
  //   projectId: 'we-courier-81101',
  //   messagingSenderId: '151878495365',
  //   authDomain: 'we-courier-81101.firebaseapp.com',
  // );
  // await Firebase.initializeApp(name: 'courier', options: firebaseOptions);
  await GetStorage.init();
  dynamic langValue = const Locale('en', 'US');
  if (box.read('lang') != null) {
    langValue = Locale(box.read('lang'), box.read('langKey'));
  } else {
    langValue = const Locale('en', 'US');
  }
  await LocalSettings().initialize();
  print("user >>>>>>$isFsUser");
  // es_SV
  runApp(MyApp(
    lang: langValue,
  ));
}

class MyApp extends StatelessWidget {
  final Locale lang;
  const MyApp({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: kMainColor));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.put(GlobalController()).onInit();

    return ScreenUtilInit(
        designSize: Size(360, 800),
        builder: ((context, child) => GetMaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              translations: Languages(),
              locale: lang,
              title: 'Merchant',
              theme: ThemeData(fontFamily: 'Display'),
              home: const SplashScreen(),
            )));
  }
}
