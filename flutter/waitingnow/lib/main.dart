import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waitingnow/src/Controller/MemberContoller.dart';
import 'package:waitingnow/src/app.dart';

void main() async{
  await GetStorage.init();

  final memberController = Get.put(MemberController());
  await memberController.login();

  runApp(MyApp());
}




