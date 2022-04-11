import 'package:flutter/material.dart';
import 'package:merkapp/utils/theme.dart';
import 'package:merkapp/utils/button_widgets.dart';

class HomePageContent extends StatelessWidget {
  HomePageContent(
      {Key? key,
      required this.score,
      required this.buttons,
      required this.started,
      required this.startGame})
      : super(key: key);

  int score;
  ButtonCollection buttons;
  bool started;
  Function startGame;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                            startGame();
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0x00727272)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 55, 0, 0),
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
    );
  }
}
