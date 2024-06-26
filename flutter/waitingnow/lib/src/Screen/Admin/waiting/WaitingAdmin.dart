import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Controller/TimerController.dart';
import 'package:waitingnow/src/Controller/WaitingController.dart';
import 'package:waitingnow/src/Screen/Admin/waiting/EndAdminWidgetList.dart';

import '../../../Get/WaitingAdminGet.dart';
import 'WaitingAdminWidgetList.dart';

class WaitingAdmin extends StatefulWidget {
  final TimerController timerController;
  const WaitingAdmin(this.timerController);

  @override
  State<WaitingAdmin> createState() => _WaitingAdminState();
}

class _WaitingAdminState extends State<WaitingAdmin>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final waitingAdminGet = Get.put(WaitingAdminGet());

  @override
  void initState() {
    final waitingController = Get.put(WaitingController());

    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // TODO 2. 정해진 시간마다 한번 씩 화면을 갱신하는 방법 고민하기 -> 상태관리? update?

    waitingController.waitingStatusPeopleList().then((value) {
      waitingAdminGet.waitingVO.value = value;
      print("현재 대기팀 인원 : " + value.length.toString());
    });

    waitingController.endStatusPeopleList().then((value) {
      waitingAdminGet.endVO.value = value;
      print("완료 인원 : " + value.length.toString());
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
            tabs: <Widget>[
              Obx(() =>
                  Tab(text: '대기팀 (${waitingAdminGet.waitingVO.value.length})')),
              Obx(() =>
                  Tab(text: '완료 (${waitingAdminGet.endVO.value.length})')),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Card(
                    margin: const EdgeInsets.all(12.0),
                    child: WaitingAdminWidgetList(widget.timerController)),
                Card(
                    margin: const EdgeInsets.all(12.0),
                    child: EndAdminWidgetList(widget.timerController)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
