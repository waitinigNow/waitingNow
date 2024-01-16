import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(MyApp());
}

// stle 자동완성
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

// 자동완성 stful
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WaitingPhone()),
                    );
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
