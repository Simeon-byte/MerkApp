import 'dart:io';
import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';
import 'dart:async';

class MyButton extends StatefulWidget {
  final Function selectHandler;
  final Color? color;

  MyButton(Key key, this.selectHandler, {this.color}) : super(key: key);
  // const MyButton(Key key,this.selectHandler, this.flashing, {this.color,});

  @override
  State<MyButton> createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  bool flashing = false;
  void flashButton() {
    setState(() {
      flashing = true;
    });

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        flashing = false;
      });
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
            ColorTheme.border,
            flashing
                ? ColorTheme.highlighted
                : (widget.color ?? ColorTheme.grauDunkel)
          ],
          stops: const [0, 1],
          begin: const AlignmentDirectional(1, 1),
          end: const AlignmentDirectional(-1, -1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: () {
          // print("test");
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

class ButtonColumn extends StatefulWidget {
  ButtonColumn(
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
  bool started;
  final List<int> sequence;
  final int sequenceIndex;
  final Function handleClick;
  final ValueChanged<int> setFlashing;

  @override
  State<ButtonColumn> createState() => ButtonColumnState();
}

class ButtonColumnState extends State<ButtonColumn> {
  List<GlobalKey<MyButtonState>> keys = [
    for (int i = 0; i < 9; i++) GlobalKey()
  ];
  late List<MyButton> buttons = [
    for (int i = 0; i < 9; i++)
      MyButton(keys[i], () => {widget.handleClick(i)},
          color: widget.started == true ? ColorTheme.highlighted : null)
    // MyButton(() => {key: UniqueKey(),widget.handleSequence(i)},false,
    //     color: widget.started == true ? ColorTheme.highlighted : null)
  ];

  void flashButtons(sequence) async {
    for (int index in sequence) {
      keys[index].currentState?.flashButton();
      await Future.delayed(const Duration(milliseconds: 1000), () {});
    }
    Future.delayed(const Duration(milliseconds: 50), () {
      widget.setFlashing(0);
    });
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

class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({Key? key}) : super(key: key);

  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.
  final double _width = 50;
  final double _height = 50;
  final Color _color = Colors.green;
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // Use the properties stored in the State class.
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      // Define how long the animation should take.
      duration: const Duration(seconds: 1),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
    );
  }
}
