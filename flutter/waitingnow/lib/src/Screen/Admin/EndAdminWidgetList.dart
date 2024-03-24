import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Get/WaitingAdminGet.dart';
import 'package:waitingnow/src/Screen/Widget/WaitingAdminWidget.dart';

import '../../Controller/TimerController.dart';

class EndAdminWidgetList extends StatelessWidget {
  final TimerController timerController;
  EndAdminWidgetList(this.timerController);

  final WaitingAdminGet waitingAdminGet = Get.put(WaitingAdminGet());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<dynamic> items = waitingAdminGet.endVO.value;
      return Expanded(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return buildPage(items[index], index + 1);
          },
        ),
      );
    });
  }

  Widget buildPage(dynamic item, int index) {
    return WaitingAdminWidget(item, index, timerController);
  }
}
