import 'package:flutter/material.dart';
import 'package:merkapp/homepage.dart';
import 'package:merkapp/login_page.dart';

void main() async {
  runApp(MyApp());
}

// java -jar .\bundletool-all-1.8.2.jar install-apks --apks=app-release.apk

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loggedIn = true; //false;
  late MyHomePage homepage = MyHomePage(
    title: 'MörkApp',
  );
  @override
  initState() {
    // getUserState();
    super.initState();
  }

  // void getUserState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       setState(() {
  //         loggedIn = false;
  //       });
  //     } else {
  //       setState(() {
  //         loggedIn = true;
  //       });
  //       print(user.uid);

  //       print('User is signed in!');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: loggedIn ? homepage : LoginPage());
  }
}
