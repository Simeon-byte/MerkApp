import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';
import 'package:merkapp/leaderboardElement.dart';
import 'package:localstorage/localstorage.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({Key? key, required this.score}) : super(key: key);

  final int score;
  final LocalStorage storage = LocalStorage('AppStorage');

  Map<String, int>? getScoresFromLocalStorage() {
    String? scoresJSON = storage.getItem('scores');
    if (scoresJSON == null) {
      print("empty");
      return null;
    }
    return Map<String, int>.from(json.decode(scoresJSON));
  }

  void addScoreToLocalStorage(int score) {
    Map<String, int>? info = getScoresFromLocalStorage();

    DateTime now = DateTime.now();
    String time = DateFormat.d().format(now) +
        '.' +
        DateFormat.M().format(now) +
        '.' +
        DateFormat.y().format(now) +
        ' ' +
        DateFormat.H().format(now) +
        ':' +
        DateFormat.m().format(now);

    print(time);

    if (info != null && info.isNotEmpty) {
      info.putIfAbsent(time, () => score);
      storage.setItem('scores', json.encode(info));
    } else {
      storage.setItem(
          'scores',
          json.encode(<String, int>{
            time: score,
          }));
    }
  }

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  Map<String, int> prevScores = {};
  @override
  void initState() {
    setState(() {
      prevScores = widget.getScoresFromLocalStorage() ?? {};
    });
    widget.addScoreToLocalStorage(widget.score);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  color: ColorTheme.grauDunkel,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          // prevScores != null ? prevScores.forEach((key, value) => LeaderBoardElement()) : LeaderBoardElement();

                          ...prevScores.entries.map((entry) {
                            return LeaderBoardElement(
                                time: entry.key, score: entry.value);
                          }),

                          if (prevScores.isEmpty)
                            Text(
                              "No previous scores stored",
                              style: ColorTheme.bodyTextBoldSmall,
                            ),
                          // ElevatedButton(
                          //     onPressed: () =>
                          //         {print(widget.getScoresFromLocalStorage())},
                          //     child: const Text("get")),
                          // ElevatedButton(
                          //     onPressed: () => setState(() {
                          //           widget.storage.clear();
                          //           prevScores = {};
                          //         }),
                          //     child: const Text("clear"))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorTheme.grauDunkel2,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('You', style: ColorTheme.bodyTextBold),
                        Text(widget.score.toString(),
                            style: ColorTheme.bodyTextVeryBold),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
