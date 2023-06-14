// ignore_for_file: file_names

import 'package:admin_skychat/Model/Model/OthersStatusModel.dart';
import 'package:admin_skychat/View/Component/Generality/StatisticalWidget.dart';
import 'package:admin_skychat/View/Component/UserTab/OthersStatusWidget.dart';
import 'package:admin_skychat/View/Component/UserTab/pie_chart_sample2.dart';
import 'package:admin_skychat/ViewModel/OthersStatusListViewModel.dart';
import 'package:admin_skychat/ViewModel/UserViewModel.dart';
import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class GroupTab extends StatefulWidget {
  const GroupTab({Key? key}) : super(key: key);

  @override
  State<GroupTab> createState() => _GroupTabState();
}

class _GroupTabState extends State<GroupTab>
    with SingleTickerProviderStateMixin {
  // late IO.Socket socket;
  UserViewModel userViewModel = UserViewModel();
  OthersStatusListViewModel othersStatusListViewModel =
      OthersStatusListViewModel();
  List<OthersStatusModel> _otherStatusList = [];

  @override
  void initState() {
    super.initState();
    getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              GridView.extent(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                childAspectRatio: (1 / .5),
                maxCrossAxisExtent: 200.0,
                children: const [
                  StatisticalWidget(
                      select: false,
                      title: "Lượt tin nhắn",
                      currently: 27,
                      before: 18),
                  StatisticalWidget(
                      select: false,
                      title: "Số nhóm",
                      currently: 29,
                      before: 22),
                ],
              ),
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

  Future<void> getGroups() async {
    List<OthersStatusModel> data =
        await othersStatusListViewModel.getGroupStatus();
    // NavigationService.instance.navigationKey.currentContext ?? context,
    data.sort((a, b) {
      int precenseComp = a.precense.compareTo(b.precense);
      if (precenseComp == 0) {
        return a.displayName.compareTo(b.displayName); // '-' for descending
      }
      return precenseComp;
    });
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
