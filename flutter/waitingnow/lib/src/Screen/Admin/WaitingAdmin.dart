import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Controller/WaitingController.dart';

import '../../Domain/WaitingVO.dart';

class WaitingAdmin extends StatefulWidget {
  const WaitingAdmin({super.key});

  @override
  State<WaitingAdmin> createState() => _WaitingAdminState();
}

class _WaitingAdminState extends State<WaitingAdmin>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    final waitingController = Get.put(WaitingController());

    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // TODO 1. Waiting 정보를 출력하는 Widget 작성하기
    // TODO 2. 정해진 시간마다 한번 씩 화면을 갱신하는 방법 고민하기 -> 상태관리? update?

    waitingController.waitingStatusPeopleList().then((value) {
      List<WaitingVO> waitings = value;
      print("현재 대기팀 인원 : " + waitings.length.toString());
    });

    waitingController.endStatusPeopleList().then((value) {
      List<WaitingVO> waitings = value;
      print("완료 인원 : " + waitings.length.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          TabBar.secondary(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: '대기팀 (0)'),
              Tab(text: '완료 (0)'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(12.0),
                  child: ListView(children: []),
                ),
                Card(
                  margin: const EdgeInsets.all(12.0),
                  child: Center(child: Text('ddd')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
