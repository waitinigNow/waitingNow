import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/get/WaitingGet.dart';
import 'package:waitingnow/src/screen/waiting/WaitingPhone.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 전화번호, 인원 초기화
      final waitingGet = Get.put(WaitingGet());
      waitingGet.phone.value = "010 - ";
      waitingGet.baby.value = 0;
      waitingGet.adult.value = 0;
      waitingGet.time.value = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Color myColor = Color(0xFF747474);
    return Scaffold(
      body: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      color: myColor, width: 800, height: 150,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('현재 대기', style: GoogleFonts.roboto(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,),),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('5', style: GoogleFonts.roboto(color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold,),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('팀', style: GoogleFonts.roboto(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,),),
                                ),
                              ),
                            ],
                          )

                      )
                  ),
                  TextButton(
                    onPressed: () {
                      // 버튼이 클릭될 때 실행되는 함수
                      print('웨이팅 접수를 시작합니다');
                      Get.to(WaitingPhone());
                    },
                    child: Text('웨이팅 접수', style: GoogleFonts.roboto(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold,),),
                    style: TextButton.styleFrom(
                      primary: Colors.white, // 텍스트 색상
                      backgroundColor: Colors.orange, // 버튼 배경색
                      fixedSize: Size(300, 150.0),
                      padding: EdgeInsets.all(16.0), // 내부 여백
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0), // 버튼 모양 설정
                      ),
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}