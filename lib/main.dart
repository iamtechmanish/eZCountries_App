import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Screens/SplashScreen.dart';
import 'Utils/my_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarBrightness: Brightness.dark,
    ));


    return  ScreenUtilInit(
      builder:()=>GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.splashRoute,
        routes: {
          MyRoutes.splashRoute: (context) => SplashScreen(),
        },
      ),
    );
  }
}

