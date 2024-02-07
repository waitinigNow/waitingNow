import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'WaitingComplete.dart';

class WaitingPeople extends StatefulWidget {
  final String _phone;

  const WaitingPeople(this._phone, {super.key});

  @override
  State<WaitingPeople> createState() => _WaitingPeopleState(this._phone);
}

class _WaitingPeopleState extends State<WaitingPeople> {
  final String _phone;
  int baby = 0;
  int adult = 0;

  _WaitingPeopleState(this._phone);

  @override
  Widget build(BuildContext context) {
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
                              SizedBox(height: 20,),
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
                                              minusBaby();
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.orange,
                                              size: 40,
                                            )),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          baby.toString(),
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              plusBaby();
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
                                              minusAdult();
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.orange,
                                              size: 40,
                                            )),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          adult.toString(),
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              plusAdult();
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
                                      child: Text("이전",style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFFC0C0C0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          )))),
                              Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => WaitingComplete(_phone, baby, adult))
                                        );
                                      },
                                      child: Text("완료" ,style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0),)
                                      )
                                  )
                              )
                            ],
                          )
                        ]),
                  )))
            ])));
  }

  // TODO 오류 창 모달 띄우기
  void minusBaby() {
    int tempBaby = baby - 1;

    if (tempBaby < 0) {
      print("[인원 입력] 인원은 0보다 작을 수 없습니다!");
      setState(() {
        baby = 0;
      });
    } else {
      setState(() {
        baby = tempBaby;
      });
    }
  }

  void plusBaby() {
    int tempBaby = baby + 1;

    if (tempBaby > 9) {
      print("[인원 입력] 인원은 최대 9명 까지 가능합니다!");
      setState(() {
        baby = 9;
      });
    } else {
      setState(() {
        baby = tempBaby;
      });
    }
  }

  void minusAdult() {
    int tempAdult = adult - 1;

    if (tempAdult < 0) {
      print("[인원 입력] 인원은 0보다 작을 수 없습니다!");
      setState(() {
        adult = 0;
      });
    } else {
      setState(() {
        adult = tempAdult;
      });
    }
  }

  void plusAdult() {
    int tempAdult = adult + 1;

    if (tempAdult > 9) {
      print("[인원 입력] 인원은 최대 9명 까지 가능합니다!");
      setState(() {
        adult = 9;
      });
    } else {
      setState(() {
        adult = tempAdult;
      });
    }
  }
}
