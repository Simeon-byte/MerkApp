import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            flexibleSpace: const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  'MörkÄpp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
        body: Center(child: Text(score.toString())));
  }
}
