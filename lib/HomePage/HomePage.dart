import 'package:flutter/material.dart';
import 'package:merkapp/HomePage/homePage_content.dart';
import 'package:merkapp/utils/button_widgets.dart';
import 'package:merkapp/utils/functionality.dart';
import 'package:merkapp/ScoreScreen/score_screen.dart';
import 'package:merkapp/utils/theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _buttonKey = GlobalKey<ButtonCollectionState>();

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool started = false;
  int score = 0;
  List<int> sequence = [];
  int sequenceIndex = 0;
  bool isFlashing = false;

  void _setFlashing(int value) {
    setState(() {
      if (value == 1) {
        isFlashing = true;
      } else {
        isFlashing = false;
      }
    });
  }

  void handleClick(int index) async {
    if (!started || isFlashing == true) return;
    if (index == sequence[sequenceIndex]) {
      // Answer is right
      setState(() {
        score++;
      });

      if (sequenceIndex + 1 == sequence.length) {
        setState(() {
          isFlashing = true;
          sequence = generateSequence(sequence.length + 1);
          sequenceIndex = 0;
        });

        print(sequence);
        await Future.delayed(const Duration(milliseconds: 250), () {});
        widget._buttonKey.currentState?.flashButtons(sequence);
      } else {
        setState(() {
          sequenceIndex++;
        });
      }
      print('new Index: $sequenceIndex');
    } else {
      // Answer is wrong

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ScoreScreen(score: score, title: widget.title)),
        (Route<dynamic> route) => false,
      );
    }
  }

  void _startGame() {
    setState(() {
      sequence = generateSequence(3);
      started = true;
      isFlashing = true;
    });

    widget._buttonKey.currentState?.flashButtons(sequence);
    print(sequence);
  }

  void _incrementCounter(int value) {
    if (!started) return;
    setState(() {
      score += value;
      print('increment: $score');
    });
  }

  late ButtonCollection buttons = ButtonCollection(
      key: widget._buttonKey,
      score: score,
      incrementCounter: _incrementCounter,
      started: started,
      sequence: sequence,
      sequenceIndex: sequenceIndex,
      handleClick: handleClick,
      setFlashing: _setFlashing);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: widget._scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Roboto Mono',
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
          ),
          elevation: 4,
        ),
      ),
      backgroundColor: ColorTheme.grauDunkel2,
      body: SafeArea(
          child: HomePageContent(
        score: score,
        buttons: buttons,
        started: started,
        startGame: _startGame,
      )),
    );
  }
}
