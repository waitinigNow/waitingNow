import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  int initialTabIndex = Get.arguments ?? 0;

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
            Scaffold(),
            Scaffold(),
          ],
        ),
      ),
    );
  }
}
