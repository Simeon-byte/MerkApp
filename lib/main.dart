import 'package:flutter/material.dart';
import 'package:merkapp/HomePage.dart';
import 'package:merkapp/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
  } catch (err) {
    print(err);
  }
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

  late MyHomePage homepage = MyHomePage(
    title: 'MörkApp',
  );
  @override
  initState() {
    getUserState();
    super.initState();
  }

  void getUserState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          loggedIn = false;
        });
      } else {
        setState(() {
          loggedIn = true;
        });
        print(user.uid);

        print('User is signed in!');
      }
    });
  }

  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: loggedIn ? homepage : LoginPage());
  }
}
