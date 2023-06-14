// ignore_for_file: file_names

import 'package:admin_skychat/Data/Services/network_handler.dart';
import 'package:admin_skychat/Model/Model/StatisticalModel.dart';
import 'package:admin_skychat/Model/Model/userModel.dart';
import 'package:admin_skychat/ViewModel/ImageViewModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class UserViewModel {
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  Future<UserModel> getUserModel() async {
    UserModel? userModel;
    try {
      var responsePD = await networkHandler.get("/user/getData");
      userModel = UserModel.fromJson(responsePD);
      // ignore: avoid_print
      print('userModel: ${userModel.displayName}');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return userModel!;
  }

  Future<bool> checkPhoneNumber(String phoneNumber) async {
    try {
      var body = await networkHandler
          .getNoToken("/user/checkphonenumber/$phoneNumber");
      // ignore: avoid_print
      print('responsePD: $body');
      bool check = body['status'];
      return check;
    } catch (e) {
      return true;
    }
  }

  Future<bool> checkUserName(String userName) async {
    try {
      var body =
          await networkHandler.getNoToken("/user/checkusername/$userName");
      // ignore: avoid_print
      print('responsePD: $body');
      bool check = body['status'];
      return check;
    } catch (e) {
      return true;
    }
  }

  Future<Response> login(String userName, String password) async {
    Map<String, String> data = {
      "userName": userName,
      "password": password,
    };
    var body = await networkHandler.post2("/user/login", data);
    return body;
  }

  Future<void> updateAvatarImage(PickedFile imageFile) async {
    try {
      String avatarImage = await ImageViewModel(imageFile).uploadImage();
      var responseUD =
          await networkHandler.get("/user/update/avatarimage/$avatarImage");
      // ignore: avoid_print
      print('responsePD: $responseUD');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> updateLink(String link) async {
    try {
      var responseUD = await networkHandler.get("/user/update/link/$link");
      // ignore: avoid_print
      print('responsePD: $responseUD');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> updateChatID(String chatID) async {
    try {
      var responseUD = await networkHandler.get("/user/update/chatid/$chatID");
      // ignore: avoid_print
      print('token: $responseUD["token"]');
      await storage.write(key: "token", value: responseUD["token"]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> updateBiography(String biography) async {
    try {
      var responseUD =
          await networkHandler.get("/user/update/biography/$biography");
      // ignore: avoid_print
      print('responsePD: $responseUD');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<String> getRelationship(String userName) async {
    String? relation;
    try {
      var res = await networkHandler.get("/user/get/relationship/$userName");
      relation = res.toString();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return relation!;
  }

  Future<StatisticalModel> getStatistical(String day) async {
    StatisticalModel? statisticalModel;
    try {
      var res = await networkHandler.get("/user/statistical/$day");
      statisticalModel = StatisticalModel.fromJson(res);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return statisticalModel!;
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      var responseUD =
          await networkHandler.get("/user/update/diplayname/$displayName");
      // ignore: avoid_print
      print('responsePD: $responseUD');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
