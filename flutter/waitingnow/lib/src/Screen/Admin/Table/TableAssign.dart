import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitingnow/src/Controller/DeskController.dart';
import 'package:waitingnow/src/Get/DeskGet.dart';
import 'package:waitingnow/src/Screen/Admin/Table/TableAssignWidgetList.dart';

import '../../../Domain/DeskVO.dart';

class TableAssign extends StatefulWidget {
  const TableAssign({super.key});

  @override
  State<TableAssign> createState() => _TableAssignState();
}

class _TableAssignState extends State<TableAssign> {
  final deskController = Get.put(DeskController());
  final deskGet = Get.put(DeskGet());
  List<DeskVO> desks = [];

  @override
  void initState() {
    super.initState();
    desks = deskGet.Desks.value as List<DeskVO>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "테이블 배정",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      body: Column(
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
                        "배정하실 테이블을 선택해주세요.",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20,),
                      Divider(thickness: 1, height: 1, color: Color(0xFFCCCCCC)),
                      Container(
                        height: 560,
                        child: TableAssignWidgetList(),
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
              onPressed: () {
                // 버튼이 클릭될 때 실행되는 함수
                print('배정하기');
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
      ),
    );
  }
}
