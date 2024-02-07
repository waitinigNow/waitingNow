import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/screen/waiting/WaitingPeople.dart';

class WaitingPhone extends StatefulWidget {
  const WaitingPhone({super.key});

  @override
  State<WaitingPhone> createState() => _WaitingPhoneState();
}

class _WaitingPhoneState extends State<WaitingPhone> {
  var _phone = '010 - ';

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
                          Navigator.pop(context, "return value");
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
                            Text(
                              _phone,
                              style: TextStyle(fontSize: 35),
                            )
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
                                        addPhoneNumber("1");
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
                                        addPhoneNumber("2");
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
                                        addPhoneNumber("3");
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
                                        addPhoneNumber("4");
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
                                        addPhoneNumber("5");
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
                                        addPhoneNumber("6");
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
                                        addPhoneNumber("7");
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
                                        addPhoneNumber("8");
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
                                        addPhoneNumber("9");
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
                                        removePhoneNumber();
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
                                        addPhoneNumber("0");
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
                                        if(_phone.length == 17){
                                          print("[전화번호 입력 완료] 입장 인원 추가로 이동");
                                          Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => WaitingPeople(_phone))
                                          );

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

  /*
    전화번호 입력하는 함수
   */
  void addPhoneNumber(var number) {
    var changedPhone = this._phone + number;

    if(changedPhone.length == 10){
      changedPhone += " - ";
    }
    else if(changedPhone.length == 18){
      show("오류","전화번호는 최대 11까지 입력 가능합니다.");
      print("[전화번호 입력] 이미 모두 입력했습니다");
      changedPhone = changedPhone.substring(0,17);
    }

    setState(() {
      _phone = changedPhone;
      print("[번호] " + _phone);
    });
  }

  /*
    전화번호 지우는 함수
   */
  void removePhoneNumber() {
    var changedPhone = this._phone.substring(0, this._phone.length - 1);
    if(changedPhone.length == 12){
      changedPhone = changedPhone.substring(0, 9);
    }
    else if(changedPhone.length == 5){
      show("오류","전화번호를 더 이상 지울 수 없습니다.");
      print("[전화번호 입력] 더 지울 수 없습니다. ");
      changedPhone += " ";
    }
    setState(() {
      _phone = changedPhone;
      print("[번호] " + _phone);
    });
  }
}
