// ignore_for_file: file_names

import 'package:admin_skychat/View/Tab/GeneralityTab.dart';
import 'package:admin_skychat/View/Tab/GroupTab.dart';
import 'package:admin_skychat/View/Tab/ProfileTab.dart';
import 'package:admin_skychat/View/Tab/UserTab.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController? _tabController;

  @override
  void initState() {
    // connectSocket();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkyChat'),
        bottom: TabBar(
          labelPadding: const EdgeInsets.symmetric(horizontal: 2),
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text('Tổng quát'),
            ),
            Tab(
              child: Text('Người dùng'),
            ),
            Tab(
              child: Text('Nhóm'),
            ),
            Tab(
              child: Text('Hồ sơ'),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // showSearch(
              //   context: context,
              //   delegate: SearchScreen(),
              // );
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          GeneralityTab(),
          UserTab(),
          GroupTab(),
          ProfileTab(),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Tab TabCustom(IconData icon, String text) {
    return Tab(
      icon: Icon(
        icon,
        size: 23,
      ),
      iconMargin: const EdgeInsets.all(3),
      height: 50,
      child: Text(
        text,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
