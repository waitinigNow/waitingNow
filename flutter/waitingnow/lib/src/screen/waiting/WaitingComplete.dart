import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/get/WaitingGet.dart';

import '../preorder/Preorder.dart';
import 'home.dart';

class WaitingComplete extends StatefulWidget {
  const WaitingComplete({super.key});

  @override
  State<WaitingComplete> createState() => _WaitingCompleteState();
}

class _WaitingCompleteState extends State<WaitingComplete> {
  final waitingGet = Get.put(WaitingGet());

  @override
  void initState() {
    super.initState();
    waitingGet.Time();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(100),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text("접수가 완료되었습니다.",
                        style: GoogleFonts.inter(
                          color: Color(0xFF656565),
                          fontSize: 24.0,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Text("카카오톡 알림톡으로 실시간 현황을 알려드려요.",
                        style: GoogleFonts.inter(
                          color: Color(0xFF656565),
                          fontSize: 24.0,
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    Text("대기 번호",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30.0,
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    Text("20",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 120.0,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              print("[웨이팅 완료 페이지] 웨이팅 완료 페이지로 이동합니다.");
                              waitingGet.TimeStop();
                              Get.offAll(Preorder());
                            },
                            child: Text(
                              "메뉴 선주문 하기",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                )))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              waitingGet.TimeStop();
                              Get.offAll(Home());
                            },
                            child: Obx(() => Text(
                                  "처음으로 (${waitingGet.time.value} 초)",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xFFC0C0C0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                )
                            )
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
