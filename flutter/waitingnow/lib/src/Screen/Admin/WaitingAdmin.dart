import 'package:flutter/material.dart';

class WaitingAdmin extends StatefulWidget {
  const WaitingAdmin({super.key});

  @override
  State<WaitingAdmin> createState() => _WaitingAdminState();
}

class _WaitingAdminState extends State<WaitingAdmin> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top:10,bottom:10),
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
                  child: Center(
                      child: Text('ddd')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

