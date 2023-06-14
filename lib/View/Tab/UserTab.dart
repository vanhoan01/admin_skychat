// ignore_for_file: file_names

import 'package:admin_skychat/Model/Model/OthersStatusModel.dart';
import 'package:admin_skychat/View/Component/UserTab/OthersStatusWidget.dart';
import 'package:admin_skychat/View/Component/UserTab/pie_chart_sample2.dart';
import 'package:admin_skychat/ViewModel/OthersStatusListViewModel.dart';
import 'package:admin_skychat/ViewModel/UserViewModel.dart';
import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserTab extends StatefulWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> with SingleTickerProviderStateMixin {
  // late IO.Socket socket;
  UserViewModel userViewModel = UserViewModel();
  OthersStatusListViewModel othersStatusListViewModel =
      OthersStatusListViewModel();
  List<OthersStatusModel> _otherStatusList = [];

  @override
  void initState() {
    super.initState();
    getFriendStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              const PieChartSample2(),
              label("Danh sách"),
              // label(
              //     "Đang hoạt động (${_otherStatusList.where((e) => e.precense == "Hoạt động").length})"),
              for (var item in _otherStatusList)
                if (item.precense == "Hoạt động")
                  OthersStatusWidget(
                    othersStatusModel: item,
                  ),
              // const SizedBox(height: 10),
              // label(
              //     "Không hoạt động (${_otherStatusList.where((e) => e.precense != "Hoạt động").length})"),
              for (var item in _otherStatusList)
                if (item.precense != "Hoạt động")
                  OthersStatusWidget(
                    othersStatusModel: item,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getFriendStatus() async {
    List<OthersStatusModel> data =
        await othersStatusListViewModel.getFriendStatus();
    // NavigationService.instance.navigationKey.currentContext ?? context,
    setState(() {
      _otherStatusList = data;
    });
  }

  Widget label(String lablename) {
    return SizedBox(
      height: 33,
      width: MediaQuery.of(context).size.width,
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Text(
          lablename,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
