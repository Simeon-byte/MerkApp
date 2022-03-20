import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:merkapp/leaderboard.dart';
import 'package:merkapp/theme.dart';
import 'package:sqflite/sqflite.dart';

class LeaderBoardElement extends StatelessWidget {
  const LeaderBoardElement(
      {Key? key,
      required this.name,
      required this.id,
      required this.score,
      required this.delete})
      : super(key: key);

  final String name;
  final int score;
  final int id;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0x32000000),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: ColorTheme.bodyTextMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(score.toString(), style: ColorTheme.bodyTextBoldSmall),
                SizedBox(
                  width: 18,
                  height: 18,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                    ),
                    onPressed: () {
                      delete(id);

                      print("delete");
                    },
                    child: Icon(
                      Icons.delete_rounded,
                      size: 20,
                      color: ColorTheme.textColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
