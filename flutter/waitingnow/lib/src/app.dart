import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/screen/waiting/Home.dart';

// stle 자동완성
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home(),
    );
  }
}