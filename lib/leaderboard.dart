import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';
import 'package:merkapp/leaderboard_element.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future close() async => db.close();
}

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  State<Leaderboard> createState() => LeaderboardState();
}

class LeaderboardState extends State<Leaderboard> {
  final TextEditingController _textFieldController = TextEditingController();
  List<ScoreElement> prevScores = List.empty();
  late List<Map<String, dynamic>> records;
  bool inserted = false;

  var provider = ScoreProvider();
  late Database db;
  late SharedPreferences prefs;

  late int insertedId;

  String userName = 'user';

  @override
  void initState() {
    initdb();
    super.initState();
  }

  void initdb() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') == ''
          ? 'user'
          : prefs.getString('username')!;
    });
    db = await provider.open('Database.db');
    await getScores();
    // addUserScoreToDB();
  }

  void addUserScoreToDB() async {
    // DateTime now = DateTime.now();
    // DateFormat formatter = DateFormat('d.MM.yyyy HH:mm:ss');
    // String time = formatter.format(now);

    if (inserted == true) {
      print("already submitted");
      return;
    }
    if (widget.score < 1) return;

    Map<String, dynamic>? checkIfExists() {
      for (var record in records) {
        if (record[columnName] == userName) {
          return record;
        }
      }
      return null;
    }

    var exists = checkIfExists();
    if (exists == null) {
      ScoreElement inserted =
          await provider.insert(ScoreElement(0, userName, widget.score));

      insertedId = inserted.id;
    } else {
      if (widget.score > exists[columnScore]) {
        // need to update
        int count = await db.update(tableScores, {columnScore: widget.score},
            where: '$columnId = ?', whereArgs: [exists[columnId]]);

        print("updated score");
      } else {
        print("exists but new score is lower");
      }
      insertedId = exists[columnId];
    }
    setState(() {
      inserted = true;
    });
    await getScores();
  }

  Future getScores() async {
    records =
        await db.query(tableScores, orderBy: '-' + columnScore, limit: 20);

    setState(() {
      if (records.isEmpty) return;
      prevScores =
          List.generate(records.length > 20 ? 20 : records.length, (i) {
        return ScoreElement(records[i][columnId], records[i][columnName],
            records[i][columnScore]);
      });
    });
  }

  String? get _errorText {
    final text = _textFieldController.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    if (text.length > 14) {
      return 'Too long';
    }
    // return null if the text is valid
    return null;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    if (userName != 'user') {
      _textFieldController.text = userName;
    }
    return showDialog(
        context: context,
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: _textFieldController,
            builder: (context, TextEditingValue value, __) {
              return AlertDialog(
                backgroundColor: Colors.grey[500],
                title: const Text('Change name'),
                content: TextField(
                  maxLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  onSubmitted: (value) {
                    _submit();
                  },
                  controller: _textFieldController,
                  decoration: InputDecoration(
                      hintText: userName, errorText: _errorText),
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.red),
                    child: const Text('CANCEL'),
                    onPressed: () {
                      setState(() {
                        _textFieldController.clear();
                        Navigator.pop(context);
                      });
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.green),
                    child: const Text('OK'),
                    onPressed: () {
                      _submit();
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  void _submit() async {
    if (_errorText != null) return;
    setState(() {
      userName = _textFieldController.text;
      _setUsername(_textFieldController.text);
      _textFieldController.clear();
      Navigator.pop(context);
    });
  }

  void _setUsername(String newUsername) async {
    await prefs.setString('username', newUsername);
    print("set username in db");

    // update Username in db
    if (widget.score < 1) return;
    if (inserted == false) return;

    int count = await db.update(tableScores, {columnName: newUsername},
        where: '$columnId = ?', whereArgs: [insertedId]);
    if (count > 0) {
      // successfully
      print("changed db entry name to $newUsername");
      getScores();
    }
  }

  void deleteScoreEntry(int id) async {
    await db.delete(tableScores, where: '$columnId = ?', whereArgs: [id]);

    setState(() {
      prevScores.removeWhere((element) => element.id == id);
    });
    getScores();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: (MediaQuery.of(context).size.height * 0.38 -
                  (MediaQuery.of(context).size.height * 0.5 / 2))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: widget.score < 1
                    ? MediaQuery.of(context).size.height * 0.575
                    : MediaQuery.of(context).size.height * 0.5,
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
                                    name: scoreElement.name,
                                    id: scoreElement.id,
                                    score: scoreElement.score,
                                    delete: deleteScoreEntry,
                                    highlighted: insertedId == scoreElement.id
                                        ? true
                                        : false);
                              }),
                              if (prevScores.isEmpty)
                                Text(
                                  "No previous scores stored",
                                  style: ColorTheme.bodyTextBoldSmall,
                                ),
                              ElevatedButton(
                                  onPressed: () async {
                                    ScoreElement element =
                                        await provider.insert(ScoreElement(0,
                                            "Herbert", Random().nextInt(40)));
                                    setState(() {
                                      prevScores.add(element);
                                    });
                                  },
                                  child: const Text("add score databas")),
                              ElevatedButton(
                                  onPressed: () async {
                                    db.delete(tableScores, where: '1');
                                    setState(() {
                                      prevScores.clear();
                                    });
                                  },
                                  child: const Text("Clear DB")),
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                                splashFactory: NoSplash.splashFactory),
                            onPressed: () {
                              _displayTextInputDialog(context);
                            },
                            child: Row(children: [
                              Text(
                                  userName.substring(
                                      0,
                                      (userName.length > 15)
                                          ? 15
                                          : userName.length),
                                  style: ColorTheme.bodyTextBold), // NAME
                              Icon(
                                Icons.edit,
                                size: 22,
                                color: ColorTheme.textColor,
                              ),
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
        ),
      ],
    );
  }
}
