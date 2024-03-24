import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Screen/Admin/Admin.dart';
import 'package:waitingnow/src/Controller/TimerController.dart';

import '../../Controller/WaitingController.dart';
import '../../Domain/WaitingVO.dart';

class WaitingAdminWidget extends StatefulWidget {
  final WaitingVO waitingVO;
  final int index;
  final TimerController timerController;
  const WaitingAdminWidget(this.waitingVO, this.index, this.timerController);

  @override
  State<WaitingAdminWidget> createState() => _WaitingAdminWidgetState();
}

class _WaitingAdminWidgetState extends State<WaitingAdminWidget> {
  bool isButtonEnabled = true; // 버튼이 눌렸는지 판단하는 변수

  @override
  void initState() {
    super.initState();
    if(widget.timerController.remainingTime(widget.waitingVO.waitingNumber ?? 0) != "10 : 00"){
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final waitingController = Get.put(WaitingController());
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

    void alert(String title, String body) {
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
                      style: TextStyle(fontSize: 15),
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
                              onPressed: () async {
                                if(await waitingController.waitingCall(widget.waitingVO.waitingCustomerNumber)){
                                  show("호출 완료", "정상 호출 되었습니다.");
                                  widget.timerController.startTimer(widget.waitingVO.waitingNumber ?? 0);
                                  setState(() {
                                    isButtonEnabled = false; // 버튼 비활성화
                                  });
                                }else{
                                  show("호출 실패", "호출에 실패하였습니다");
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

    return Padding(
      padding: EdgeInsets.all(30),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded( // Expanded 수정
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "${widget.index}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    width: 75,
                  ),
                  Column(
                    children: [
                      SizedBox(height: 4,),
                      Text("${widget.waitingVO.waitingPhone?.substring(0,3)} - ${widget.waitingVO.waitingPhone?.substring(3,7)} - ${widget.waitingVO.waitingPhone?.substring(7,11)}",style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                          ),
                          Text(
                            " ${widget.waitingVO.waitingPeople}",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                          ),
                          SizedBox(width: 14),
                          Icon(Icons.timer, size: 14),
                          Text("${widget.waitingVO.waitingDate?.substring(11)}")
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded( // Expanded 수정
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 버튼을 행의 오른쪽에 정렬
                children: [
                  ElevatedButton.icon(
                    onPressed: isButtonEnabled ? () {
                      alert("호출하기", "${widget.waitingVO.waitingPhone?.substring(0,3)} - ${widget.waitingVO.waitingPhone?.substring(3,7)} - ${widget.waitingVO.waitingPhone?.substring(7,11)}님을 호출하시겠습니까?");
                    } : null,
                    icon: Icon(Icons.notifications_outlined),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFEEDA),
                      foregroundColor: Colors.deepOrange,
                      minimumSize: Size(75, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(8), // 원하는 사각 버튼 모양을 정의할 수 있음
                      ),
                    ),
                    label: Column(
                        children: [
                          SizedBox(height: 5,),
                          Text("호출"),
                          Obx(() {
                            return Text(widget.timerController.remainingTime(widget.waitingVO.waitingNumber ?? 0));
                          }),
                        ]
                    ),
                  ),
                  SizedBox(width: 25,),
                  ElevatedButton.icon(
                      onPressed: () {
                        Get.offAll(Admin(), arguments: 1);
                      },
                      icon: Icon(Icons.check),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD2FFC7),
                        foregroundColor: Color(0xFF027C00),
                        minimumSize: Size(85, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 원하는 사각 버튼 모양을 정의할 수 있음
                        ),
                      ),
                      label: Text("입장")),
                  SizedBox(width: 25,),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.cancel_outlined),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFDADA),
                        foregroundColor: Color(0xFFFF2222),
                        minimumSize: Size(85, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(8), // 원하는 사각 버튼 모양을 정의할 수 있음
                        ),
                      ),
                      label: Text("미입장")),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

