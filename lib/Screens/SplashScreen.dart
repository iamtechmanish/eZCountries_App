import 'dart:async';

import 'package:ezcountries_app/Screens/MainActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Utils/Config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.to(MainActivity());
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset(appIcon, width: 0.6.sw),
            SizedBox(height: 20.h),
            Text(Common.APP_NAME,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Spacer(),
            SpinKitThreeBounce(size: 30.r,color: appColor),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
