import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Controller/TimerController.dart';
import 'package:waitingnow/src/Get/WaitingAdminGet.dart';
import 'package:waitingnow/src/Screen/Widget/Waiting/WaitingAdminWidget.dart';

class WaitingAdminWidgetList extends StatelessWidget {
  final TimerController timerController;

  WaitingAdminWidgetList(this.timerController);

  final WaitingAdminGet waitingAdminGet = Get.put(WaitingAdminGet());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<dynamic> items = waitingAdminGet.waitingVO.value;
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return WaitingAdminWidget(items[index], index + 1, timerController);
        },
      );
    });
  }

  Widget buildPage(dynamic item, int index) {
    return WaitingAdminWidget(item, index, timerController);
  }
}
