import 'package:flutter/material.dart';
import 'package:waitingnow/src/Screen/Admin/WaitingAdmin.dart';
import 'package:waitingnow/src/Screen/Widget/DrawerWidget.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          actions: [
            IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
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
      endDrawer: DrawerWidget(),
      body: const TabBarView(
        children: <Widget>[
          WaitingAdmin(),
          Scaffold(),
          Scaffold(),
        ],
      ),
    )
    ,
    );
  }
}
