import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';
import 'dart:async';

class MyButton extends StatefulWidget {
  final Function selectHandler;
  bool started;
  MyButton(Key key, this.selectHandler, this.started) : super(key: key);
  // const MyButton(Key key,this.selectHandler, this.flashing, {this.color,});

  @override
  State<MyButton> createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  bool flashing = false;
  bool active = true;
  Color flashColor = Colors.black;

  void flashButton(Color color, int flashDuration) {
    setState(() {
      flashing = true;
      flashColor = color;
    });

    Timer(Duration(milliseconds: flashDuration), () {
      setState(() {
        flashing = false;
      });
    });
  }

  void setActive(bool v) {
    setState(() {
      active = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            active || flashing
                ? ColorTheme.border
                : ColorTheme.border.withOpacity(0.5),
            flashing
                ? flashColor
                : (active
                    ? ColorTheme.grauDunkel
                    : ColorTheme.grauDunkel.withOpacity(0.5))
          ],
          stops: const [0, 1],
          begin: const AlignmentDirectional(1, 1),
          end: const AlignmentDirectional(-1, -1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (active == false) return;
          widget.selectHandler();
        },
        child: null,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0x00727272)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        color: flashing
                            ? ColorTheme.borderHighlighted
                            : ColorTheme.border,
                        width: 3)))),
      ),
    );
  }
}

class ButtonCollection extends StatefulWidget {
  ButtonCollection(
      {Key? key,
      required this.score,
      required this.incrementCounter,
      required this.started,
      required this.sequence,
      required this.sequenceIndex,
      required this.handleClick,
      required this.setFlashing})
      : super(key: key);

  int score;
  final ValueChanged<int> incrementCounter;
  final bool started;
  final List<int> sequence;
  final int sequenceIndex;
  final Function handleClick;
  final ValueChanged<int> setFlashing;

  @override
  State<ButtonCollection> createState() => ButtonCollectionState();
}

class ButtonCollectionState extends State<ButtonCollection> {
  List<GlobalKey<MyButtonState>> keys = [
    for (int i = 0; i < 9; i++) GlobalKey()
  ];
  late List<MyButton> buttons = [
    for (int i = 0; i < 9; i++)
      MyButton(keys[i], () => {widget.handleClick(i)}, widget.started)
    // MyButton(() => {key: UniqueKey(),widget.handleSequence(i)},false,
    //     color: widget.started == true ? ColorTheme.highlighted : null)
  ];

  void flashButtons(sequence) async {
    for (int i = 0; i < keys.length; i++) {
      keys[i].currentState?.setActive(false);
    }
    await Future.delayed(const Duration(milliseconds: 500), () {});
    for (int index in sequence) {
      keys[index]
          .currentState
          ?.flashButton(const Color.fromARGB(255, 255, 0, 0), 500);
      await Future.delayed(const Duration(milliseconds: 1000), () {});
    }
    // Let all buttons flash green
    for (int i = 0; i < keys.length; i++) {
      keys[i].currentState?.setActive(true);
    }
    widget.setFlashing(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...buttons.getRange(0, 3),
            // for (int i = 0; i < 3; i++)
            //   MyButton(() => {widget.handleSequence(i)},
            //       color:
            //           widget.starsdfsfted == true ? ColorTheme.highlighted : null),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...buttons.getRange(3, 6)],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...buttons.getRange(6, 9)],
        ),
      ],
    );
  }
}
