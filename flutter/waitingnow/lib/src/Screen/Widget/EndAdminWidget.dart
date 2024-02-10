import 'package:flutter/material.dart';

import '../../Domain/WaitingVO.dart';

class EndAdminWidget extends StatelessWidget {
  final WaitingVO waitingVO;
  final int index;
  const EndAdminWidget(this.waitingVO, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
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
            Expanded( // Expanded 추가
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "$index",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    width: 75,
                  ),
                  Column(
                    children: [
                      SizedBox(height: 4,),
                      Text("${waitingVO.waitingPhone?.substring(0,3)} - ${waitingVO.waitingPhone?.substring(3,7)} - ${waitingVO.waitingPhone?.substring(7,11)}",style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                          ),
                          Text(
                            " ${waitingVO.waitingPeople}",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                          ),
                          SizedBox(width: 14),
                          Icon(Icons.timer, size: 14),
                          Text("${waitingVO.waitingDate?.substring(11)}")
                        ],
                      )
                    ],
                  ),
                  Expanded( // Expanded 추가
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end, // 버튼을 행의 오른쪽에 정렬
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
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
                                Text("10:00:00"),
                              ]
                          ),
                        ),
                        SizedBox(width: 25,),
                        ElevatedButton.icon(
                            onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
