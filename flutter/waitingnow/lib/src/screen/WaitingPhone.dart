import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingPhone extends StatefulWidget {
  const WaitingPhone({super.key});

  @override
  State<WaitingPhone> createState() => _WaitingPhoneState();
}

class _WaitingPhoneState extends State<WaitingPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                        color: Colors.deepPurple
                    )
                ),
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
                                      print('1');
                                    },
                                    child: Text(
                                      '1',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
                                      bottom: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('2');
                                    },
                                    child: Text(
                                      '2',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
                                      bottom: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('3');
                                    },
                                    child: Text(
                                      '3',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
                                      right: BorderSide(color: Colors.black, width: 1.0),
                                      bottom: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('4');
                                    },
                                    child: Text(
                                      '4',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('5');
                                    },
                                    child: Text(
                                      '5',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('6');
                                    },
                                    child: Text(
                                      '6',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
                                      right: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('7');
                                    },
                                    child: Text(
                                      '4',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('8');
                                    },
                                    child: Text(
                                      '5',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('9');
                                    },
                                    child: Text(
                                      '9',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
                                      right: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('지움');
                                    },
                                    child: Text(
                                      '지움',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('0');
                                    },
                                    child: Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
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
                                      print('입력');
                                    },
                                    child: Text(
                                      '입력',
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0), // 직사각형 형태로 설정
                                      ),
                                      fixedSize: Size.fromHeight(1000.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    border: Border(
                                      top: BorderSide(color: Colors.black, width: 1.0),
                                      left: BorderSide(color: Colors.black, width: 1.0),
                                      right: BorderSide(color: Colors.black, width: 1.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}