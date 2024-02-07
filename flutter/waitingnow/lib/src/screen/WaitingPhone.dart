import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/screen/WaitingPeople.dart';

// TODO 각종 오류 출력 안내

class WaitingPhone extends StatefulWidget {
  const WaitingPhone({super.key});

  @override
  State<WaitingPhone> createState() => _WaitingPhoneState();
}

class _WaitingPhoneState extends State<WaitingPhone> {
  var _phone = '010 - ';

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
                                          // TODO 전화번호 추가로 입력 안내
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
      /* TODO [더 입력할 수 없습니다.] 경고문자 출력하기 */
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
      /* TODO [더 지울 수 없습니다.] 경고문자 출력하기 */
      print("[전화번호 입력] 더 지울 수 없습니다. ");
      changedPhone += " ";
    }
    setState(() {
      _phone = changedPhone;
      print("[번호] " + _phone);
    });
  }
}
