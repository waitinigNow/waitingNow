import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waitingnow/src/Controller/MemberContoller.dart';
import 'package:waitingnow/src/app.dart';

void main() async{
  await GetStorage.init();

  final memberController = Get.put(MemberController());
  if(!await memberController.login()){
    print("[로그인 실패]"); // TODO 추후 로그인 페이지 생성하면 dialog로 변경
  }

  runApp(MyApp());
}




