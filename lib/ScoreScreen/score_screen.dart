import 'package:flutter/material.dart';
import 'package:merkapp/utils/theme.dart';
import 'package:merkapp/ScoreScreen/leaderboard.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key, required this.score, required this.title})
      : super(key: key);

  final int score;
  final String title;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final leaderboardKey = GlobalKey<LeaderboardState>();
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          actions: const [],
          elevation: 4,
        ),
      ),
      backgroundColor: ColorTheme.grauDunkel2,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: ColorTheme.grauHell,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                if (widget.score > 0)
                  Align(
                    alignment: const AlignmentDirectional(0, 0.625),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ColorTheme.grauDunkel,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ElevatedButton(
                          onPressed: submitted
                              ? null
                              : () {
                                  leaderboardKey.currentState
                                      ?.addUserScoreToDB();
                                  setState(() {
                                    submitted = true;
                                  });
                                },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0x00727272)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(
                                          color: ColorTheme.border,
                                          width: 3)))),
                          child: const Text(
                            // FFAppState().score.toString(),
                            'Submit Score',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 30, 30, 30),
                            ),
                          ),
                        )),
                  ),
                Align(
                  alignment: const AlignmentDirectional(0, 0.95),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 85,
                    decoration: BoxDecoration(
                      color: ColorTheme.grauDunkel,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0x00727272)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: ColorTheme.border,
                                          width: 3)))),
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorTheme.grauHell,
                    ),
                    child: Stack(
                      children: const [
                        Align(
                          alignment: AlignmentDirectional(0, -0.8),
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
                          alignment: AlignmentDirectional(-0.05, 0.4),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                Leaderboard(
                  key: leaderboardKey,
                  score: widget.score,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
