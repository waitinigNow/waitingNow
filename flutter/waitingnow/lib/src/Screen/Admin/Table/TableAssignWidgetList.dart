import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waitingnow/src/Screen/Widget/Desk/TableAndOrderWidget.dart';
import 'package:waitingnow/src/Screen/Widget/Desk/TableAssignWidget.dart';
import 'package:waitingnow/src/Screen/Widget/Waiting/WaitingAdminWidget.dart';

import '../../../Get/DeskGet.dart';

class TableAssignWidgetList extends StatelessWidget {
  final String gotoPage;
  TableAssignWidgetList(this.gotoPage);

  final DeskGet deskGet = Get.put(DeskGet());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<dynamic> items = deskGet.Desks.value;
      return ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            if(this.gotoPage == "TableAssignWidget"){
              return TableAssignWidget(items[index], index);
            }
            else if(this.gotoPage == "TableAndOrderWidget"){
              return TableAndOrderWidget(items[index], index);
            }
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFCCCCCC),
            );
          },
      );
    });
  }

  Widget buildPage(dynamic item, int index) {
    if(this.gotoPage == "TableAssignWidget"){
      return TableAssignWidget(item, index);
    }
    else if(this.gotoPage == "TableAndOrderWidget"){
      return TableAndOrderWidget(item, index);
    }
    else{
      return TableAssignWidget(item, index);
    }
  }
}
