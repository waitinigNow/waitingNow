import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/Controller/DeskController.dart';

import '../../../Domain/DeskVO.dart';
import '../../../Get/DeskGet.dart';
import 'TableAssignWidgetList.dart';

class TableAndOrder extends StatefulWidget {
  const TableAndOrder({super.key});

  @override
  State<TableAndOrder> createState() => _TableAndOrderState();
}

class _TableAndOrderState extends State<TableAndOrder> {
  final deskController = Get.put(DeskController());
  final deskGet = Get.put(DeskGet());
  List<DeskVO> desks = [];

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

  @override
  void initState() {
    super.initState();
    desks = deskGet.Desks.value.cast<DeskVO>();

    // 체크된 데스크 초기화
    deskGet.checkedDesks.value = [];

    deskController.checkDesk().then((value) {
      if (value == "False") {
        show("오류", "테이블 조회 오류 발생");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 사람 수를 체크하는 모달창
    void showPeople() {
      deskGet.people.value = 0;
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
                width: 500,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "인원 수 등록",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "입장한 손님 수를 입력해주세요",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (deskGet.people.value > 0) {
                                deskGet.people.value--;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.orange,
                            size: 40,
                          ),
                        ),
                        Obx(
                          () => Text(
                            "${deskGet.people.value}",
                            style: TextStyle(fontSize: 20), // 텍스트의 글꼴 크기 지정
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (deskGet.people.value < 11) {
                                deskGet.people.value++;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.orange,
                            size: 40,
                          ),
                        ),
                      ],
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "배정할 테이블을 선택해주세요.",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(thickness: 1, height: 1, color: Color(0xFFCCCCCC)),
                    Container(
                      height: 550,
                      child: TableAssignWidgetList("TableAndOrderWidget"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity, // 버튼이 화면에 꽉 차도록 설정
          child: TextButton(
            onPressed: () async {
              showPeople();
              print('배정하기');
              // TODO 타이머 종료하기
              // TODO 내부 연결 링크 추가하기
              /*
              String value = await deskController.assignDesk();
              if (value == "preorder"){
                show("안내", "선주문 메뉴가 있습니다!");
              }
              else if (value == "True"){
                show("안내", "테이블이 배정되었습니다.");
              }
              else{
                show("오류", "테이블 배정에 문제가 생겼습니다.");
              }
              */
            },
            child: Text(
              '배정하기',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              fixedSize: Size(300, 70.0),
              padding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
