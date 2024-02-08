
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/Get/WaitingGet.dart';
import 'package:waitingnow/src/Screen/waiting/WaitingPeople.dart';

class WaitingPhone extends StatefulWidget {
  const WaitingPhone({super.key});

  @override
  State<WaitingPhone> createState() => _WaitingPhoneState();
}

class _WaitingPhoneState extends State<WaitingPhone> {

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
          // surfaceTintColor: Colors.green,


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
                    body, style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          /// Navigator.pop에서 result값을 넣어주면
                          /// showDialog의 return 값이 됩니다.
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                        child: const Text("확인",style: TextStyle(color: Colors.white),)),
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
  Widget build(BuildContext context) {
    final waitingGet = Get.put(WaitingGet());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(width: 30,),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("휴대폰 번호를 입력하시면 카카오톡으로 웨이팅 정보가 전송됩니다.",
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(
                              height: 20,
                            ),
                            Obx(() => Text(
                              '${waitingGet.phone.value}',
                              style: TextStyle(fontSize: 35),
                            ))
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("1")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '1',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("2")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '2',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("3")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '3',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        right: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("4")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '4',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("5")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '5',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("6")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '6',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        right: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("7")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '7',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("8")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '8',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("9")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '9',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        right: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.removePhoneNumber()){
                                          show("오류","전화번호를 더 이상 지울 수 없습니다.");
                                        }
                                      },
                                      child: Icon(
                                        Icons.backspace,
                                        color: Color(0xFF656565),
                                        size: 40,
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(!waitingGet.addPhoneNumber("0")){
                                          show("오류","전화번호는 최대 11까지 입력 가능합니다.");
                                        }
                                      },
                                      child: Text(
                                        '0',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF656565),
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        left: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        right: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        // 버튼이 클릭될 때 실행되는 함수
                                        if(waitingGet.phone.value.length == 17){
                                          print("[전화번호 입력 완료] 입장 인원 추가로 이동");
                                          Get.to(() => WaitingPeople());
                                        }else{
                                          show("오류", "전화번호 11자리를 모두 입력해주세요");
                                          print("[전화번호 입력 미완] 전화번호를 추가로 입력해주세요!");
                                        }
                                      },
                                      child: Text(
                                        '입력',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 40.0,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0), // 직사각형 형태로 설정
                                        ),
                                        fixedSize: Size.fromHeight(1000.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
