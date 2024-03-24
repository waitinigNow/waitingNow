import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/Screen/Admin/Admin.dart';

import '../../Domain/UserVO.dart';
import '../waiting/Home.dart';

class DrawerWidget extends StatelessWidget {
  final String thisPage;
  const DrawerWidget(this.thisPage);

  @override
  Drawer build(BuildContext context) {
    final GetStorage _storage = GetStorage();

    Map<String, dynamic> map = _storage.read("user");
    UserVO user = UserVO.fromJson(map);

    void alert(String title, String body, String goto) {
      showDialog<String>(
        context: context,

        /// 다이얼로그 배경 컬러
        // barrierColor: Colors.cyan.withOpacity(0.4),

        /// 다이얼로그 배경을 터치했을 때 다이얼로그를 닫을지 말지 결정
        /// true = 닫을 수 있음, false = 닫을 수 없음
        barrierDismissible: true,

        builder: (context) {
          return Dialog(

            /// 배경 컬러
            backgroundColor: Colors.white,

            /// 그림자 컬러
            shadowColor: Colors.blue,

            /// 다이얼로그의 모양 설정
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            /// z축 높이, elevation의 값이 높을 수록 그림자가 아래 위치하게 됩니다.
            elevation: 10,

            /// 다이얼로그의 위치 설정, 기본값은 center
            alignment: Alignment.center,

            /// Dialog의 padding 값입니다..
            /// sizedBox의 가로세로 값읠 infinity로 설정해놓고
            /// 가로패딩 50, 세로 패딩 200을 줬습니다.
            /// 이렇게 하면 좌우 50, 위아래 200만큼의 패딩이 생기고 배경이 나오게 됩니다.
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 100,
            ),

            /// Material 3 에서만 사용됨

            child: SizedBox(
                width: 350,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      body,
                      style: TextStyle(fontSize: 15, ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                /// Navigator.pop에서 result값을 넣어주면
                                /// showDialog의 return 값이 됩니다.
                                Navigator.pop(context, "return value");
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey),
                              child: const Text(
                                "취소",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(width: 20,),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                if(goto == "Home"){
                                  Get.back();
                                  Get.offAll(() => Home());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange),
                              child: const Text(
                                "확인",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    )
                  ],
                )),
          );
        },
      ).then((value) {
        /// Navigator.pop 의 return 값이 들어옵니다.
      }).whenComplete(() {
        /// 다이얼로그가 종료됐을 때 호출됩니다.
      });
    }

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
                if(thisPage == "Admin"){
                  alert("오류", "지금 이동하시면 호출한 이력이 초기화 됩니다!\n 그래도 진행하시겠습니까?", "Home");
                }
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
