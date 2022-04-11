import 'package:flutter/material.dart';

class ColorTheme {
  static Color grauDunkel = const Color.fromARGB(255, 114, 114, 114);
  static Color grauDunkel2 = const Color.fromARGB(255, 87, 87, 87);
  static Color grauHell = const Color.fromARGB(255, 133, 133, 133);
  static Color border = const Color.fromARGB(255, 27, 27, 27);
  static Color textColor = const Color.fromARGB(255, 22, 22, 22);

  static Color borderHighlighted = const Color.fromARGB(255, 255, 255, 255);
  static Color highlighted = const Color.fromARGB(255, 255, 0, 0);

  static TextStyle bodyText1 = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: Color.fromARGB(255, 48, 48, 48),
      fontFamily: 'Poppins');

  static TextStyle bodyTextMedium = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    fontFamily: 'Poppins',
    color: Color.fromARGB(255, 48, 48, 48),
  );

  static TextStyle bodyTextBoldSmall = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: 'Poppins',
    color: Color.fromARGB(255, 48, 48, 48),
  );

  static TextStyle bodyTextBold = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 30,
    fontFamily: 'Poppins',
    color: Color.fromARGB(255, 22, 22, 22),
  );
  static TextStyle bodyTextVeryBold = const TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 30,
    fontFamily: 'Poppins',
    color: Color.fromARGB(255, 22, 22, 22),
  );

  static TextStyle bodyTextRed = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 30,
      fontFamily: 'Poppins',
      color: const Color.fromARGB(255, 230, 63, 63),
      shadows: [
        Shadow(
          // bottomLeft
          offset: const Offset(-1.5, -1.5),
          color: border,
        ),
        Shadow(
            // bottomRight
            offset: const Offset(1.5, -1.5),
            color: border),
        Shadow(
            // topRight
            offset: const Offset(1.5, 1.5),
            color: border),
        Shadow(
            // topLeft
            offset: const Offset(-1.5, 1.5),
            color: border),
      ]);
}
