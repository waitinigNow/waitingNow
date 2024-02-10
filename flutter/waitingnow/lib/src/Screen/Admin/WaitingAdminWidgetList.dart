import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Get/WaitingAdminGet.dart';
import 'package:waitingnow/src/Screen/Widget/WaitingAdminWidget.dart';

class WaitingAdminWidgetList extends StatelessWidget {
  final WaitingAdminGet waitingAdminGet = Get.put(WaitingAdminGet());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<dynamic> items = waitingAdminGet.waitingVO.value;
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return WaitingAdminWidget(items[index], index + 1);
        },
      );
    });
  }

  Widget buildPage(dynamic item, int index) {
    return WaitingAdminWidget(item, index);
  }
}
