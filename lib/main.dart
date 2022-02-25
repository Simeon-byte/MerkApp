import 'package:flutter/material.dart';
import 'package:merkapp/HomePage.dart';

void main() {
  runApp(const MyApp());
}

// java -jar .\bundletool-all-1.8.2.jar install-apks --apks=app-release.apk

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late MyHomePage homepage = MyHomePage(
    title: 'MörkApp',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homepage,
    );
  }
}
