import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Controller/DeskController.dart';
import 'package:waitingnow/src/Controller/PreorderController.dart';

import '../../../Domain/DeskVO.dart';
import '../../../Domain/MenuVO.dart';
import '../../../Get/DeskGet.dart';

class TableAndOrderWidget extends StatefulWidget {
  final DeskVO deskVO;
  final int index;

  const TableAndOrderWidget(this.deskVO, this.index);

  @override
  State<TableAndOrderWidget> createState() => _TableAndOrderWidgetState();
}

class _TableAndOrderWidgetState extends State<TableAndOrderWidget> {
  final deskGet = Get.put(DeskGet());
  final deskController = Get.put(DeskController());
  final preorderController = Get.put(PreorderController());
  bool isChecked = false; // 체크 상태 변수
  bool tableAvailable = true;
  Color containerColor = Colors.white; // 배경 색 변수

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 로딩 다이얼로그는 사용자가 닫을 수 없도록 설정합니다.
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          content: Row(
            children: [
              CircularProgressIndicator(), // 로딩 표시기
              SizedBox(width: 20),
              Text("호출하는 중"), // 로딩 메시지
            ],
          ),
        );
      },
    );
  }

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
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            // 버튼이 눌렸을 때 로딩을 표시합니다.
                            showLoadingDialog(context);

                            // 배정 해제 실행
                            String value = await deskController
                                .deskOut(widget.deskVO.deskStoreNumber);

                            // 로딩 다이얼로그를 닫습니다.
                            Navigator.pop(context); // 로딩 다이얼로그 닫기

                            show("안내", value);

                            tableAvailable = true;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: const Text(
                            "확인",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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

  void showInfo() async {
    dynamic isPreorder = await preorderController.preorderList(widget.deskVO.deskStoreNumber!);
    List<MenuVO> menus = [];
    if (isPreorder.runtimeType == List<MenuVO>) {
      menus = isPreorder;
    }

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
              height: menus.length == 0 ? 180 : 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "테이블 정보",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            /// Navigator.pop에서 result값을 넣어주면
                            /// showDialog의 return 값이 됩니다.
                            Navigator.pop(context, "return value");
                          },
                          icon: Icon(Icons.cancel_outlined))
                    ],
                  ),
                  const SizedBox(height: 2),
                  Divider(thickness: 1, height: 1, color: Color(0xFFCCCCCC)),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          "${widget.deskVO.deskStoreNumber}번 테이블",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        Text(
                            "${widget.deskVO.deskAvailable == true ? '  대기중' : '  배정 완료'}"),
                      ],
                    ),
                  ),
                  Text("${isPreorder == 'No Preorder' ? '선주문 내역이 없습니다.' : ''}", style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${menus.length == 0 ? '' : '주문 내역'}", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),),
                        Column(
                          children: [
                            for (var item in menus)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 7.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("✅  ${item.menuName} X ${item.menuCount}", style: TextStyle(fontWeight: FontWeight.w600),),
                                        if (item.menuOption != null)
                                          SizedBox(height: 5,),
                                          for (var entry in item.menuOption!.entries)
                                            ...[
                                              Text("   [${entry.key}]", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
                                              for (var option in entry.value)
                                                Text("      - ${option.optionMenuName}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12 ),),
                                            ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),

                      ],
                    ),
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
    tableAvailable = widget.deskVO.deskAvailable!;
    deskGet.checkedDesks.value = [];
  }

  @override
  Widget build(BuildContext context) {
    tableAvailable = widget.deskVO.deskAvailable!;
    void toggleCheckbox(bool? value) {
      // 체크 박스 상태 변경 함수
      setState(() {
        if (!tableAvailable) {
          isChecked = false;
        } else {
          isChecked = value ?? false; // 널 처리
          if (isChecked) {
            deskGet.checkedDesks.value
                .add(widget.deskVO.deskStoreNumber); // 체크 해제 시 추가함
            containerColor = Color(0xFFFFEBCD); // 체크되었을 때 배경 색상 변경
          } else {
            deskGet.checkedDesks.value
                .remove(widget.deskVO.deskStoreNumber); // 체크 해제 시 추가함
            containerColor = Colors.white; // 체크가 해제되었을 때 배경 색상 변경
          }
        }
      });
    }

    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        height: 50,
        color: containerColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: 30),
                Checkbox(
                  activeColor: Colors.white,
                  checkColor: Color(0xFFF19530),
                  value: isChecked,
                  onChanged: toggleCheckbox,
                ),
                SizedBox(width: 30),
                Text(
                  "${widget.index + 1}번 테이블",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 20),
                Icon(Icons.person),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${widget.deskVO.deskPeople}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      showInfo();
                    },
                    icon: Icon(Icons.info_outlined)),
                SizedBox(
                  width: 20,
                ),
                FlutterSwitch(
                  width: 95,
                  height: 40,
                  disabled: tableAvailable,
                  // 배정 가능하면 disabled함
                  showOnOff: true,
                  valueFontSize: 14.0,
                  value: tableAvailable,
                  activeText: "대기중",
                  inactiveText: "배정완료",
                  activeTextFontWeight: FontWeight.bold,
                  inactiveTextFontWeight: FontWeight.bold,
                  borderRadius: 30.0,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.grey,
                  onToggle: (val) {
                    alert("배정 해제",
                        "${widget.deskVO.deskStoreNumber}번 테이블을 배정 해제 하시겠습니까?");
                  },
                ),
                SizedBox(width: 30)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
