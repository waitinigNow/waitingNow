import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Controller/DeskController.dart';

import '../../../Domain/DeskVO.dart';
import '../../../Get/DeskGet.dart';

class TableAssignWidget extends StatefulWidget {
  final DeskVO deskVO;
  final int index;

  const TableAssignWidget(this.deskVO, this.index);

  @override
  State<TableAssignWidget> createState() => _TableAssignWidgetState();
}

class _TableAssignWidgetState extends State<TableAssignWidget> {
  final deskGet = Get.put(DeskGet());
  bool isChecked = false; // 체크 상태 변수
  bool tableAvailable = true;
  Color containerColor = Colors.white; // 배경 색 변수

  @override
  void initState() {
    super.initState();
    tableAvailable = widget.deskVO.deskAvailable!;
  }

  @override
  Widget build(BuildContext context) {
    void toggleCheckbox(bool? value) {
      // 체크 박스 상태 변경 함수
      setState(() {
        if (!tableAvailable){
          isChecked = false;
        }
        else{
          isChecked = value ?? false; // 널 처리
          if (isChecked) {
            deskGet.checkedDesks.value.add(widget.deskVO.deskStoreNumber);
            containerColor = Color(0xFFFFEBCD); // 체크되었을 때 배경 색상 변경
          } else {
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
        color: containerColor, // 배경 색상 적용
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
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
                  SizedBox(width: 5,),
                  Text("${widget.deskVO.deskPeople}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.orange),)
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlutterSwitch(
                    width: 95,
                    height: 40,
                    disabled: true,
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
                      setState(() {
                        isChecked = val;
                      });
                    },
                  ),
                  SizedBox(width: 30)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
