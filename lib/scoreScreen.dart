import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';
import 'package:merkapp/leaderboard.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key, required this.score, required this.title})
      : super(key: key);

  final int score;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title,
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
                  alignment: const AlignmentDirectional(0, 0.95),
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
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: ColorTheme.grauDunkel,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          },
                          child: const Text(
                            // FFAppState().score.toString(),
                            'Restart',
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
                      )),
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
                            'Leaderboard',
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
                              'Your current score compared with previous tries',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Leaderboard(), //buttons,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
