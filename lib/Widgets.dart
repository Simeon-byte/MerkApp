import 'package:flutter/material.dart';
import 'package:merkapp/theme.dart';
import 'package:merkapp/scoreScreen.dart';
import 'dart:math';

class MyButton extends StatefulWidget {
  final Function selectHandler;
  final Color? color;

  const MyButton(this.selectHandler, {this.color});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorTheme.border, widget.color ?? ColorTheme.grauDunkel],
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
                    side: BorderSide(color: ColorTheme.border, width: 3)))),
      ),
    );
  }
}

class ButtonColumn extends StatefulWidget {
  ButtonColumn({
    Key? key,
    required this.score,
    required this.incrementCounter,
    required this.started,
    required this.sequence,
    required this.sequenceIndex,
    required this.handleSequence,
  }) : super(key: key);

  int score;
  final ValueChanged<int> incrementCounter;
  bool started;

  final List<int> sequence;
  final int sequenceIndex;
  final Function handleSequence;

  void selectHandler(int index) {
    // incrementCounter(1);
    if (index == sequence[sequenceIndex]) {
      handleSequence(true);
    } else {
      handleSequence(false);
    }
  }

  @override
  State<ButtonColumn> createState() => _ButtonColumnState();
}

class _ButtonColumnState extends State<ButtonColumn> {
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
            for (int i = 0; i < 3; i++)
              MyButton(() => {widget.selectHandler(i)},
                  color:
                      widget.started == true ? ColorTheme.highlighted : null),

            // AnimatedContainerApp(),
            // MyButton(() => {widget.incrementCounter(1)},
            //     color: widget.started == true ? ColorTheme.highlighted : null),
            // MyButton(() => {widget.incrementCounter(1)},
            //     color: widget.started == true ? ColorTheme.highlighted : null),
            // MyButton(() => {widget.incrementCounter(1)},
            //     color: widget.started == true ? ColorTheme.highlighted : null),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 3; i < 6; i++)
              MyButton(() => {widget.selectHandler(i)},
                  color:
                      widget.started == true ? ColorTheme.highlighted : null),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 6; i < 9; i++)
              MyButton(() => {widget.selectHandler(i)},
                  color:
                      widget.started == true ? ColorTheme.highlighted : null),
          ],
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
