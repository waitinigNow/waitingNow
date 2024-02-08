import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/Controller/WaitingController.dart';
import 'package:waitingnow/src/Get/WaitingGet.dart';
import 'package:waitingnow/src/Screen/waiting/WaitingPhone.dart';

import '../Widget/DrawerWidget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  late Future<int> waitingNowPeople;

  final waitingController = Get.put(WaitingController());

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

    waitingNowPeople = waitingController.waitingNowPeople();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Color myColor = Color(0xFF747474);

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    void show(String title, String body) {
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
                width: 100,
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
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            /// Navigator.pop에서 result값을 넣어주면
                            /// showDialog의 return 값이 됩니다.
                            Navigator.pop(context, "return value");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          child: const Text(
                            "확인",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
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

    return FutureBuilder(
      future: waitingNowPeople,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data as int != -1) {
            int waitingNowPeople = snapshot.data as int;
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                toolbarHeight: 80,
                actions: [
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        size: 40,
                      )),
                  SizedBox(
                    width: 40,
                  )
                ],
              ),
              endDrawer: DrawerWidget(),
              body: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              color: myColor,
                              width: 800,
                              height: 150,
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            '현재 대기',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          waitingNowPeople.toString(),
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            '팀',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
                          TextButton(
                            onPressed: () {
                              // 버튼이 클릭될 때 실행되는 함수
                              print('웨이팅 접수를 시작합니다');
                              Get.to(WaitingPhone());
                            },
                            child: Text(
                              '웨이팅 접수',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              // 텍스트 색상
                              backgroundColor: Colors.orange,
                              // 버튼 배경색
                              fixedSize: Size(300, 150.0),
                              padding: EdgeInsets.all(16.0),
                              // 내부 여백
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(0.0), // 버튼 모양 설정
                              ),
                            ),
                          ),
                        ],
                      ))),
            );
          } else if (snapshot.hasError || snapshot.data as int == -1) {
            return Scaffold(
              body: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              color: myColor,
                              width: 800,
                              height: 150,
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '웨이팅 인원을 불러오는데 오류가 발생했습니다',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
                          TextButton(
                            onPressed: () {
                              // 버튼이 클릭될 때 실행되는 함수
                              print('[홈] 화면 새로 고침');
                              Get.offAll(() => Home());
                            },
                            child: Text(
                              '새로 고침',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              // 텍스트 색상
                              backgroundColor: Colors.orange,
                              // 버튼 배경색
                              fixedSize: Size(300, 150.0),
                              padding: EdgeInsets.all(16.0),
                              // 내부 여백
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(0.0), // 버튼 모양 설정
                              ),
                            ),
                          ),
                        ],
                      ))),
            );
          }
        }

        return Column(children: [
          const SizedBox(height: 50),
          Container(width: 50, height: 50, child: CircularProgressIndicator())
        ]);
      },
    );
  }
}
