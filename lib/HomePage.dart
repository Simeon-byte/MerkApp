import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';
import 'package:merkapp/Widgets.dart';
import 'package:merkapp/scoreScreen.dart';
import 'package:merkapp/functionality.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  final _buttonKey = GlobalKey<ButtonColumnState>();

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

      // Navigator.pushReplacement(
      //   // ctx, MaterialPageRoute(builder: (ctx) => ScoreScreen(score: _score))
      //   ctx,
      //   PageRouteBuilder(
      //     transitionDuration: Duration.zero,
      //     pageBuilder: (_, __, ___) => ScoreScreen(score: _score),
      //   ),

      //   // Navigator.push(
      //   //   ctx,
      //   //   MaterialPageRoute(builder: (ctx) => ScoreScreen(score: _score)),
      // );
      // handle wrong click
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

  // @override
  // void initState() {
  //   super.initState();
  //   score = score;
  // }

  void _incrementCounter(int value) {
    if (!started) return;
    setState(() {
      score += value;
      print('increment: $score');
    });
  }

  // void handleSequenceNew(int index) {
  //   handleSequence(context, index);
  // }

  late ButtonColumn buttons = ButtonColumn(
      key: widget._buttonKey,
      score: score,
      incrementCounter: _incrementCounter,
      started: started,
      sequence: sequence,
      sequenceIndex: sequenceIndex,
      handleClick: handleClick,
      setFlashing: _setFlashing);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
          actions: [],
          elevation: 4,
        ),
      ),
      backgroundColor: ColorTheme.grauDunkel2,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 30),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: ColorTheme.grauHell,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0.87),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: ColorTheme.grauDunkel2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: const AlignmentDirectional(0, 0),
                    child: started == false
                        ? Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: ColorTheme.grauDunkel,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                _startGame();
                              },
                              child: const Text(
                                // FFAppState().score.toString(),
                                'Start Game',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 30, 30, 30),
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0x00727272)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          side: BorderSide(
                                              color: ColorTheme.border,
                                              width: 3)))),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Score:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 30, 30, 30),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 0, 0),
                                child: Text(
                                  score.toString(),
                                  // 'tmp',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 30, 30, 30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorTheme.grauHell,
                    ),
                    alignment: const AlignmentDirectional(0, -0.5),
                    child: Stack(
                      children: const [
                        Align(
                          alignment: AlignmentDirectional(-0.05, -0.6),
                          child: Text(
                            'Remember',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 30, 30, 30),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.05, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 55, 0, 0),
                            child: Text(
                              'the order in which the buttons flash',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: buttons,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
