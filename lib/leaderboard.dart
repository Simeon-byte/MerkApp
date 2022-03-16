import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';
import 'package:merkapp/leaderboard_element.dart';
import 'package:sqflite/sqflite.dart';

const String tableScores = 'scores';
const String columnId = '_id';
const String columnName = 'name';
const String columnScore = 'score';

class ScoreElement {
  int id;
  String name;
  int score;

  Map<String, Object?> toMap() {
    var map = <String, dynamic>{columnName: name, columnScore: score};

    return map;
  }

  ScoreElement(this.id, this.name, this.score);
}

class ScoreProvider {
  late Database db;
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableScores (
          $columnId integer primary key autoincrement,
          $columnName text not null,
          $columnScore integer not null)
      ''');
    });
    return db;
  }

  Future<ScoreElement> insert(ScoreElement scoreElement) async {
    scoreElement.id = await db.insert(tableScores, scoreElement.toMap());
    print("inserted ${scoreElement.name}");
    return scoreElement;
  }

  Future<ScoreElement?> getTodo(int id) async {
    List<Map> maps = await db.query(tableScores,
        columns: [columnId, columnName, columnScore],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      Map<dynamic, dynamic> map = maps.first;
      return ScoreElement(map[columnId], map[columnName], map[columnScore]);
    }
    return null;
  }

  Future close() async => db.close();
}

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<ScoreElement> prevScores = List.empty();
  var provider = ScoreProvider();
  late Database db;
  @override
  void initState() {
    initdb();
    super.initState();
  }

  void initdb() async {
    db = await provider.open('Database.db');
    getScores();
    addUserScoreToDB();
  }

  void addUserScoreToDB() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('d.MM.yyyy HH:mm:ss');
    String time = formatter.format(now);

    if (widget.score > 0) {
      provider.insert(ScoreElement(0, time, widget.score));
    }
  }

  void getScores() async {
    List<Map<String, dynamic>> records =
        await db.query(tableScores, orderBy: '-' + columnScore);

    setState(() {
      if (records.isEmpty) return;
      prevScores = List.generate(records.length, (i) {
        return ScoreElement(records[i][columnId], records[i][columnName],
            records[i][columnScore]);
      });
    });
    // inspect(records);
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 - 50,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            ...prevScores.map((scoreElement) {
                              return LeaderBoardElement(
                                  time: scoreElement.name,
                                  score: scoreElement.score);
                            }),

                            if (prevScores.isEmpty)
                              Text(
                                "No previous scores stored",
                                style: ColorTheme.bodyTextBoldSmall,
                              ),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       ScoreElement element = await provider
                            //           .insert(ScoreElement(0, "Herbert", 50));
                            //       setState(() {
                            //         prevScores.add(element);
                            //       });
                            //     },
                            //     child: const Text("add score databas")),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       db.delete(tableScores, where: '1');
                            //       setState(() {
                            //         prevScores.clear();
                            //       });
                            //     },
                            //     child: const Text("Clear DB")),
                          ],
                        ),
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
                        TextButton(
                          style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory),
                          onPressed: () => {print("bob")},
                          child: Row(children: [
                            Text('You', style: ColorTheme.bodyTextBold),
                            // Icon(
                            //   Icons.edit,
                            //   size: 22,
                            //   color: ColorTheme.textColor,
                            // ),
                          ]),
                        ),
                        Text(widget.score.toString(),
                            style: widget.score > 0
                                ? ColorTheme.bodyTextVeryBold
                                : ColorTheme.bodyTextRed),
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
