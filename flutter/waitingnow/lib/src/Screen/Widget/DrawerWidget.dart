import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/Screen/Admin/Admin.dart';

import '../../Domain/UserVO.dart';
import '../waiting/Home.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Drawer build(BuildContext context) {
    final GetStorage _storage = GetStorage();

    Map<String, dynamic> map = _storage.read("user");
    UserVO user = UserVO.fromJson(map);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Stack(children: [
              Positioned(
                bottom: 8.0,
                left: 4.0,
                child: Text(
                  "🏪 ${user.memberStoreName}",
                  style: GoogleFonts.nanumGothic(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ]),
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
          ),
          ListTile(
              leading: Icon(Icons.people),
              title: Text(
                "웨이팅",
                style: GoogleFonts.nanumGothic(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
              onTap: () {
                Get.back();
                Get.offAll(() => Home());
              }),
          SizedBox(
            height: 10,
          ),
          Divider(thickness: 1, height: 1, color: Colors.grey),
          SizedBox(
            height: 10,
          ),
          ListTile(
              leading: Icon(Icons.table_bar),
              title: Text(
                "테이블 & 주문",
                style: GoogleFonts.nanumGothic(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
              onTap: () {
                Get.back();
                Get.offAll(() => Admin());
              }),
          SizedBox(
            height: 10,
          ),
          Divider(thickness: 1, height: 1, color: Colors.grey),
          SizedBox(
            height: 10,
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "설정",
                style: GoogleFonts.nanumGothic(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
              onTap: () {
                Get.back();
                // TODO 이동할 페이지 등록하기
                // Get.offAll(() => );
              }),
          SizedBox(
            height: 10,
          ),
          Divider(thickness: 1, height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
