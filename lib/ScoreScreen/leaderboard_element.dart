import 'package:flutter/material.dart';
import 'package:merkapp/utils/theme.dart';

class LeaderBoardElement extends StatelessWidget {
  const LeaderBoardElement(
      {Key? key,
      required this.name,
      required this.id,
      required this.score,
      required this.delete,
      required this.highlighted})
      : super(key: key);

  final String name;
  final int score;
  final int id;
  final Function delete;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: highlighted == true
            ? const Color.fromARGB(255, 116, 114, 114)
            : const Color(0x32000000),
        border: highlighted == true
            ? Border.all(
                color: const Color(0x32000000),
                width: 2,
              )
            : null,
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
