// ignore_for_file: file_names

import 'dart:convert';
import 'package:admin_skychat/Data/Services/network_handler.dart';
import 'package:admin_skychat/View/Tab/Homescreen.dart';
import 'package:admin_skychat/ViewModel/UserViewModel.dart';
import 'package:admin_skychat/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  final storage = const FlutterSecureStorage();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserViewModel userViewModel = UserViewModel();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnack(String title) {
    final snackbar = SnackBar(
        backgroundColor: Colors.grey,
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ));
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 100, bottom: 20),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'ChatApp',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
              ),
              Form(
                key: _globalkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Số điện thoại không được để trống";
                              return null;
                            },
                            decoration: const InputDecoration(
                              // errorText: validate ? null : errorText,
                              hintText: "Số điện thoại hoặc tài khoản",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.teal), //<-- SEE HERE
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Mật khẩu không được trống";
                              }
                              if (value.length < 8) {
                                return "Mật khẩu phải có ít nhất 8 kí tự";
                              }
                              return null;
                            },
                            // obscureText: vis,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Mật khẩu",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.teal), //<-- SEE HERE
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Quên mật khẩu?',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 10.0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () async {
                            if (_globalkey.currentState!.validate()) {
                              var response = await userViewModel.login(
                                  _usernameController.text,
                                  _passwordController.text);
                              if (response.statusCode == 200 ||
                                  response.statusCode == 201) {
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                // ignore: avoid_print
                                print(output["token"]);
                                await storage.write(
                                    key: "token", value: output["token"]);
                                // setState(() {
                                //   validate = true;
                                //   circular = false;
                                // });
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(),
                                  ),
                                  (route) => false,
                                );
                              } else {
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(SnackBar(
                                //   content: Text("Netwok Error"),
                                // ));
                                showSnack("Netwok Error");
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
