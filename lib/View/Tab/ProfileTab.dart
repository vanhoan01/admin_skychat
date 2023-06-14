// ignore_for_file: file_names

import 'package:admin_skychat/Model/Model/userModel.dart';
import 'package:admin_skychat/Resources/app_urls.dart';
import 'package:admin_skychat/View/Screen/Profile/Screens/ProfileEdit.dart';
import 'package:admin_skychat/ViewModel/UserViewModel.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key, this.userName});
  final String? userName;
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  UserViewModel userViewModel = UserViewModel();
  UserModel? userModel;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    getUser();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  void getUser() async {
    UserModel data = await userViewModel.getUserModel();
    setState(() {
      userModel = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "${AppUrl.imageUrl}${userModel != null ? userModel!.avatarImage : ""}"),
                    radius: 55,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.greenAccent[700],
                      child: const Icon(
                        Icons.add,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                userModel != null ? userModel!.displayName : "",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              userModel != null
                  ? userModel!.biography != null
                      ? Text(
                          userModel != null ? userModel!.biography ?? "" : "",
                          style: const TextStyle(fontSize: 16),
                        )
                      : const SizedBox()
                  : const SizedBox(),
              const SizedBox(height: 15),
              OptionItem(Icons.people_outlined, "500 người bạn"),
              userModel != null
                  ? userModel!.link != null
                      ? OptionItem(Icons.link,
                          userModel != null ? userModel!.link ?? "" : "")
                      : const SizedBox()
                  : const SizedBox(),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 15),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileEdit(),
                          ),
                        ).then((value) => getUser());
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 1, color: Color.fromRGBO(224, 224, 224, 1)),
                      ),
                      child: const Text(
                        "Sửa hồ sơ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 1, color: Color.fromRGBO(224, 224, 224, 1)),
                      ),
                      child: const Text(
                        "Đăng xuất",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 15),
              // Column(
              //   children: [
              //     TabBar(
              //       controller: _tabController,
              //       indicatorColor: Colors.black,
              //       labelColor: Colors.black,
              //       labelPadding: const EdgeInsets.all(2),
              //       tabs: const [
              //         Tab(text: "Ảnh Video"),
              //         Tab(text: "Tệp"),
              //         Tab(text: "Đã Lưu"),
              //         Tab(text: "Đã Thích"),
              //       ],
              //     ),
              //     SizedBox(
              //       height: 500,
              //       child: TabBarView(
              //         controller: _tabController,
              //         children: const [
              //           ImageTab(),
              //           FileTab(),
              //           SavedTab(),
              //           LikeTab(),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget OptionItem(IconData iconData, String title) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.grey,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      horizontalTitleGap: 0,
      // dense: true,
      // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: -10),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    );
  }
}
