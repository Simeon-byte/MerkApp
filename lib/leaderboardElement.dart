import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';

class LeaderBoardElement extends StatelessWidget {
  const LeaderBoardElement({Key? key}) : super(key: key);

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
              '23.02.2022 17:40',
              style: ColorTheme.bodyTextMedium,
            ),
            Text('10', style: ColorTheme.bodyTextBoldSmall),
          ],
        ),
      ),
    );
  }
}
