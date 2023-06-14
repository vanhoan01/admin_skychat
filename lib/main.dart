import 'package:admin_skychat/View/Login/LoginScreen.dart';
import 'package:admin_skychat/View/Tab/Homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  Widget page = Container();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void checkLogin() async {
    String? token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = const Homescreen();
      });
    } else {
      setState(() {
        page = const LoginScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkyChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: page,
    );
  }
}
