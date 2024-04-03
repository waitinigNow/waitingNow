import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/screen/waiting/Home.dart';

import 'Screen/Admin/Admin.dart';

// stle 자동완성
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/admin', page: () => Admin()), // /admin 경로 추가
      ],
    );
  }
}