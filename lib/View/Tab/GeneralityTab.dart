import 'package:admin_skychat/Model/Model/StatisticalModel.dart';
import 'package:admin_skychat/View/Component/Generality/StatisticalWidget.dart';
import 'package:admin_skychat/View/Component/Generality/line_chart_card.dart';
import 'package:admin_skychat/ViewModel/UserViewModel.dart';
import 'package:flutter/material.dart';

class GeneralityTab extends StatefulWidget {
  const GeneralityTab({super.key});

  @override
  State<GeneralityTab> createState() => _GeneralityTabState();
}

class _GeneralityTabState extends State<GeneralityTab> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "7", child: Text("7 ngày qua")),
      const DropdownMenuItem(value: "30", child: Text("30 ngày qua")),
      const DropdownMenuItem(value: "60", child: Text("60 ngày qua")),
    ];
    return menuItems;
  }

  StatisticalModel? statisticalModel;
  String selectedValue = "7";
  UserViewModel userViewModel = UserViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(selectedValue);
  }

  Future<void> getData(String selectedValue) async {
    StatisticalModel statistical =
        await userViewModel.getStatistical(selectedValue);
    setState(() {
      statisticalModel = statistical;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton(
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(
                    () {
                      selectedValue = newValue!;
                    },
                  );
                  print(selectedValue);
                  getData(selectedValue);
                },
                items: dropdownItems,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 15),
              const Text(
                "Số liệu chính",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              GridView.extent(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                childAspectRatio: (1 / .5),
                maxCrossAxisExtent: 200.0,
                children: [
                  StatisticalWidget(
                      select: true,
                      title: "Lượt tin nhắn",
                      currently: statisticalModel == null
                          ? 0
                          : statisticalModel!.chatCountNew,
                      before: statisticalModel == null
                          ? 0
                          : statisticalModel!.chatCountOld),
                  const StatisticalWidget(
                      select: false,
                      title: "Người dùng",
                      currently: 29,
                      before: 22),
                  const StatisticalWidget(
                      select: false, title: "Nhóm", currently: 22, before: 23),
                  StatisticalWidget(
                      select: false,
                      title: "Hình ảnh",
                      currently: statisticalModel == null
                          ? 0
                          : statisticalModel!.imageCountNew,
                      before: statisticalModel == null
                          ? 0
                          : statisticalModel!.imageCountOld),
                  StatisticalWidget(
                      select: false,
                      title: "Video",
                      currently: statisticalModel == null
                          ? 0
                          : statisticalModel!.videoCountNew,
                      before: statisticalModel == null
                          ? 0
                          : statisticalModel!.videoCountOld),
                  StatisticalWidget(
                      select: false,
                      title: "File",
                      currently: statisticalModel == null
                          ? 0
                          : statisticalModel!.fileCountNew,
                      before: statisticalModel == null
                          ? 0
                          : statisticalModel!.fileCountOld),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                "Biểu đồ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              LineChartCard(),
            ],
          ),
        ),
      ),
    );
  }
}
