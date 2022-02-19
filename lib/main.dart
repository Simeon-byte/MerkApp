import 'package:flutter/material.dart';
import 'package:merkapp/scoreScreen.dart';
import 'package:merkapp/HomePage.dart';
import 'package:merkapp/functionality.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _started = false;
  int _score = 0;
  List<int> sequence = [];
  int sequenceIndex = 0;

  void handleSequence(BuildContext ctx, bool right) {
    print('Answer was $right');
    if (right == true) {
      setState(() {
        if (sequenceIndex + 1 == sequence.length) {
          sequence = generateSequence(sequence.length + 1);
          sequenceIndex = 0;
          print(sequence);
        } else {
          sequenceIndex++;
        }

        print('new Index: $sequenceIndex');
      });
    } else {
      Navigator.push(
        ctx,
        MaterialPageRoute(builder: (ctx) => ScoreScreen(score: _score)),
      );
      // handle wrong click
    }
  }

  void _startGame(_) {
    setState(() => {_started = true});
    setState(() {
      sequence = generateSequence(3);
      print(sequence);
    });
  }

  @override
  void initState() {
    super.initState();
    _score = _score;
  }

  void _incrementCounter(int value) {
    if (!_started) return;
    setState(() {
      _score += value;
      print('increment: $_score');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'MörkApp',
        score: _score,
        incrementCounter: _incrementCounter,
        started: _started,
        startGame: _startGame,
        sequence: sequence,
        sequenceIndex: sequenceIndex,
        handleSequence: handleSequence,
      ),
    );
  }
}
