import 'package:flutter/material.dart';
import '/HomePage/homePage.dart';
import '/LoginPage/loginPage.dart';

void main() async {
  runApp(const MyApp());
}

// java -jar .\bundletool-all-1.8.2.jar install-apks --apks=app-release.apk

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = true; //false;
  MyHomePage homepage = MyHomePage(
    title: 'MörkApp',
  );
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: loggedIn ? homepage : LoginPage());
  }
}
