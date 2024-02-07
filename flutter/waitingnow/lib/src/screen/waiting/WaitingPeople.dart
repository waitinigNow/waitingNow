import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/get/WaitingGet.dart';

import 'WaitingComplete.dart';

class WaitingPeople extends StatefulWidget {
  const WaitingPeople({super.key});

  @override
  State<WaitingPeople> createState() => _WaitingPeopleState();
}

class _WaitingPeopleState extends State<WaitingPeople> {
  @override
  Widget build(BuildContext context) {
    final waitingGet = Get.put(WaitingGet());

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

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                      child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "입장 인원",
                                style: GoogleFonts.inter(
                                  color: Color(0xFF656565),
                                  fontSize: 29.0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "입장 인원을 입력해주세요",
                                style: GoogleFonts.inter(
                                  color: Color(0xFF656565),
                                  fontSize: 15.0,
                                ),
                              ),
                              SizedBox(
                                height: 45,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "아동 (8세 이하)",
                                    style: GoogleFonts.inter(
                                      fontSize: 31.0,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (!waitingGet.minusBaby()) {
                                                show(
                                                    "오류", "인원은 0보다 작을 수 없습니다!");
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.orange,
                                              size: 40,
                                            )),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Obx(
                                          () => Text(
                                            waitingGet.baby.value.toString(),
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (!waitingGet.plusBaby()) {
                                                show("오류",
                                                    "인원은 최대 9명 까지 가능합니다!");
                                              }
                                            },
                                            icon: Icon(Icons.add_circle,
                                                color: Colors.orange,
                                                size: 40)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "성인",
                                    style: GoogleFonts.inter(
                                      fontSize: 31.0,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (!waitingGet.minusAdult()) {
                                                show(
                                                    "오류", "인원은 0보다 작을 수 없습니다!");
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.orange,
                                              size: 40,
                                            )),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Obx(
                                          () => Text(
                                            waitingGet.adult.value.toString(),
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if(!waitingGet.plusAdult()){
                                                show("오류", "인원은 최대 9명 까지 가능합니다!");
                                              }
                                            },
                                            icon: Icon(Icons.add_circle,
                                                color: Colors.orange,
                                                size: 40)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "이전",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFFC0C0C0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          )))),
                              Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        print(
                                            "[웨이팅 완료 페이지] 웨이팅 완료 페이지로 이동합니다.");
                                        Get.to(WaitingComplete());
                                      },
                                      child: Text(
                                        "완료",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ))))
                            ],
                          )
                        ]),
                  )))
            ])));
  }
}
