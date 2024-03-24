import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Screen/Widget/Desk/TableAssignWidget.dart';
import 'package:waitingnow/src/Screen/Widget/Waiting/WaitingAdminWidget.dart';

import '../../../Get/DeskGet.dart';

class TableAssignWidgetList extends StatelessWidget {
  final DeskGet deskGet = Get.put(DeskGet());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<dynamic> items = deskGet.Desks.value;
      return Expanded( // Expanded 위젯 추가
        child: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return TableAssignWidget(items[index], index);
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFCCCCCC),
            );
          },
        ),
      );
    });
  }

  Widget buildPage(dynamic item, int index) {
    return TableAssignWidget(item, index);
  }
}
