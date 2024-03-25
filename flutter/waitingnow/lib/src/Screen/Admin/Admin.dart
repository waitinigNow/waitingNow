import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Controller/DeskController.dart';
import 'package:waitingnow/src/Get/DeskGet.dart';
import 'package:waitingnow/src/Screen/Admin/Table/TableAndOrder.dart';
import 'package:waitingnow/src/Screen/Admin/waiting/WaitingAdmin.dart';
import 'package:waitingnow/src/Screen/Widget/DrawerWidget.dart';

import '../../Controller/TimerController.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TimerController timerController = Get.put(TimerController());
  final DeskController deskController = Get.put(DeskController());
  final deskGet = Get.put(DeskGet());
  int initialTabIndex = Get.arguments ?? 0;

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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: initialTabIndex);

  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return DefaultTabController(
      initialIndex: 2,
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 80,
          actions: [
            IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                  print(_scaffoldKey.currentState);
                },
                icon: Icon(
                  Icons.menu,
                  size: 40,
                )),
            SizedBox(
              width: 40,
            )
          ],
          title: TabBar(
            controller: tabController,
            labelStyle: TextStyle(fontSize: 20),
            tabs: <Widget>[
              Tab(
                text: '웨이팅',
              ),
              Tab(
                text: '테이블 & 주문',
              ),
              Tab(
                text: '더보기',
              ),
            ],
          ),
        ),
        endDrawer: DrawerWidget("Admin"),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            WaitingAdmin(timerController),
            TableAndOrder(),
            Scaffold(),
          ],
        ),
      ),
    );
  }
}
