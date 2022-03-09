import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';

class LeaderBoardElement extends StatelessWidget {
  const LeaderBoardElement({Key? key, required this.time, required this.score})
      : super(key: key);

  final String time;
  final int score;

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
              time,
              style: ColorTheme.bodyTextMedium,
            ),
            Text(score.toString(), style: ColorTheme.bodyTextBoldSmall),
          ],
        ),
      ),
    );
  }
}
